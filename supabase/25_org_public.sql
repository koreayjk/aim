-- ============================================================
-- 25_org_public.sql
-- 홈페이지 공개 조직도용. 이름·직책·부서만 노출 (이메일 등 민감정보 제외).
-- 익명(anon)도 호출 가능한 SECURITY DEFINER 함수.
-- 실행 위치: aim 프로젝트 SQL Editor
-- ============================================================
create or replace function aim.org_public() returns json
  language sql security definer stable set search_path = aim as $$
  select json_build_object(
    'staff', coalesce((select json_agg(json_build_object('name',name,'rank',rank,'department',department) order by created_at)
                       from aim.staff where status='approved'), '[]'::json),
    'members', coalesce((select json_agg(json_build_object('name',name,'title',title,'scope',scope,'tier',tier) order by tier, sort)
                         from aim.org_members), '[]'::json)
  );
$$;
grant execute on function aim.org_public() to anon, authenticated;
