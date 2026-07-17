-- ============================================================
-- 12_department.sql
-- 조직도용: 직원의 "소속 부서" + 부서 재직 이력.
-- 엔지니어(팀원)를 여러 부서로 돌려가며 훈련시키기 위해,
-- 현재 부서 + 부서 진입일 + 부서 이동 이력을 저장한다.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================

-- 현재 소속 부서: 개발 / 디자인 / 기획 / 마케팅 / 운영 (NULL = 미배정)
alter table aim.staff add column if not exists department  text;

-- 현재 부서에 들어온 날짜 (재직일수 계산 기준)
alter table aim.staff add column if not exists dept_since  date;

-- 부서 이동 이력: [{"dept":"개발","from":"2026-01-02","to":"2026-03-01"}, ...]
alter table aim.staff add column if not exists dept_history jsonb not null default '[]'::jsonb;

-- 디렉터는 직급에 맞는 부서로 자동 배치 (없을 때만)
update aim.staff set department = '개발'   where rank = '개발 디렉터'   and department is null;
update aim.staff set department = '디자인' where rank = '디자인 디렉터' and department is null;
update aim.staff set department = '기획'   where rank = '기획 디렉터'   and department is null;
update aim.staff set department = '마케팅' where rank = '마케팅 디렉터' and department is null;
update aim.staff set department = '운영'   where rank = '운영 디렉터'   and department is null;

-- 부서가 정해진 사람은 진입일을 오늘로 초기화 (없을 때만)
update aim.staff set dept_since = current_date where department is not null and dept_since is null;
