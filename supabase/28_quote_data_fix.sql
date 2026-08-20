-- ============================================================
-- 28_quote_data_fix.sql
-- "Could not find the 'quote_data' column ... in the schema cache" 해결.
-- quote_data 컬럼을 (없으면) 추가하고 PostgREST 스키마 캐시를 강제 갱신한다.
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================
alter table aim.requests add column if not exists quote_data jsonb;

-- 스키마 캐시 갱신 (이 한 줄이 빠지면 위 컬럼이 있어도 같은 에러가 날 수 있음)
notify pgrst, 'reload schema';
