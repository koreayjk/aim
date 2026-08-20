-- ============================================================
-- 26_dba.sql
-- IM America Group Corp 아래 사업부(DBA) 구분 필드.
-- 기존 프로젝트/의뢰는 모두 '@IM'(IT)으로 귀속.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
alter table aim.requests add column if not exists dba text not null default '@IM';   -- '@IM' | '무역' | '캠프' | '여행'
