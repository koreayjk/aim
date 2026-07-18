-- ============================================================
-- 22_quotes.sql
-- 견적서 번호/발행일 관리용 컬럼.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
alter table aim.requests add column if not exists quote_no   text;         -- 견적번호 (예: Q-2026-0001)
alter table aim.requests add column if not exists quoted_at  timestamptz;  -- 견적서 최초 발행일
alter table aim.requests add column if not exists quote_data jsonb;        -- 견적 내용(품목·금액·통화 등) 저장 → 동일 재현
