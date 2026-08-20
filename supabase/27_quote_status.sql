-- ============================================================
-- 27_quote_status.sql
-- 견적 진행 상태 (견적 관리 화면에서 사용).
--   발행 = 견적번호 발행됨(초안)
--   발송 = 고객에게 보냄
--   수락 = 고객 수락(계약)
--   거절 = 고객 거절/보류
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================
alter table aim.requests add column if not exists quote_status text;   -- null 이면 화면에서 '발행'으로 표시

-- (선택) PostgREST 스키마 캐시 갱신
notify pgrst, 'reload schema';
