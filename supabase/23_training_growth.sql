-- ============================================================
-- 23_training_growth.sql
-- 직원 교육 확장: 콘텐츠 종류(영상/도서/아티클) + 저자 + 대표 한마디.
-- 실행 위치: aim 프로젝트 SQL Editor  (배포 전에 먼저 실행)
-- ============================================================
alter table aim.trainings add column if not exists kind    text not null default 'video';  -- video / book / article
alter table aim.trainings add column if not exists author  text;                            -- 저자 (도서)
alter table aim.trainings add column if not exists ceo_msg text;                            -- 대표 한마디
