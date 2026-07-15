-- ============================================================
-- 07_assignee_from_staff.sql
-- 담당자(작업 담당) 목록을 "등록된 직원(staff)"에서 자동으로 가져오도록.
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================

-- 1) 승인된 직원은 팀원 목록(이름)을 읽을 수 있게 정책 확장
--    (기존 staff_self = 본인/오너만 → staff_read = 승인된 직원 전체)
drop policy if exists staff_self on aim.staff;
create policy staff_read on aim.staff for select to authenticated
  using (aim.is_approved() or id = auth.uid());

-- 2) 기존 수동 담당자 목록 비우기 (이제 직원 등록으로 자동 채워짐)
delete from aim.assignees;

-- 3) (선택) 기존 의뢰들에 박혀 있는 옛 담당자도 모두 비우고
--    등록된 직원으로 새로 배정하려면 아래 한 줄의 주석(--)을 지우고 실행:
-- update aim.requests set assignee = null;
