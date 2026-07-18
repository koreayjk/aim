-- ============================================================
-- 21_fix_training_name.sql
-- 이미 이름을 바꾸기 전에 교육 완료/댓글에 박힌 옛 이름을
-- 현재 계정 이름으로 정리. (koreayjk 계정 기준)
-- 옛 이름: 'Sang W Lee (Moses)'  →  현재 aim.staff 의 이름
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================

-- 1) 수강 완료자(done_by)
update aim.trainings
set done_by = (
  select jsonb_agg(
    case when e->>'name' = 'Sang W Lee (Moses)'
         then jsonb_set(e, '{name}', to_jsonb((select name from aim.staff where email='koreayjk@gmail.com')))
         else e end)
  from jsonb_array_elements(done_by) e)
where done_by @> '[{"name":"Sang W Lee (Moses)"}]';

-- 2) 느낀점 댓글(notes)
update aim.trainings
set notes = (
  select jsonb_agg(
    case when e->>'who' = 'Sang W Lee (Moses)'
         then jsonb_set(e, '{who}', to_jsonb((select name from aim.staff where email='koreayjk@gmail.com')))
         else e end)
  from jsonb_array_elements(notes) e)
where notes @> '[{"who":"Sang W Lee (Moses)"}]';
