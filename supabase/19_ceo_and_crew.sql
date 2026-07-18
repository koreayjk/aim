-- ============================================================
-- 19_ceo_and_crew.sql
-- - koreayjk(Moses) 계정: 조직도 직책을 '크루'로 (관리자 권한 role=owner 는 유지)
-- - 조직도 대표(CEO)를 'Sang W Lee' 로 (로그인 없는 org_members 항목)
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================

-- 1) 내 계정은 조직도상 크루로. 관리자(admin) 권한(role='owner')은 그대로 둔다.
update aim.staff set rank = '크루' where email = 'koreayjk@gmail.com';

-- 2) 대표(CEO) = Sang W Lee (로그인하지 않는 조직도 전용 항목)
--    이미 ceo 항목이 있으면 이름만 보정.
insert into aim.org_members(name, title, tier, sort)
select 'Sang W Lee', '대표', 'ceo', 0
where not exists (select 1 from aim.org_members where tier = 'ceo');

update aim.org_members set name = 'Sang W Lee', title = '대표' where tier = 'ceo';
