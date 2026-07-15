-- ============================================================
-- 06_task_comments.sql
-- 의뢰별 코멘트 / 진행 히스토리 저장용 컬럼.
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================
alter table aim.requests add column if not exists comments jsonb not null default '[]'::jsonb;
