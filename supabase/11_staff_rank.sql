-- ============================================================
-- 11_staff_rank.sql
-- 직원 직급(rank) 추가. 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================
alter table aim.staff add column if not exists rank text not null default '엔지니어';
update aim.staff set rank = '대표' where role = 'owner';
