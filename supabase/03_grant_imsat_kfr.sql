-- ============================================================
-- 03_grant_imsat_kfr.sql
-- 데이터 이전(pg_dump/psql) 이 끝난 "뒤" 타깃(aim) SQL Editor 에서 실행.
-- imsat / kfr 스키마에 REST API 권한을 부여합니다.
--
--   igmyfwacvzjkfohgzahi -> imsat
--   wxdjxzfugfcsocprwmiy -> kfr
-- ============================================================

-- ----- imsat -----
grant usage on schema imsat to anon, authenticated, service_role;
grant all on all tables    in schema imsat to anon, authenticated, service_role;
grant all on all sequences in schema imsat to anon, authenticated, service_role;
alter default privileges in schema imsat grant all on tables    to anon, authenticated, service_role;
alter default privileges in schema imsat grant all on sequences to anon, authenticated, service_role;

-- ----- kfr -----
grant usage on schema kfr to anon, authenticated, service_role;
grant all on all tables    in schema kfr to anon, authenticated, service_role;
grant all on all sequences in schema kfr to anon, authenticated, service_role;
alter default privileges in schema kfr grant all on tables    to anon, authenticated, service_role;
alter default privileges in schema kfr grant all on sequences to anon, authenticated, service_role;

-- 마지막: 대시보드 Settings > API > Exposed schemas 에 imsat, kfr 추가.
