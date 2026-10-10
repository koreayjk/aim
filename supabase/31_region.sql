-- ============================================================
-- 31_region.sql
-- 프로젝트 지역 구분: 글로벌(GP) / 한국(KP).
--   GP = 글로벌 PM(글로벌 PM rank)이 자동 관리
--   KP = 한국 PM(한국 PM rank)이 자동 관리
-- null 이면 미설정.
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================
alter table aim.requests add column if not exists region text;   -- 'GP' | 'KP' | null

notify pgrst, 'reload schema';
