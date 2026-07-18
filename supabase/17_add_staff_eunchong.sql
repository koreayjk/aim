-- ============================================================
-- 17_add_staff_eunchong.sql
-- 이전에 가입했지만 직원 목록에 안 보이는 계정을 staff에 등록/보정.
-- 대상: benjamin.leeeunchong08@gmail.com  → 이름 '이은총'
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================

-- 1) (확인) 이 이메일이 auth 에 있는지 먼저 조회.
--    아무 행도 안 나오면 = 가입이 실제로 완료되지 않은 것 → 다시 회원가입 필요.
select id, email, created_at, email_confirmed_at
from auth.users
where email = 'benjamin.leeeunchong08@gmail.com';

-- 2) staff 행이 없으면 생성하고, 있으면 이름/상태를 보정 (이름: 이은총, 승인 상태)
insert into aim.staff(id, email, name, role, status)
select id, email, '이은총', 'staff', 'approved'
from auth.users
where email = 'benjamin.leeeunchong08@gmail.com'
on conflict (id) do update
  set name = '이은총', status = 'approved';
