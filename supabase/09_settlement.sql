-- ============================================================
-- 09_settlement.sql
-- 월간 리포트 + 월말 결산(매출 정산)용 컬럼.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
alter table aim.requests add column if not exists amount  numeric;                        -- 계약/매출 금액(원)
alter table aim.requests add column if not exists paid    boolean not null default false;  -- 입금 완료 여부
alter table aim.requests add column if not exists paid_at date;                            -- 입금일 (매출 결산 월 기준)
alter table aim.requests add column if not exists done_at date;                            -- 완료일 (완료 통계 기준)

-- 기존에 이미 '완료' 상태인 의뢰는 완료일이 없으니, 접수일을 완료일로 임시 채움
-- (통계에 바로 잡히도록. 실제 완료일과 다르면 상세에서 수정 가능)
update aim.requests set done_at = created_at::date where status = '완료' and done_at is null;
