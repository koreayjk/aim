# Supabase 프로젝트 통합 런북

3개의 Supabase 프로젝트를 **하나(`lnrugwschlcesaaertgc` = aim)** 로 합치고,
프로젝트마다 전용 **스키마(schema)** 를 줘서 데이터가 섞이지 않게 구분합니다.

| 원래 프로젝트 ref      | 역할        | 통합 후 스키마 |
|------------------------|-------------|----------------|
| `lnrugwschlcesaaertgc` | 타깃 (aim)  | `aim`          |
| `igmyfwacvzjkfohgzahi` | 합칠 대상 B | `<projB>` (이름 정하기) |
| `wxdjxzfugfcsocprwmiy` | 합칠 대상 C | `<projC>` (이름 정하기) |

> 비용: Supabase는 **프로젝트(컴퓨트) 단위**로 과금하므로, 3개 → 1개가 되면
> 나머지 2개의 월 컴퓨트 비용($10×2)이 사라집니다.

---

## 0. 준비물
- 각 프로젝트의 **DB 비밀번호** (대시보드 > Settings > Database > Connection string)
- 로컬에 `psql` / `pg_dump` (PostgreSQL 클라이언트). 버전은 15 이상 권장.
- 작업 전 **각 프로젝트 백업** (대시보드 > Database > Backups, 또는 아래 pg_dump 결과 보관)

연결 문자열 형태 (각 프로젝트 Settings > Database 에서 복사):
```
postgresql://postgres:[DB_PASSWORD]@db.<project-ref>.supabase.co:5432/postgres
```

---

## 1. 타깃(aim) 정리 — 기존 테이블을 aim 스키마로 이동
aim 프로젝트 SQL Editor 에서 [`01_aim_to_schema.sql`](./01_aim_to_schema.sql) 실행.
그다음 대시보드 **Settings > API > Exposed schemas** 에 `aim` 추가.

✅ 이 저장소의 `request.html` / `admin.html` 은 이미
`createClient(..., { db: { schema: 'aim' } })` 로 수정돼 있습니다.
**SQL을 먼저 돌린 뒤** 사이트를 배포(머지)하세요.

---

## 2. 합칠 프로젝트 데이터 가져오기 (B, C 각각 반복)

가장 안전하고 깔끔한 방법은 **"원본 스키마 이름을 바꿔서 통째로 옮기기"** 입니다.
원본 프로젝트는 어차피 삭제할 거라 이름을 바꿔도 됩니다.

아래는 프로젝트 B(`igmyfwacvzjkfohgzahi`)를 스키마 `<projB>` 로 옮기는 예시입니다.
값(ref, 비밀번호, 스키마명)만 바꿔 C 도 똑같이 반복하세요.

```bash
# --- 변수 설정 ---
SRC="postgresql://postgres:[B의_DB_PW]@db.igmyfwacvzjkfohgzahi.supabase.co:5432/postgres"
DST="postgresql://postgres:[aim의_DB_PW]@db.lnrugwschlcesaaertgc.supabase.co:5432/postgres"
SCHEMA="projB"   # 원하는 스키마 이름 (영문 소문자 권장: erp, ontact 등)

# (안전) 먼저 어떤 테이블이 있는지 확인
psql "$SRC" -c "select table_name from information_schema.tables where table_schema='public' order by 1;"

# 1) 원본의 public 스키마 이름을 목표 스키마명으로 변경 (원본은 폐기 예정이라 OK)
psql "$SRC" -c "alter schema public rename to \"$SCHEMA\";"
# PostgREST가 public을 찾으므로 빈 public을 다시 만들어 둠 (원본 안정용)
psql "$SRC" -c "create schema if not exists public; grant usage on schema public to anon, authenticated;"

# 2) 그 스키마만 통째로 덤프 (테이블·데이터·제약·인덱스·RLS 포함)
pg_dump "$SRC" --schema="$SCHEMA" --no-owner --no-acl \
  --no-publications --no-subscriptions -f "$SCHEMA.sql"

# 3) 타깃(aim)으로 적재 — CREATE SCHEMA 부터 들어있어 그대로 생성됨
psql "$DST" -f "$SCHEMA.sql"
```

> ℹ️ `alter schema public rename` 이 부담스러우면, 대신 덤프 파일에서
> `public.` → `projB.` 로 치환하는 방법도 있지만 누락 위험이 있어 위 방식이 더 안전합니다.

그다음 타깃 SQL Editor 에서 [`02_import_source_template.sql`](./02_import_source_template.sql)
의 `<projB>` 를 실제 이름으로 바꿔 실행(권한 부여) 하고,
대시보드 **Settings > API > Exposed schemas** 에 그 스키마를 추가합니다.

---

## 3. 합쳐진 사이트들의 프론트엔드 코드 수정
프로젝트 B, C 를 쓰던 각 저장소(예: 다른 GitHub repo)에서
Supabase 접속 정보를 **타깃(aim) 것으로 교체**하고 스키마를 지정해야 합니다.

```js
// 변경 전 (원래 B 프로젝트)
const sb = supabase.createClient(
  "https://igmyfwacvzjkfohgzahi.supabase.co", "<B의 anon key>");

// 변경 후 (통합된 aim 프로젝트 + B 전용 스키마)
const sb = supabase.createClient(
  "https://lnrugwschlcesaaertgc.supabase.co", "<aim의 anon key>",
  { db: { schema: "projB" } });
```
> aim 프로젝트의 anon key 는 이 저장소 `request.html` 상단의 `SUPABASE_KEY` 와 동일합니다.

---

## 4. ⚠️ 로그인(Auth) 사용자 확인 — 합치기 전 꼭!
스키마는 분리되지만 **로그인 사용자(`auth.users`)는 프로젝트 단위로 공유**됩니다.
- 합칠 프로젝트(B, C)에 **일반 회원가입 사용자**가 있으면, 합친 뒤 aim 의 사용자와 한 풀에 섞입니다.
- 각 프로젝트에서 `Authentication > Users` 의 사용자 수를 확인하세요.
  - **관리자 몇 명뿐 → 그대로 합쳐도 OK**
  - **실사용자 많음 → 합치기 부적합** (그 프로젝트는 단독 유지 권장)
- 사용자도 옮겨야 한다면 별도 절차가 필요합니다(요청 주세요).

---

## 5. 검증 후 원본 삭제
1. 합쳐진 각 사이트가 정상 동작하는지 확인 (조회·등록·로그인).
2. 원본 프로젝트(B, C) 백업을 따로 보관.
3. 문제없으면 대시보드에서 B, C 프로젝트 **Pause → 며칠 관찰 → Delete**.
   (바로 삭제하지 말고 일시정지로 안전 확인 후 삭제 권장)

---

## 체크리스트
- [ ] aim: `01_aim_to_schema.sql` 실행 + Exposed schemas 에 `aim` 추가
- [ ] aim 사이트(request/admin) 배포, 폼 등록·관리자 로그인 정상 확인
- [ ] B: Auth 사용자 수 확인 → 합치기 적합 여부 판단
- [ ] B: 데이터 이전 + 권한 부여 + Exposed schemas 추가
- [ ] B 사이트 코드 접속정보/스키마 교체 후 정상 확인
- [ ] C: 위 B 과정 반복
- [ ] 전체 정상 확인 후 B, C 프로젝트 Pause → Delete
