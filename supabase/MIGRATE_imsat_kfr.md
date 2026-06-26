# imsat / kfr → aim 프로젝트로 합치기 (실행 명령)

| 원본 ref | 프로젝트 | 옮길 스키마 |
|---|---|---|
| `igmyfwacvzjkfohgzahi` | imsat | `imsat` |
| `wxdjxzfugfcsocprwmiy` | kfr   | `kfr`   |
| `lnrugwschlcesaaertgc` | aim (타깃) | — |

---

## ⚠️ 시작 전 필수 확인 — Auth 사용자
imsat, kfr 각각 대시보드 `Authentication > Users` 숫자를 보세요.
- **관리자 몇 명뿐 → 그대로 진행 OK**
- **일반 회원가입 유저 많음 → 합치면 aim 사용자와 섞임** → 합치기 보류/단독 유지 권장

---

## 준비물
- 로컬 터미널에 PostgreSQL 클라이언트(`psql`, `pg_dump`) — 버전 15 이상
  - mac: `brew install postgresql@16`
  - 윈도우: https://www.postgresql.org/download/windows/ 설치 후 `bin` 경로 사용
- 3개 프로젝트의 **DB 비밀번호**
  - 각 프로젝트 대시보드 > Settings > Database > **Connection string** 에서 확인/재설정

> 접속이 안 되면(IPv6 이슈 등) 직접 호스트 대신 **Session pooler** 문자열을 쓰세요:
> `postgresql://postgres.<ref>:[PW]@aws-0-<region>.pooler.supabase.com:5432/postgres`
> (대시보드 Connection string 화면에서 그대로 복사 가능)

---

## STEP 1 — imsat 옮기기 (터미널)

```bash
# 1) 접속 문자열 (대괄호 안 비밀번호만 본인 값으로)
SRC="postgresql://postgres:[imsat_DB_PW]@db.igmyfwacvzjkfohgzahi.supabase.co:5432/postgres"
DST="postgresql://postgres:[aim_DB_PW]@db.lnrugwschlcesaaertgc.supabase.co:5432/postgres"

# 2) (확인용) imsat 에 어떤 테이블이 있는지 보기
psql "$SRC" -c "select table_name from information_schema.tables where table_schema='public' order by 1;"

# 3) 원본의 public 스키마를 imsat 으로 이름 변경 (원본은 곧 삭제할 거라 OK)
psql "$SRC" -c 'alter schema public rename to imsat; create schema public; grant usage on schema public to anon, authenticated;'

# 4) imsat 스키마만 통째로 덤프 (테이블·데이터·제약·인덱스·RLS 포함)
pg_dump "$SRC" --schema=imsat --no-owner --no-acl --no-publications --no-subscriptions -f imsat.sql

# 5) 타깃(aim)에 적재
psql "$DST" -f imsat.sql
```

## STEP 2 — kfr 옮기기 (터미널)

```bash
SRC="postgresql://postgres:[kfr_DB_PW]@db.wxdjxzfugfcsocprwmiy.supabase.co:5432/postgres"
DST="postgresql://postgres:[aim_DB_PW]@db.lnrugwschlcesaaertgc.supabase.co:5432/postgres"

psql "$SRC" -c "select table_name from information_schema.tables where table_schema='public' order by 1;"
psql "$SRC" -c 'alter schema public rename to kfr; create schema public; grant usage on schema public to anon, authenticated;'
pg_dump "$SRC" --schema=kfr --no-owner --no-acl --no-publications --no-subscriptions -f kfr.sql
psql "$DST" -f kfr.sql
```

## STEP 3 — 권한 부여 + API 노출 (aim 대시보드)
1. aim 프로젝트 SQL Editor 에서 [`03_grant_imsat_kfr.sql`](./03_grant_imsat_kfr.sql) 실행
2. Settings > API > **Exposed schemas** 에 `imsat`, `kfr` 추가

## STEP 4 — 확인
```sql
-- aim SQL Editor 에서: 옮겨진 테이블이 보이는지
select table_schema, count(*) from information_schema.tables
where table_schema in ('imsat','kfr') group by 1;
```

## STEP 5 — imsat / kfr 사이트 코드 교체
두 사이트(각자의 저장소)에서 Supabase 접속 정보를 aim 것으로 바꾸고 스키마 지정:

```js
// imsat 사이트
const sb = supabase.createClient(
  "https://lnrugwschlcesaaertgc.supabase.co", "<aim의 anon key>",
  { db: { schema: "imsat" } });

// kfr 사이트
const sb = supabase.createClient(
  "https://lnrugwschlcesaaertgc.supabase.co", "<aim의 anon key>",
  { db: { schema: "kfr" } });
```
> aim 의 anon key 는 이 저장소 `request.html` 상단 `SUPABASE_KEY` 와 동일.

## STEP 6 — 정리
1. imsat, kfr 사이트가 정상 동작하는지 확인 (조회·등록·로그인)
2. 원본 프로젝트(imsat, kfr) **Pause** → 며칠 관찰 → **Delete**
3. 완료 시 월 컴퓨트 $10 × 2 절감
