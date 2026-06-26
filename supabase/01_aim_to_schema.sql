-- ============================================================
-- 01_aim_to_schema.sql
-- 타깃 프로젝트(lnrugwschlcesaaertgc = aim)에서 실행.
-- aim 의 기존 테이블(public)을 전용 스키마 "aim" 으로 옮겨
-- 앞으로 합쳐질 다른 프로젝트와 명확히 구분합니다.
--
-- 실행 위치: Supabase 대시보드 > SQL Editor (aim 프로젝트)
-- 주의: 아래 SQL을 먼저 실행한 "다음에" 새 코드(request.html / admin.html)를 배포하세요.
--       순서가 바뀌면 잠깐 동안 폼/관리자 페이지가 동작하지 않습니다.
-- ============================================================

-- 1) 전용 스키마 생성
create schema if not exists aim;

-- 2) 기존 테이블을 aim 스키마로 이동 (데이터·인덱스·제약·RLS 정책 그대로 유지됨)
alter table if exists public.requests   set schema aim;
alter table if exists public.assignees  set schema aim;

-- 3) PostgREST(REST API) 권한 부여
grant usage on schema aim to anon, authenticated, service_role;
grant all on all tables    in schema aim to anon, authenticated, service_role;
grant all on all sequences in schema aim to anon, authenticated, service_role;

-- 4) 앞으로 만들 테이블에도 같은 권한이 자동 적용되도록
alter default privileges in schema aim
  grant all on tables    to anon, authenticated, service_role;
alter default privileges in schema aim
  grant all on sequences to anon, authenticated, service_role;

-- ============================================================
-- 5) 마지막 단계 (SQL 아님 / 대시보드에서):
--    Settings > API > "Exposed schemas" 에 aim 을 추가하고 저장.
--    (public, graphql_public 외에 aim 을 체크/입력)
--    이걸 해야 supabase-js 의 { db: { schema: 'aim' } } 호출이 동작합니다.
-- ============================================================
