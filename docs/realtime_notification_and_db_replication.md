# 🚀 CareerPlus — 채용포털 성능 개선 프로젝트

레포지토리: [CareerPlus-prj](https://github.com/jiwonseok97/CareerPlus-prj)

## 👋 소개

- 트래픽 증가 상황에서 병목을 먼저 찾고, 원인 기반으로 개선안을 설계하는 백엔드 개발자
- 기능 구현을 넘어 운영 관점(확장성, 장애 대응, 데이터 일관성)까지 고려
- 요구사항 특성에 따라 기술을 선택하고, 대안을 비교해 결정
- 성과 수치뿐 아니라 문제 정의·검증 과정·트레이드오프까지 설명 가능

## 📌 프로젝트 개요

- 프로젝트: CareerPlus (구인구직 사이트)
- 기간: 2024.03 ~ 2024.06 (약 4개월)
- 인원: 4명 (Backend 3 / Frontend 2)
- 형태: 풀스택 과정 팀 프로젝트
- 역할: Backend 도메인 담당 개발 (검색/알림/캐시/DB 라우팅/쿼리 최적화)

## 🎯 담당 도메인

1. 채용 공고 도메인
- 공고 등록/수정/삭제 CRUD
- 공고 검색(키워드/조건/정렬)
- 조회수/관심공고 처리
- 메인 공고 리스트 성능 개선

2. 프리랜서 도메인
- 프로필 등록/수정
- 기술 스택 기반 검색
- 매칭 조건 조회 최적화

3. 개인 마이페이지
- 지원 현황 조회
- 이력서 열람 기록
- 관심 공고 관리
- 사용자 알림 수신 연동

4. 부업 도메인
- 부업 게시글 CRUD
- 조건 기반 필터링
- 중복 체크 로직 및 인덱스 설계

## 🛠 기술 스택

- Backend: Java, Spring Boot, Spring MVC, Spring Cache, Spring Data Redis
- Data: Oracle, MyBatis, Redis, Caffeine
- Infra/Build: Gradle
- Frontend/View: JSP, JavaScript, SSE
- Collaboration: GitHub

## 🎯 요구사항 기반 기술 선정

1. 실시간 사용자 알림 필요
- 선택: SSE
- 이유: 서버→클라이언트 단방향 푸시에 적합, WebSocket 대비 구조 단순, 운영 부담 낮음
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/portfolio_requirement_details.md#1-실시간-사용자-알림-필요)

2. 멀티 인스턴스 알림 동기화 필요
- 선택: Redis Pub/Sub
- 이유: 인스턴스 간 fan-out 단순, 실시간 전달에 적합
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/portfolio_requirement_details.md#2-멀티-인스턴스-알림-동기화-필요)

3. 대량 알림(100만+) 처리 필요
- 선택: Redis Stream + Consumer Group
- 이유: 적재/소비 분리, ACK 기반 재처리, 수평 확장 구조 유리
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/portfolio_requirement_details.md#3-대량-알림100만-처리-필요)

4. 반복 조회 부하 완화 필요
- 선택: Caffeine(L1) + Redis(L2)
- 이유: 로컬 초저지연 응답 + 분산 공유 캐시 동시 확보
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/portfolio_requirement_details.md#4-반복-조회-부하-완화-필요)

5. DB 읽기 부하 분산 필요
- 선택: Master/Slave 라우팅
- 이유: Read/Write 분리로 병목 완화
- [상세보기](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/portfolio_requirement_details.md#5-db-읽기-부하-분산-필요)

## ⚙️ 문제 → 과정 → 해결

### 1) 캐시 고도화 (공고/마이페이지 중심)

- 문제: 동일/유사 데이터 반복 조회로 요청당 DB 접근 증가
- 과정: 조회 빈도 vs 변경 빈도 분석 → 캐시 후보 분류 → TTL 차등(3~30분) → 무효화 지점 매핑
- 해결: `@Cacheable`, `@CacheEvict`, `@Caching` + L1 Caffeine/L2 Redis 2-Level 캐시

### 2) 알림 시스템 고도화 (공고/지원/프리랜서 연동)

- 문제: 문자열 분기 구조의 확장성 한계, 단건 처리 중심으로 대량 발송 병목
- 과정: 채널 추상화 설계 → 전략 패턴 적용 → 큐 기반 비동기 전환
- 해결: `NotificationChannel enum + Handler + Dispatcher Map`
- 구조: SSE + Redis Pub/Sub + Redis Stream
- 처리: 청크 enqueue + batch consume + ACK

### 3) DB 이중화 고도화

- 문제: 조회 트래픽 집중 시 Master 부하 증가 가능성
- 해결: `@Transactional(readOnly=true) -> Slave`, `Write -> Master`, `LazyConnectionDataSourceProxy` 적용

### 4) 인덱스/쿼리 튜닝 (공고 검색 중심)

- 문제: 검색/정렬/중복체크 구간 Full Scan 위험
- 과정: 실제 WHERE/ORDER BY 패턴 분석 + 실행계획 비교
- 해결: 복합 인덱스 + 핵심 단일 인덱스 적용, 쿼리 경로 최적화

## 🧪 검증/테스트

- Redis Stream 100만 건 이상 시나리오 테스트
- 검증 포인트: enqueue 처리량, consumer lag, ACK 성공률, 재시도 동작
- 운영 관점: 단일 경로 병목 여부, 인스턴스 확장 시 처리량 증가 추세 확인
- 측정 조건: 로컬 Redis(`localhost:6379`), 단일 노드, 배치 소비 기준

시각화 자료:

### 처리량 비교

![Throughput](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/throughput_ops_sec.png?raw=1)

### 지연시간(Avg vs p95)

![Latency](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/latency_ms.png?raw=1)

### 종합 대시보드

![Dashboard](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/benchmark_dashboard.png?raw=1)

### 캐시 vs 스트림 처리량 비교

![Cache vs Stream](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/stream_vs_cache_comparison.png?raw=1)

자료 원본:
- [검증 리포트](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/validation_report.md)
- [실측 원본(JSON)](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/redis_benchmark_results.json)

## 📈 성과

- 메인 조회 응답시간: **245ms -> 6ms** (Cache HIT 기준)
- 요청당 DB 접근: 다중 조회 -> **0회** (Cache HIT 기준)
- 단건 알림 구조 -> 대량 비동기 파이프라인 전환
- 구조 성과: 신규 채널 추가 시 Handler 추가 중심으로 변경 범위 최소화

## 🧯 트러블슈팅

1. 채널 분기 복잡도 증가
- 해결: enum + 전략 패턴 도입

2. Redis 초기화 실패 리스크
- 해결: Lazy init + BUSYGROUP/연결 예외 처리

3. 대량 알림 병목
- 해결: 청크 분할 + 병렬 enqueue + batch consume

근거 로그:
- [compile_failure.log](https://github.com/jiwonseok97/CareerPlus-prj/blob/main/docs/metrics/compile_failure.log)

## 💡 회고

- 성능 개선은 단일 기술이 아니라 아키텍처 설계 문제임을 체감
- “요구사항 -> 병목 식별 -> 검증 가능한 해결” 흐름이 가장 큰 설득 포인트
- 다음 단계: 200만+ 기준 Stream 샤딩, DLQ 운영 기준, lag 모니터링 자동화
