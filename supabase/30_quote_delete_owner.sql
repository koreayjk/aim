-- ============================================================
-- 30_quote_delete_owner.sql
-- 견적서 삭제는 대표(owner)만 가능하도록 RLS 정책 분리.
--   조회/등록/수정 = 승인된 직원 모두
--   삭제           = 대표(aim.is_owner())만
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================
drop policy if exists q_write on aim.quotes;   -- 기존 "for all"(삭제 포함) 정책 제거

create policy q_insert on aim.quotes for insert to authenticated
  with check (aim.is_approved());
create policy q_update on aim.quotes for update to authenticated
  using (aim.is_approved()) with check (aim.is_approved());
create policy q_delete on aim.quotes for delete to authenticated
  using (aim.is_owner());

notify pgrst, 'reload schema';
