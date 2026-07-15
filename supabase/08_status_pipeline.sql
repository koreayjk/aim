-- ============================================================
-- 08_status_pipeline.sql
-- 작업 단계를 7단계 → 4단계(접수·견적·제작중·완료)로 정리하면서
-- 기존 의뢰들의 status 값을 새 단계로 이전.
-- 실행 위치: aim 프로젝트 SQL Editor
--   ⚠️ 이 SQL을 먼저 실행한 뒤 새 admin.html 을 배포하세요.
-- ============================================================
update aim.requests set status = case status
  when '대기'     then '접수'
  when '검토완료' then '접수'
  when '견적발송' then '견적'
  when '제작중'   then '제작중'
  when '제작완료' then '제작중'
  when '컨펌'     then '제작중'
  when '확정'     then '완료'
  else status
end;
