-- ============================================================
-- 15_rename_assignee.sql
-- 이미 바뀐 직원 이름을 기존 프로젝트에도 일괄 반영 (1회성).
-- 예: 'Moses Yu' → 'SWLee(Moses)'
-- 앞으로의 이름 변경은 어드민이 자동 반영하므로, 이 파일은
-- "코드 반영 전에 이미 바꿔둔 이름"을 정리할 때만 실행하면 된다.
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================

-- 1) 프로젝트 담당자
update aim.requests
set assignee = 'SWLee(Moses)'
where assignee = 'Moses Yu';

-- 2) 할일(체크리스트) 담당자 (jsonb 배열 안의 "a" 필드)
update aim.requests
set checklist = (
  select jsonb_agg(
    case when elem->>'a' = 'Moses Yu'
         then jsonb_set(elem, '{a}', '"SWLee(Moses)"')
         else elem end
  )
  from jsonb_array_elements(checklist) elem
)
where checklist @> '[{"a":"Moses Yu"}]';
