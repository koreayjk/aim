-- ============================================================
-- 05_staff_approval.sql
-- 직원 회원가입 + 사장님 승인 시스템
-- 실행 위치: aim 프로젝트 SQL Editor
--
-- ⚠️ 실행 전 조건:
--   1) 사장님 계정(ij1481534943@gmail.com)이 Authentication > Users 에 이미 있어야 함
--      (없으면 먼저 Add user 로 생성)
--   2) 이 SQL을 먼저 실행한 "뒤" 새 admin.html 을 배포할 것
--      (순서가 바뀌면 사장님도 승인 대기로 잠깁니다)
-- ============================================================

-- 1) 직원 테이블
create table if not exists aim.staff (
  id         uuid primary key references auth.users(id) on delete cascade,
  email      text,
  name       text,
  role       text not null default 'staff',    -- 'owner' | 'staff'
  status     text not null default 'pending',  -- 'pending' | 'approved' | 'rejected'
  created_at timestamptz not null default now()
);

-- 2) 판별 함수 (SECURITY DEFINER → staff 정책의 무한재귀 방지)
create or replace function aim.is_approved() returns boolean
  language sql security definer stable set search_path = aim as $$
  select exists(select 1 from aim.staff where id = auth.uid() and status = 'approved');
$$;
create or replace function aim.is_owner() returns boolean
  language sql security definer stable set search_path = aim as $$
  select exists(select 1 from aim.staff where id = auth.uid() and role = 'owner');
$$;
grant execute on function aim.is_approved() to anon, authenticated;
grant execute on function aim.is_owner()    to anon, authenticated;

-- 3) 신규 가입 시 staff 행 자동 생성 (대기 상태)
create or replace function aim.handle_new_user() returns trigger
  language plpgsql security definer set search_path = aim as $$
begin
  insert into aim.staff(id, email, name)
  values (new.id, new.email, new.raw_user_meta_data->>'name')
  on conflict (id) do nothing;
  return new;
end $$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function aim.handle_new_user();

-- 4) 사장님 계정 등록 (owner / approved)
insert into aim.staff(id, email, name, role, status)
select id, email, coalesce(raw_user_meta_data->>'name','관리자'), 'owner', 'approved'
from auth.users where email = 'ij1481534943@gmail.com'
on conflict (id) do update set role = 'owner', status = 'approved';

-- 5) staff 테이블 RLS
alter table aim.staff enable row level security;
drop policy if exists staff_self          on aim.staff;
drop policy if exists staff_owner_update  on aim.staff;
create policy staff_self on aim.staff for select to authenticated
  using (id = auth.uid() or aim.is_owner());
create policy staff_owner_update on aim.staff for update to authenticated
  using (aim.is_owner()) with check (aim.is_owner());
-- insert 는 트리거(definer)가 처리하므로 별도 정책 불필요

-- 6) requests / assignees 정책 재정비
--    - 공개 의뢰 폼: 누구나 insert 유지
--    - 조회/수정/삭제: "승인된 직원"만
do $$ declare p record; begin
  for p in select policyname from pg_policies where schemaname='aim' and tablename='requests' loop
    execute format('drop policy %I on aim.requests', p.policyname);
  end loop;
  for p in select policyname from pg_policies where schemaname='aim' and tablename='assignees' loop
    execute format('drop policy %I on aim.assignees', p.policyname);
  end loop;
end $$;
alter table aim.requests  enable row level security;
alter table aim.assignees enable row level security;

create policy req_public_insert on aim.requests for insert to anon, authenticated with check (true);
create policy req_staff_select  on aim.requests for select to authenticated using (aim.is_approved());
create policy req_staff_update  on aim.requests for update to authenticated using (aim.is_approved()) with check (aim.is_approved());
create policy req_staff_delete  on aim.requests for delete to authenticated using (aim.is_approved());

create policy asg_staff_all on aim.assignees for all to authenticated using (aim.is_approved()) with check (aim.is_approved());
