-- ============================================================
-- 13_crew_rename.sql
-- 직급 '엔지니어' → '크루(Crew)' 로 명칭 변경.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
alter table aim.staff alter column rank set default '크루';
update aim.staff set rank = '크루' where rank = '엔지니어';
