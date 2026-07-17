-- ============================================================
-- 10_stages5.sql
-- 작업 단계를 5단계로: 접수·견적 → 디자인 → 개발 → 검수 → 완료
-- + 단계별 마감일(stage_due) 컬럼 추가
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================

-- 1) 기존 상태를 새 5단계로 이전
update aim.requests set status = case status
  when '접수'   then '접수·견적'
  when '견적'   then '접수·견적'
  when '제작중' then '디자인'   -- 기존 제작중은 일단 디자인으로 (이후 개발/검수로 재배치)
  when '완료'   then '완료'
  else status
end;

-- 2) 단계별 마감일 (예: {"디자인":"2026-08-01","완료":"2026-08-20"})
alter table aim.requests add column if not exists stage_due jsonb not null default '{}'::jsonb;

-- 3) 기존 단일 마감일을 "완료(최종) 마감"으로 이관
update aim.requests
set stage_due = jsonb_build_object('완료', to_char(due_date,'YYYY-MM-DD'))
where due_date is not null and (stage_due ? '완료') = false;
