-- ============================================================
-- 16_org_restructure.sql
-- 부서 5개 → 3개(디자인/테크/마케팅) 개편 + PM 직급 신설
-- + 거버넌스 계층 분리(이사장단 chair / 이사 board).
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================

-- 1) 디렉터 직급 재명명
update aim.staff set rank = '테크 디렉터'     where rank = '개발 디렉터';
update aim.staff set rank = '프로젝트 매니저' where rank = '기획 디렉터';   -- 기획 → PM으로 흡수
update aim.staff set rank = '크루'            where rank = '운영 디렉터';   -- 운영 폐지 → 크루로
-- 디자인 디렉터 / 마케팅 디렉터 는 그대로 유지

-- 2) 크루 소속 부서 재매핑
update aim.staff set department = '테크' where department = '개발';
update aim.staff set department = null  where department in ('기획','운영');
-- 디자인 / 마케팅 은 그대로

-- 3) 디렉터 소속 부서 정렬
update aim.staff set department = '테크'   where rank = '테크 디렉터'   and coalesce(department,'') <> '테크';
update aim.staff set department = '디자인' where rank = '디자인 디렉터' and coalesce(department,'') <> '디자인';
update aim.staff set department = '마케팅' where rank = '마케팅 디렉터' and coalesce(department,'') <> '마케팅';

-- 4) 부서에서 빠진 사람은 재직 시작일 정리
update aim.staff set dept_since = null where department is null and dept_since is not null;

-- 5) 거버넌스 계층 재분류: 이사장/부이사장 = chair, 나머지 이사 = board
update aim.org_members set tier = 'chair' where title in ('이사장','부이사장');
update aim.org_members set tier = 'board' where title = '이사';
