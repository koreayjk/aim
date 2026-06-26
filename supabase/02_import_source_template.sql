-- ============================================================
-- 02_import_source_template.sql
-- 합칠 프로젝트(igmyfwacvzjkfohgzahi, wxdjxzfugfcsocprwmiy)의 데이터를
-- 타깃(aim) 프로젝트로 가져온 "뒤" 권한을 부여하는 SQL.
--
-- 데이터 이전 자체는 SQL 한 줄로 안 되고, pg_dump/psql 로 옮깁니다.
-- 자세한 순서는 같은 폴더의 README.md 를 보세요.
--
-- 아래에서 <projB> 부분을 실제 스키마 이름으로 바꿔 실행하세요.
--   예) igmyfwacvzjkfohgzahi -> 스키마명 "erp"
--       wxdjxzfugfcsocprwmiy -> 스키마명 "ontact"
-- (스키마 이름은 알아보기 쉬운 영문 소문자로. 프로젝트마다 한 번씩 실행)
-- ============================================================

-- 데이터 import 후 권한 부여 (스키마 이름만 바꿔서 프로젝트별로 실행)
grant usage on schema "<projB>" to anon, authenticated, service_role;
grant all on all tables    in schema "<projB>" to anon, authenticated, service_role;
grant all on all sequences in schema "<projB>" to anon, authenticated, service_role;
alter default privileges in schema "<projB>"
  grant all on tables    to anon, authenticated, service_role;
alter default privileges in schema "<projB>"
  grant all on sequences to anon, authenticated, service_role;

-- 그리고 대시보드 Settings > API > Exposed schemas 에 <projB> 추가.
