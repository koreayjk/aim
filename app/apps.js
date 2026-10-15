/* ====================================================
   @IM 앱 목록 — app/index.html(목록)과 app/detail.html(소개)이 함께 사용
   - 스토어에 올라가면 appStore / playStore 에 주소를 넣으면 버튼이 켜집니다.
     (비워두면 "출시 예정"으로 표시)
   - url 은 웹 버전 주소 (소개 페이지의 "웹 버전 열기" 링크)
   - 새 앱: 아래 형식으로 항목 추가, id 는 영문 소문자로 고유하게
   ==================================================== */
window.APPS = [
  {
    id: "imnewsroom",
    name: "IM Newsroom",
    loc: { ko: "AI 편집국 · 언론사 플랫폼", en: "AI newsroom for publishers" },
    path: "imnewsroom.com",
    url: "https://imnewsroom.com/",
    appStore: "", playStore: "",
    cover: "",
    tags: ["웹앱", "뉴스 · 미디어", "2026"], tagsEn: ["Web app", "News · Media", "2026"],
    tagline: { ko: "보도자료 수집부터 AI 초안, 승인, 송고까지 한 번에", en: "From press releases to AI drafts, approval and publishing in one place" },
    desc: {
      ko: "인터넷 신문사와 여러 매체를 운영하는 발행인을 위한 클라우드 AI 편집국입니다. 보도자료를 자동으로 모으고, AI가 기사 초안과 법적 검수를 돕고, 승인된 기사를 여러 매체에 한 번에 송고합니다.",
      en: "A cloud AI newsroom for online newspapers and publishers running several outlets. It gathers press releases automatically, helps with AI drafts and legal checks, and publishes approved stories to multiple outlets at once."
    },
    features: [
      { t: { ko: "보도자료 자동 수집", en: "Automatic press-release intake" }, d: { ko: "뉴스와이어·정책브리핑·기자 메일함에서 30분마다 보도자료를 자동으로 모읍니다.", en: "Collects press releases every 30 minutes from wire services, government briefings and reporters' inboxes." } },
      { t: { ko: "AI 기사 초안 + 법적 검수", en: "AI drafts + legal check" }, d: { ko: "사실을 덧붙이지 않는 AI 초안을 만들고, 명예훼손·저작권·개인정보 위험을 미리 점검합니다.", en: "Writes AI drafts that add no unstated facts and flags defamation, copyright and privacy risks." } },
      { t: { ko: "기자 → 편집장 승인 흐름", en: "Reporter → editor approval" }, d: { ko: "기자가 쓰고 편집장이 승인하면 바로 출고됩니다. 역할별 권한으로 안전하게 운영합니다.", en: "Reporters write, editors approve, then it publishes, with role-based permissions." } },
      { t: { ko: "여러 매체 동시 송고", en: "Publish to multiple outlets" }, d: { ko: "한 계정으로 여러 매체를 운영하고, 매체마다 다른 역할을 주며 동시에 송고합니다.", en: "Run several outlets from one account with different roles per outlet, publishing to all at once." } },
      { t: { ko: "네이버·구글 검색 등록", en: "Naver & Google search setup" }, d: { ko: "네이버·구글 검색 등록을 대행하고 구글 뉴스 형식을 자동으로 맞춥니다.", en: "We register your site with Naver and Google search and apply Google News markup automatically." } },
      { t: { ko: "뉴스레터 · 홈 편집 · 보안", en: "Newsletter, layout & security" }, d: { ko: "뉴스레터 발송, 홈페이지 편집판, 2단계 인증, 고객센터까지 기본으로 들어 있습니다.", en: "Newsletters, a homepage layout editor, two-factor login and a built-in help desk come standard." } },
    ],
    audience: { ko: ["인터넷 신문사", "여러 매체를 운영하는 발행인", "편집국장 · 기자"], en: ["Online newspapers", "Multi-outlet publishers", "Editors · reporters"] },
  },
  {
    id: "imvoca",
    name: "IM VOCA",
    loc: { ko: "AI 영어 원서 단어장", en: "AI vocabulary from real books" },
    path: "imvoca.app",
    url: "https://www.imvoca.app/",
    appStore: "", playStore: "",
    cover: "https://imvoca.app/og-image.png",
    tags: ["AI 앱", "교육 · 단어장", "2026"], tagsEn: ["AI app", "Education", "2026"],
    tagline: { ko: "책 한 페이지를 찍으면, AI가 외울 단어를 골라 복습까지", en: "Snap a book page; AI picks the words and schedules your reviews" },
    desc: {
      ko: "영어 원서를 읽는 학생과 학원을 위한 AI 단어장입니다. 사진 한 장으로 어려운 단어를 뽑아 문맥 속 뜻을 알려주고, 잊기 전에 복습하도록 일정을 잡아줍니다. (특허 출원)",
      en: "An AI vocabulary app for students reading English books and the academies that teach them. One photo pulls out the hard words with their meaning in context, then schedules reviews before you forget. (Patent pending)"
    },
    features: [
      { t: { ko: "사진으로 AI 단어 추출", en: "AI word extraction from photos" }, d: { ko: "책 페이지를 찍으면 AI가 단어를 골라 뜻·발음·예문·난이도(CEFR)까지 정리합니다.", en: "Photograph a page and AI picks words with meaning, pronunciation, examples and CEFR level." } },
      { t: { ko: "30일 6회 자동 복습", en: "6 reviews in 30 days" }, d: { ko: "기억이 흐려지기 전에 30일 동안 6번 복습하도록 자동으로 일정을 잡습니다.", en: "Automatically schedules six spaced reviews over 30 days, right before you'd forget." } },
      { t: { ko: "수능 · 토익 · 토플 단어장", en: "Exam wordbooks" }, d: { ko: "수능·토익·토플 공식 단어장을 바로 불러와 함께 공부할 수 있습니다.", en: "Load official wordbooks for the Korean CSAT, TOEIC and TOEFL." } },
      { t: { ko: "단어 시험 출제", en: "Word tests for teachers" }, d: { ko: "선생님이 시험을 내면 온라인 자동 채점 또는 종이 PDF로 출력하고, 재시험도 관리합니다.", en: "Teachers assign tests graded online or printed as PDF, with retests tracked." } },
      { t: { ko: "엑셀 · CSV 가져오기", en: "Excel / CSV import" }, d: { ko: "가지고 있던 단어 목록을 엑셀·CSV 파일로 한 번에 불러옵니다.", en: "Bring in existing word lists from Excel or CSV files in one go." } },
      { t: { ko: "학원 단체 이용 · 5개 언어", en: "Academy plans · 5 languages" }, d: { ko: "학원 단위로 학생을 관리하고, 한국어·영어·일본어·중국어·스페인어 화면을 지원합니다.", en: "Manage students as an academy, with Korean, English, Japanese, Chinese and Spanish interfaces." } },
    ],
    audience: { ko: ["영어 원서를 읽는 학생", "영어 학원 · 선생님", "수능 · 토익 · 토플 준비생"], en: ["Students reading English books", "English academies · teachers", "CSAT · TOEIC · TOEFL learners"] },
  },
  {
    id: "tcs",
    name: "TCS — Total Care System",
    loc: { ko: "교육 공동체 통합 플랫폼", en: "All-in-one school community platform" },
    path: "koreayjk.github.io/imessenger",
    url: "https://koreayjk.github.io/imessenger/",
    appStore: "", playStore: "",
    cover: "",
    tags: ["앱", "학교 · 메신저", "2026"], tagsEn: ["App", "School · Messenger", "2026"],
    tagline: { ko: "학생 한 명 한 명을 온전히 품는 교육 공동체 플랫폼", en: "A school community platform that cares for every student as a whole person" },
    desc: {
      ko: "대안학교 등 교육 공동체를 위한 통합 플랫폼입니다. 교사·직원·학생·학부모가 한 곳에서 소통하고, 학생의 성적·활동·신앙까지 함께 기록하고 돌봅니다.",
      en: "An all-in-one platform for school communities such as alternative schools. Teachers, staff, students and parents communicate in one place while each student's grades, activities and faith life are recorded together."
    },
    features: [
      { t: { ko: "공동체별 독립 공간", en: "A private space per community" }, d: { ko: "학교·공동체마다 독립된 공간을 만들어 안전하게 운영합니다.", en: "Each school or community gets its own separate, secure space." } },
      { t: { ko: "학생 종합 기록부", en: "Whole-student records" }, d: { ko: "학생 한 명의 기록을 한 곳에 모아 종합 기록부(생기부)로 관리합니다.", en: "Keeps everything about each student in one comprehensive record." } },
      { t: { ko: "실시간 메신저", en: "Real-time messenger" }, d: { ko: "채널·1:1 대화·투표, 신고·차단까지 갖춘 교사·학생·학부모 메신저입니다.", en: "Channels, 1:1 chat and polls, with report and block, for teachers, students and parents." } },
      { t: { ko: "성적 · 활동 · 신앙 통합 관리", en: "Grades, activities & faith" }, d: { ko: "성적과 활동은 물론 기도제목·묵상·필독서까지 함께 관리합니다.", en: "Tracks grades and activities alongside prayer requests, daily devotion and required reading." } },
      { t: { ko: "일정 · 출결 · 시간표", en: "Calendar, attendance & timetable" }, d: { ko: "구글 캘린더 연동 일정, 출결 신청, 시간표를 한 화면에서 봅니다.", en: "Google Calendar sync, absence requests and timetables on one screen." } },
      { t: { ko: "학교 생활 · 행정 도구", en: "School life & admin tools" }, d: { ko: "예치금·매점·용돈기입장·전자결재, 모의고사 AI 분석까지 지원합니다.", en: "Deposits, school store, allowance log, e-approval and AI mock-exam analysis." } },
    ],
    audience: { ko: ["대안학교 · 기독학교", "교사 · 교직원", "학생 · 학부모"], en: ["Alternative & Christian schools", "Teachers · staff", "Students · parents"] },
  },
  {
    id: "into-consult",
    name: "인투유학 상담 시스템",
    loc: { ko: "유학 상담 접수 · 기록 · 예약", en: "Study-abroad consultation tracker" },
    path: "koreayjk.github.io/into/cons",
    url: "https://koreayjk.github.io/into/cons",
    appStore: "", playStore: "",
    cover: "",
    tags: ["웹앱", "상담관리 · CRM", "2026"], tagsEn: ["Web app", "Consulting CRM", "2026"],
    tagline: { ko: "상담 예약부터 1·2차 상담 기록, 진행 결정까지 한 차트로", en: "From booking to first and second consultations and decisions, in one chart" },
    desc: {
      ko: "인투유학센터 상담 선생님을 위한 상담 차트입니다. 상담 일정과 신청을 관리하고, 학생별 상담 내용과 진행 여부를 한눈에 추적합니다.",
      en: "A consultation chart for INTO Study Abroad Center counselors. It manages bookings and requests and tracks every student's consultations and decisions at a glance."
    },
    features: [
      { t: { ko: "상담 일정 · 예약 관리", en: "Schedule & bookings" }, d: { ko: "상담 일정을 한 곳에서 보고 예약을 관리합니다.", en: "See and manage all consultation bookings in one place." } },
      { t: { ko: "1차 상담 기록", en: "First-consultation notes" }, d: { ko: "첫 상담 내용을 학생별로 기록합니다.", en: "Record each student's first consultation." } },
      { t: { ko: "2차 상담 작성", en: "Second-consultation form" }, d: { ko: "학년·연락처·유입 경로·상담 요약·결정·후속 조치를 양식대로 남깁니다.", en: "Grade, contact, source, summary, decision and follow-up captured in one form." } },
      { t: { ko: "진행 결정 현황", en: "Decision status" }, d: { ko: "진행 결정·검토 중·재연락·미진행을 숫자로 한눈에 봅니다.", en: "Counts for proceeding, reviewing, call back and not proceeding at a glance." } },
      { t: { ko: "신규 상담 신청 접수", en: "New consultation requests" }, d: { ko: "새로 들어온 상담 신청을 놓치지 않고 접수합니다.", en: "Catch every new consultation request as it arrives." } },
      { t: { ko: "CSV · PDF 출력", en: "CSV / PDF export" }, d: { ko: "상담 기록을 CSV·PDF로 내보내고 관리자 설정으로 운영합니다.", en: "Export records to CSV or PDF, with admin settings." } },
    ],
    audience: { ko: ["유학원 · 상담 선생님", "교육 컨설팅 기관"], en: ["Study-abroad agencies · counselors", "Education consultancies"] },
  },
  {
    id: "x32audio",
    name: "X32 Audio",
    loc: { ko: "교회 음향 자동화 · 데스크톱 앱", en: "Church sound automation · desktop app" },
    path: "koreayjk.github.io/x32audio",
    url: "https://koreayjk.github.io/x32audio/landing/index.html",
    appStore: "", playStore: "",
    cover: "",
    tags: ["데스크톱 앱", "오디오 · 교회", "2026"], tagsEn: ["Desktop app", "Audio · Church", "2026"],
    tagline: { ko: "전문가 없이도 봉사자가 예배 음향을 운영하도록", en: "So church volunteers can run worship sound without an expert" },
    desc: {
      ko: "Behringer X32·M32·X-Air 믹서를 자동화하는 무료 오픈소스(MIT) 데스크톱 앱입니다. Windows와 macOS에서 동작하며, 예배 순서에 맞춘 원터치 장면 전환과 방송 레벨 자동 관리를 지원합니다.",
      en: "A free, open-source (MIT) desktop app that automates Behringer X32, M32 and X-Air mixers on Windows and macOS, with one-touch scenes that follow the order of service and automatic broadcast levels."
    },
    features: [
      { t: { ko: "원터치 장면 · 예배 순서 큐", en: "One-touch scenes · service cues" }, d: { ko: "설교·찬양·기도 장면을 한 번에 바꾸고, 예배 순서를 스페이스바로 넘깁니다.", en: "Switch sermon, worship and prayer scenes in one touch; advance the order of service with the spacebar." } },
      { t: { ko: "3개 출력 동시 관리", en: "Three mixes at once" }, d: { ko: "메인·방송·모니터 출력을 함께 관리합니다.", en: "Manage main, broadcast and monitor mixes together." } },
      { t: { ko: "방송 자동 레벨 · 설교 모드", en: "Auto broadcast level · sermon mode" }, d: { ko: "유튜브 기준 LUFS −14로 방송 음량을 맞추고, 설교 때는 방송의 악기 소리만 줄입니다.", en: "Holds broadcasts at YouTube's LUFS −14 and lowers instruments on the stream during sermons." } },
      { t: { ko: "피드백 감지 · 자동 억제", en: "Feedback detection" }, d: { ko: "하울링을 실시간으로 감지하고 GEQ에서 자동으로 잡아줍니다.", en: "Detects feedback in real time and suppresses it automatically on the GEQ." } },
      { t: { ko: "양방향 페이더 · 마이크 프리셋", en: "Two-way faders · mic presets" }, d: { ko: "콘솔과 페이더가 양방향으로 연동되고, 사람별 마이크 설정을 저장합니다.", en: "Faders sync both ways with the console; mic settings are saved per person." } },
      { t: { ko: "태블릿 · 폰 원격 조작", en: "Tablet & phone remote" }, d: { ko: "브라우저로 원격 조작하고, 쉬운 봉사자 모드와 한/영 화면을 제공합니다.", en: "Control it from any browser, with an easy volunteer mode and Korean/English UI." } },
    ],
    audience: { ko: ["교회 음향 봉사자", "X32 · M32 · X-Air 사용 교회", "예배 방송 담당자"], en: ["Church sound volunteers", "Churches with X32 / M32 / X-Air", "Worship stream teams"] },
  },
  {
    id: "imsat",
    name: "SAT 오답 진단 시스템",
    loc: { ko: "AI 채점 · 오답 진단 · 문제 출제", en: "AI grading, error diagnosis & test builder" },
    path: "koreayjk.github.io/imsat",
    url: "https://koreayjk.github.io/imsat/",
    appStore: "", playStore: "",
    cover: "",
    tags: ["웹앱", "교육 · AI 진단", "2026"], tagsEn: ["Web app", "Edu · AI", "2026"],
    tagline: { ko: "답안지를 찍으면 채점부터 오답 분석, 맞춤 문제까지", en: "Snap the answer sheet: grading, error analysis and targeted practice" },
    desc: {
      ko: "인투유학센터 선생님을 위한 SAT 오답 진단 도구입니다. AI가 답안지를 채점하고 틀린 이유를 분석해, 학생의 약점에 맞춘 문제와 오답노트를 만들어 줍니다.",
      en: "An SAT wrong-answer diagnosis tool for INTO Study Abroad Center teachers. AI grades answer sheets, analyzes why answers were wrong, and builds practice and error notebooks around each student's weak spots."
    },
    features: [
      { t: { ko: "OMR 사진 → AI 자동 채점", en: "Photo → AI grading" }, d: { ko: "답안지와 정답 사진을 올리면 AI가 읽고 자동으로 채점합니다.", en: "Upload photos of the answer sheet and key; AI reads and grades them." } },
      { t: { ko: "틀린 문제 자동 추출", en: "Missed questions pulled out" }, d: { ko: "교재 페이지를 찍으면 틀린 문항만 골라 냅니다.", en: "Photograph workbook pages and AI extracts only the missed questions." } },
      { t: { ko: "오답 진단 · 추세 분석", en: "Error diagnosis & trends" }, d: { ko: "왜 틀렸는지 진단하고, 학생별 오답 유형과 점수 추세를 보여줍니다.", en: "Diagnoses why each answer was wrong and shows error types and score trends per student." } },
      { t: { ko: "AI SAT 문제 출제", en: "AI-built SAT tests" }, d: { ko: "적응형 2모듈을 포함해 문제·정답·해설까지 AI가 만듭니다.", en: "AI writes questions, answers and explanations, including adaptive two-module tests." } },
      { t: { ko: "약점 맞춤 출제 · 오답노트 PDF", en: "Weak-area tests · error notebook" }, d: { ko: "약한 유형 위주로 문제를 내고 오답노트를 PDF로 출력합니다.", en: "Generates tests from weak areas and prints error notebooks as PDF." } },
      { t: { ko: "출제 보관함 · 수업 포인트", en: "Test archive · teaching points" }, d: { ko: "지난 시험을 보관하고, 선생님을 위한 수업 포인트를 정리합니다.", en: "Archives past tests and summarizes teaching points for teachers." } },
    ],
    audience: { ko: ["SAT 학원 · 유학원 선생님", "SAT 준비생"], en: ["SAT academy & agency teachers", "SAT students"] },
  },
  {
    id: "seaflow",
    name: "SeaFlow ERP",
    loc: { ko: "한국형 AI 포워딩 ERP", en: "AI freight-forwarding ERP for Korea" },
    path: "koreayjk.github.io/erp",
    url: "https://koreayjk.github.io/erp/seaflow-landing.html",
    appStore: "", playStore: "",
    cover: "",
    tags: ["웹앱", "물류 · ERP", "2026"], tagsEn: ["Web app", "Logistics · ERP", "2026"],
    tagline: { ko: "서류 입력 10분을 30초로 줄이는 포워딩 ERP", en: "Forwarding ERP that turns 10 minutes of data entry into 30 seconds" },
    desc: {
      ko: "한국 포워딩(국제 물류) 회사를 위한 AI ERP입니다. 화주 서류를 AI가 읽어 자동 입력하고, 선사 연동·화물 추적·한국 세무까지 한국어로 처리합니다.",
      en: "An AI ERP for Korean freight forwarders. AI reads shipper documents and fills in the data, with carrier integrations, cargo tracking and Korean tax workflows, all in Korean."
    },
    features: [
      { t: { ko: "AI 서류 자동 입력", en: "AI document entry" }, d: { ko: "이메일·엑셀·PDF·이미지 등 어떤 서류든 AI가 읽어 필드를 채웁니다.", en: "AI reads any shipper document (email, Excel, PDF or image) and fills in the fields." } },
      { t: { ko: "선사 API 연동", en: "Carrier API integration" }, d: { ko: "HMM·Maersk 등 선사 스케줄과 운임을 자동으로 가져옵니다.", en: "Pulls schedules and rates from carriers such as HMM and Maersk." } },
      { t: { ko: "실시간 화물 추적 · 알림톡", en: "Live tracking · Kakao alerts" }, d: { ko: "컨테이너를 실시간 추적하고 지연 시 화주에게 카카오 알림톡을 보냅니다.", en: "Tracks containers in real time and sends KakaoTalk alerts to shippers on delays." } },
      { t: { ko: "한국 세무 완비", en: "Korean tax built in" }, d: { ko: "전자세금계산서, 관세사 EDI, 원화 정산을 지원합니다.", en: "Electronic tax invoices, customs-broker EDI and KRW settlement." } },
      { t: { ko: "화주 전용 포털", en: "Shipper portal" }, d: { ko: "화주가 직접 자기 화물을 조회하는 전용 포털을 제공합니다.", en: "A portal where shippers check their own cargo." } },
      { t: { ko: "100% 한국어", en: "Fully in Korean" }, d: { ko: "모든 화면이 한국어로 되어 있어 바로 쓸 수 있습니다.", en: "Every screen is in Korean, ready to use from day one." } },
    ],
    audience: { ko: ["포워딩 · 국제 물류 회사", "수출입 화주"], en: ["Freight forwarders", "Importers · exporters"] },
  },
  {
    id: "imcms",
    name: "IM CMS",
    loc: { ko: "언론사 콘텐츠 관리 시스템", en: "Content management for publishers" },
    path: "koreayjk.github.io/imcms",
    url: "https://koreayjk.github.io/imcms/",
    appStore: "", playStore: "",
    cover: "",
    tags: ["웹앱", "CMS · 콘텐츠", "2026"], tagsEn: ["Web app", "CMS", "2026"],
    tagline: { ko: "IM 뉴스룸을 움직이는 언론사용 CMS", en: "The publisher CMS that powers IM Newsroom" },
    desc: {
      ko: "IM 뉴스룸의 기반이 되는 언론사 콘텐츠 관리 시스템입니다. 더케어타임즈·Shipping Times·이스라엘투데이·에듀와이드 등 여러 매체가 이 위에서 운영됩니다.",
      en: "The content management system behind IM Newsroom. Outlets such as The Care Times, Shipping Times, Israel Today and Eduwide run on it."
    },
    features: [
      { t: { ko: "기존 CMS 자료 가져오기", en: "Import from other CMSs" }, d: { ko: "다른 CMS의 기사를 옮겨오고, 예전 기사 주소는 새 주소로 자동 연결합니다.", en: "Migrates articles from other CMSs and redirects old article URLs automatically." } },
      { t: { ko: "자료 내보내기", en: "Full export" }, d: { ko: "모든 기사를 JSON·CSV로, 사진은 ZIP으로 내보낼 수 있습니다.", en: "Export every article as JSON/CSV and all photos as ZIP." } },
      { t: { ko: "계정 보안", en: "Account security" }, d: { ko: "로그인 기록, 모든 기기 로그아웃, 2단계 인증을 지원합니다.", en: "Login history, sign out of all devices and two-factor login." } },
      { t: { ko: "퇴사자 접근 차단", en: "Offboarding" }, d: { ko: "퇴사한 직원의 접근을 바로 막습니다.", en: "Cut off access for former staff instantly." } },
      { t: { ko: "결제 · 청구서 관리", en: "Billing & invoices" }, d: { ko: "Stripe 결제, 청구서 발행, 미납 처리를 자동으로 관리합니다.", en: "Stripe payments, invoices and overdue handling, automated." } },
      { t: { ko: "금칙어 · AI 발행 전 검사", en: "Banned words · AI pre-publish check" }, d: { ko: "금칙어를 걸러내고 발행 전에 AI가 한 번 더 점검합니다.", en: "Filters banned words and runs an AI check before anything goes live." } },
    ],
    audience: { ko: ["인터넷 신문사", "매체 운영팀 · 개발팀"], en: ["Online newspapers", "Publishing & tech teams"] },
  },
  {
    id: "imged",
    name: "IM GED",
    loc: { ko: "GED 자율학습 · AI 로드맵", en: "GED self-study with an AI roadmap" },
    path: "koreayjk.github.io/imged",
    url: "https://koreayjk.github.io/imged/",
    appStore: "", playStore: "",
    cover: "",
    tags: ["앱", "교육 · 시험대비", "2026"], tagsEn: ["App", "Education · Test prep", "2026"],
    tagline: { ko: "내 일정에 맞춘 자동 로드맵으로 GED 합격까지", en: "An automatic roadmap built around your timeline, all the way to passing the GED" },
    desc: {
      ko: "INTO GLOBAL과 함께하는 GED 자율학습 프로그램입니다. Khan Academy 강의, 자체 문제은행, AI 에세이 채점으로 학생이 혼자서도 꾸준히 공부하도록 돕습니다.",
      en: "A GED self-study program with INTO GLOBAL. Khan Academy lessons, our own question bank and AI essay scoring help students keep studying steadily on their own."
    },
    features: [
      { t: { ko: "기간별 자동 로드맵", en: "Automatic study roadmap" }, d: { ko: "속성·1년·2년·3년 등 목표 기간에 맞춰 날짜별 학습 계획을 자동으로 짭니다.", en: "Builds a day-by-day plan for a fast-track, 1-, 2- or 3-year goal." } },
      { t: { ko: "과목별 배치 테스트", en: "Placement tests" }, d: { ko: "기초·중급·상급 배치 테스트로 시작 수준을 정합니다.", en: "Basic, intermediate and advanced placement tests set each starting level." } },
      { t: { ko: "GED 맞춤 Khan Academy 강의", en: "Curated Khan Academy lessons" }, d: { ko: "GED 범위에 맞는 강의만 골라 보여주고, 90% 이상 시청하면 완료로 기록합니다.", en: "Shows only GED-scope videos and marks a lesson done after 90% is watched." } },
      { t: { ko: "AI 에세이 채점", en: "AI essay scoring" }, d: { ko: "GED 3가지 평가 기준으로 에세이를 채점하고 모국어로 설명해 줍니다.", en: "Scores essays on the GED 3-trait rubric and explains in the student's native language." } },
      { t: { ko: "문제은행 + 복습 큐", en: "Question bank + review queue" }, d: { ko: "사람이 검수한 문제를 풀고, 틀린 문제는 1·3·7·21일 뒤에 다시 나옵니다.", en: "Human-reviewed questions; missed ones return after 1, 3, 7 and 21 days." } },
      { t: { ko: "관리자 학습 현황", en: "Progress dashboard" }, d: { ko: "연속 학습·약점·시청 시간을 보고 도움이 필요한 학생을 일찍 찾아냅니다.", en: "Streaks, weak skills and watch time help staff spot students who need help early." } },
    ],
    audience: { ko: ["GED 준비생", "검정고시 · 유학 준비 학생", "교육 기관 · 학원"], en: ["GED candidates", "Students preparing to study abroad", "Schools & academies"] },
  },
];
