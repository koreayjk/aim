-- ============================================================
-- 18_trainings.sql
-- 직원 교육(트레이닝) 섹션.
-- 유튜브 영상 + 분야(디자인/테크/마케팅/공통) + 느낀점 댓글 + 수강완료 체크.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
create table if not exists aim.trainings (
  id          bigint generated always as identity primary key,
  category    text not null default '공통',   -- 디자인 / 테크 / 마케팅 / 공통
  title       text not null,
  url         text not null,                  -- 유튜브 링크
  description text,
  required    boolean not null default false, -- 필수 교육 여부
  notes       jsonb   not null default '[]'::jsonb,  -- 느낀점: [{who,text,at,rating}]
  done_by     jsonb   not null default '[]'::jsonb,  -- 수강완료: [{name,at}]
  sort        int     not null default 0,
  created_at  timestamptz not null default now()
);

alter table aim.trainings enable row level security;
drop policy if exists tr_read  on aim.trainings;
drop policy if exists tr_write on aim.trainings;
-- 승인된 직원은 조회 + 댓글/완료 갱신 + 자료 추가 가능 (내부 신뢰 팀 기준, requests 와 동일 정책)
create policy tr_read  on aim.trainings for select to authenticated using (aim.is_approved());
create policy tr_write on aim.trainings for all    to authenticated using (aim.is_approved()) with check (aim.is_approved());
