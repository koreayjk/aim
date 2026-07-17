-- ============================================================
-- 14_org_members.sql
-- 조직도 "거버넌스/자문" 명단 (로그인 계정과 무관).
-- 이사장·공동대표·이사·감사·고문 등, 어드민에 가입하지 않는
-- 선교회 리더십을 이름으로 직접 관리한다.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
create table if not exists aim.org_members (
  id         bigint generated always as identity primary key,
  name       text not null,
  title      text,                                -- 이사장 / 공동대표 / 이사 / 감사 / 고문 등
  scope      text,                                -- 부가: 한국본부 / 필리핀본부 / 미국본부 (선택)
  tier       text not null default 'board',       -- 'board'(이사회·대표단) | 'advisory'(감사·고문, 옆에 독립)
  sort       int  not null default 0,
  created_at timestamptz not null default now()
);

alter table aim.org_members enable row level security;
drop policy if exists orgm_read  on aim.org_members;
drop policy if exists orgm_write on aim.org_members;
-- 승인된 직원은 조회 가능, 추가/수정/삭제는 대표(owner)만
create policy orgm_read  on aim.org_members for select to authenticated using (aim.is_approved());
create policy orgm_write on aim.org_members for all    to authenticated using (aim.is_owner()) with check (aim.is_owner());

-- 초기 명단 (한 번만; 이미 있으면 건너뜀)
insert into aim.org_members(name, title, scope, tier, sort)
select v.name, v.title, v.scope, v.tier, v.sort
from (values
  ('마이클 조 선교사', '이사장',   null,       'board', 0),
  ('레베카 선교사',    '부이사장', null,       'board', 1),
  ('클라라 선교사',    '이사',     '한국본부',  'board', 2),
  ('드보라 선교사',    '이사',     '필리핀본부','board', 3),
  ('줄리엣 선교사',    '이사',     '미국본부',  'board', 4)
) as v(name, title, scope, tier, sort)
where not exists (select 1 from aim.org_members);

-- 이미 '공동대표'로 등록돼 있으면 부이사장으로 변경 (재실행 안전)
update aim.org_members set title = '부이사장' where name = '레베카 선교사' and title = '공동대표';
