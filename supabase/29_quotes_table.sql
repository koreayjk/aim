-- ============================================================
-- 29_quotes_table.sql
-- 한 프로젝트(의뢰)에 견적서를 여러 개 만들 수 있도록 별도 테이블로 분리.
-- 각 견적은 고유 번호(quote_no)를 가진다. request_id 로 프로젝트에 연결되며,
-- request_id 가 없으면(독립 견적) 캠프처럼 견적만 발행하는 업무에도 쓸 수 있다.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
create table if not exists aim.quotes (
  id           bigint generated always as identity primary key,
  request_id   bigint references aim.requests(id) on delete set null,
  dba          text not null default '@IM',
  quote_no     text,                       -- 견적번호 (예: Q-2026-0001)
  title        text,                        -- 견적 구분 메모 (예: "옵션 A", "수정본")
  quoted_at    timestamptz not null default now(),
  quote_status text,                        -- 발행 / 발송 / 수락 / 거절 (null = 발행)
  amount       numeric,                     -- 최종 청구액 (견적서 저장 시 자동 기록)
  org_name     text,
  contact_name text,
  email        text,
  phone        text,
  quote_data   jsonb,                       -- 견적 내용(품목·금액·통화 등)
  created_at   timestamptz not null default now()
);
create index if not exists quotes_request_idx on aim.quotes(request_id);

alter table aim.quotes enable row level security;
drop policy if exists q_read  on aim.quotes;
drop policy if exists q_write on aim.quotes;
create policy q_read  on aim.quotes for select to authenticated using (aim.is_approved());
create policy q_write on aim.quotes for all    to authenticated using (aim.is_approved()) with check (aim.is_approved());

-- 기존 requests 에 저장돼 있던 견적을 quotes 로 1회 이전 (중복 방지: 이미 있으면 건너뜀)
insert into aim.quotes (request_id,dba,quote_no,quoted_at,quote_status,amount,org_name,contact_name,email,phone,quote_data)
select r.id, coalesce(r.dba,'@IM'), r.quote_no, coalesce(r.quoted_at, now()), r.quote_status, r.amount,
       r.org_name, r.contact_name, r.email, r.phone, r.quote_data
from aim.requests r
where r.quote_no is not null
  and not exists (select 1 from aim.quotes q where q.request_id = r.id and q.quote_no = r.quote_no);

notify pgrst, 'reload schema';
