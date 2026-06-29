-- ============================================================
-- 04_request_types.sql
-- 제작 의뢰 폼에 "유형"(홈페이지/어플/프로그램/홍보물)을 추가하면서
-- requests 테이블에 두 컬럼을 더합니다.
--
-- 실행 위치: aim 프로젝트 SQL Editor
--   (테이블이 aim 스키마에 있으므로 aim.requests 로 실행)
-- ============================================================

alter table aim.requests add column if not exists request_type text;  -- 홈페이지 / 어플 / 프로그램 / 홍보물
alter table aim.requests add column if not exists details      text;  -- 유형별 상세 답변(앱·프로그램·홍보물)

-- 기존에 들어온 의뢰는 모두 홈페이지였으므로 기본값 채우기
update aim.requests set request_type = '홈페이지' where request_type is null;
