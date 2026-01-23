# Oracle 데이터베이스 인덱스 최적화를 통한 성능 개선

## 프로젝트 개요

| 항목 | 내용 |
|------|------|
| **프로젝트명** | 12Wa 채용포털 |
| **기술 스택** | Spring Boot, MyBatis, Oracle 11g XE, JSP |
| **담당 역할** | 백엔드 개발 및 데이터베이스 최적화 |
| **최적화 대상** | 채용공고 검색, 회원 로그인, 지원 중복체크 등 핵심 기능 |

---

## 1. 인덱스 최적화 배경

### 1.1 문제 상황
채용포털 서비스 특성상 다음과 같은 대량 조회 쿼리가 빈번하게 발생합니다:

- 채용공고 목록 검색 (지역, 경력, 학력 조건)
- 기업/개인 회원 로그인 인증
- 지원 중복 체크
- 마감일 기준 공고 필터링

데이터가 증가할수록 **Full Table Scan**으로 인한 응답 지연이 예상되어 선제적으로 인덱스를 설계하였습니다.

### 1.2 카디널리티(Cardinality) 분석

인덱스 설계 시 **카디널리티**를 고려했습니다:

```
카디널리티 = 특정 컬럼의 고유값 개수
선택도(Selectivity) = 카디널리티 / 전체 행 수
```

| 컬럼 | 카디널리티 | 인덱스 적합성 |
|------|-----------|--------------|
| `g_no` (PK) | 매우 높음 | ✅ 자동 생성 |
| `cid`, `pid` | 높음 | ✅ 적합 |
| `work_place` | 중간 | ✅ 복합 인덱스 활용 |
| `career` | 낮음 | ⚠️ 단독 불리, 복합에 활용 |
| `is_block` | 매우 낮음 (2값) | ❌ 단독 부적합 |

---

## 2. 핵심 쿼리 분석 및 인덱스 설계

### 2.1 채용공고 검색 쿼리

**MyBatis Mapper (mapper_Gonoggo.xml)**
```xml
<select id="getgongGoList" resultType="com.wa.erp.GonggoDTO">
    SELECT g.g_no, g.c_no, g.work_place, g.career, g.graduation,
           trunc(closedate-sysdate) as "due_date"
    FROM gonggo g, company_mem c, company_info i
    WHERE c.c_no = g.c_no AND g.c_no = i.c_no

    <if test="work_place != null">
        AND upper(g.work_place) LIKE upper('%${work_place}%')
    </if>
    <if test="gonggoStatus == 'ing'">
        AND trunc(closedate-sysdate) >= 0
    </if>

    ORDER BY ${sort}
</select>
```

**설계한 인덱스**
```sql
-- 기업별 공고 조회용 (JOIN 성능 향상)
CREATE INDEX idx_gonggo_c_no ON gonggo(c_no);

-- 공고 검색 복합 인덱스 (지역, 경력, 학력)
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);

-- 마감일 필터/정렬용
CREATE INDEX idx_gonggo_closedate ON gonggo(closedate);

-- 등록일 정렬용 (DESC 인덱스)
CREATE INDEX idx_gonggo_regdate ON gonggo(gonggoreg_date DESC);
```

### 2.2 로그인 쿼리

**MyBatis Mapper (mapper_login.xml)**
```xml
<!-- 개인회원 로그인 -->
<select id="checkpid" parameterType="java.util.HashMap" resultType="int">
    SELECT count(*) FROM person_mem WHERE pid=#{mid} AND pwd=#{pwd}
</select>

<!-- 기업회원 로그인 -->
<select id="checkcid" parameterType="java.util.HashMap" resultType="int">
    SELECT count(*) FROM company_mem WHERE cid=#{mid} AND pwd=#{pwd}
</select>
```

**설계한 인덱스**
```sql
-- 개인회원 로그인 조회
CREATE INDEX idx_person_mem_pid ON person_mem(pid);

-- 기업회원 로그인 조회
CREATE INDEX idx_company_mem_cid ON company_mem(cid);
```

### 2.3 지원 중복체크 쿼리

**MyBatis Mapper**
```xml
<select id="getPertocom" parameterType="com.wa.erp.GonggoDTO" resultType="int">
    SELECT count(*) FROM pertocom
    WHERE p_no=#{p_no} AND g_no=#{g_no} AND c_no=#{c_no}
</select>
```

**설계한 인덱스**
```sql
-- 복합 인덱스 (3개 컬럼 모두 조건에 사용)
CREATE INDEX idx_pertocom_check ON pertocom(p_no, g_no, c_no);
```

---

## 3. 복합 인덱스 설계 원칙

### 3.1 컬럼 순서의 중요성

복합 인덱스는 **왼쪽부터 순서대로** 사용됩니다:

```sql
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);
```

| WHERE 조건 | 인덱스 사용 여부 |
|------------|-----------------|
| `work_place = '서울'` | ✅ 사용 |
| `work_place = '서울' AND career = '신입'` | ✅ 사용 |
| `career = '신입'` | ❌ 미사용 (첫 컬럼 없음) |
| `work_place = '서울' AND graduation = '대졸'` | ⚠️ 부분 사용 |

### 3.2 설계 시 고려사항

1. **선택도가 높은 컬럼을 앞에 배치**
2. **WHERE 조건에 항상 사용되는 컬럼 우선**
3. **범위 조건(>, <, BETWEEN)은 뒤쪽에 배치**

---

## 4. 전체 인덱스 스크립트

### 4.1 테이블별 인덱스 현황

| 테이블 | 인덱스명 | 컬럼 | 용도 |
|--------|----------|------|------|
| GONGGO | idx_gonggo_c_no | c_no | JOIN |
| GONGGO | idx_gonggo_search | work_place, career, graduation | 검색 |
| GONGGO | idx_gonggo_closedate | closedate | 마감일 필터 |
| GONGGO | idx_gonggo_regdate | gonggoreg_date DESC | 최신순 정렬 |
| COMPANY_MEM | idx_company_mem_cid | cid | 로그인 |
| PERSON_MEM | idx_person_mem_pid | pid | 로그인 |
| COMPANY_INFO | idx_company_info_c_no | c_no | JOIN |
| COMPANY_INFO | idx_company_info_field | field_code | 업종 검색 |
| PERTOCOM | idx_pertocom_check | p_no, g_no, c_no | 중복체크 |
| REVIEW | idx_review_c_no | c_no | 기업별 리뷰 |
| RESUME | idx_resume_p_no | p_no | 이력서 조회 |

### 4.2 인덱스 생성 SQL

```sql
-- ============================================================
-- 12Wa 채용포털 인덱스 생성 스크립트 (Oracle)
-- ============================================================

-- 1. 채용공고 테이블 (GONGGO)
CREATE INDEX idx_gonggo_c_no ON gonggo(c_no);
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);
CREATE INDEX idx_gonggo_closedate ON gonggo(closedate);
CREATE INDEX idx_gonggo_regdate ON gonggo(gonggoreg_date DESC);

-- 2. 회원 테이블
CREATE INDEX idx_company_mem_cid ON company_mem(cid);
CREATE INDEX idx_company_mem_name ON company_mem(name);
CREATE INDEX idx_person_mem_pid ON person_mem(pid);
CREATE INDEX idx_person_mem_field ON person_mem(field_code);

-- 3. 기업정보 테이블 (COMPANY_INFO)
CREATE INDEX idx_company_info_c_no ON company_info(c_no);
CREATE INDEX idx_company_info_field ON company_info(field_code);
CREATE INDEX idx_company_info_addr ON company_info(addr);

-- 4. 지원/리뷰 테이블
CREATE INDEX idx_pertocom_check ON pertocom(p_no, g_no, c_no);
CREATE INDEX idx_pertocom_gno ON pertocom(g_no);
CREATE INDEX idx_review_c_no ON review(c_no);

-- 5. 이력서/공지사항
CREATE INDEX idx_resume_p_no ON resume(p_no);
CREATE INDEX idx_notice_category ON notice(category);
CREATE INDEX idx_notice_regdate ON notice(reg_date DESC);
```

---

## 5. 성능 개선 예상 효과

### 5.1 이론적 시간 복잡도 비교

| 조회 유형 | Full Table Scan | Index Scan |
|----------|-----------------|------------|
| 단건 조회 (PK) | O(N) | O(1) |
| 범위 조회 | O(N) | O(log N + M) |
| 정렬 | O(N log N) | O(M) |

> N = 전체 행 수, M = 결과 행 수

### 5.2 실행 계획 확인 방법

```sql
-- Oracle 실행 계획 확인
EXPLAIN PLAN FOR
SELECT * FROM gonggo WHERE work_place LIKE '서울%';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

**결과 해석**
- `INDEX RANGE SCAN` : 인덱스 범위 검색 (최적)
- `INDEX UNIQUE SCAN` : 유일값 검색 (최적)
- `TABLE ACCESS FULL` : 전체 테이블 스캔 (개선 필요)

---

## 6. 인덱스 관리 가이드

### 6.1 인덱스 현황 조회

```sql
SELECT index_name, table_name, uniqueness, status
FROM user_indexes
WHERE table_name IN ('GONGGO', 'COMPANY_MEM', 'PERSON_MEM', 'PERTOCOM')
ORDER BY table_name, index_name;
```

### 6.2 인덱스 재구성 (조각화 해결)

```sql
ALTER INDEX idx_gonggo_search REBUILD;
```

### 6.3 인덱스 삭제 (롤백용)

```sql
DROP INDEX idx_gonggo_search;
```

---

## 7. 주의사항 및 트레이드오프

### 7.1 인덱스의 단점

1. **INSERT/UPDATE/DELETE 성능 저하**
   - 데이터 변경 시 인덱스도 함께 갱신 필요

2. **저장 공간 추가 사용**
   - 인덱스당 테이블 크기의 10-30% 추가

3. **과도한 인덱스 생성 지양**
   - 선택도가 낮은 컬럼 (예: 성별, Y/N 플래그)
   - 데이터가 적은 테이블 (1000건 미만)

### 7.2 인덱스가 무시되는 경우

```sql
-- ❌ 컬럼에 함수 적용
SELECT * FROM company_mem WHERE UPPER(cid) = 'SAMSUNG';

-- ❌ LIKE 앞에 % 사용
SELECT * FROM company_mem WHERE cid LIKE '%sung';

-- ❌ 부정 조건
SELECT * FROM person_mem WHERE pid IS NOT NULL;

-- ❌ 암묵적 형변환
SELECT * FROM gonggo WHERE g_no = '100';  -- g_no가 NUMBER인 경우
```

---

## 8. 결론

12Wa 채용포털 프로젝트에서 **27개의 인덱스**를 설계하고 적용하여:

1. **채용공고 검색** - 지역/경력/학력 복합 조건 검색 최적화
2. **회원 인증** - 로그인 쿼리 응답 속도 개선
3. **지원 처리** - 중복 체크 및 지원 목록 조회 성능 향상
4. **데이터 정렬** - DESC 인덱스를 통한 최신순 정렬 최적화

데이터베이스 수준에서의 성능 최적화를 달성했습니다.

---

## 부록: ER 다이어그램 (주요 테이블)

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ COMPANY_MEM │────<│   GONGGO    │>────│  PERTOCOM   │
│─────────────│     │─────────────│     │─────────────│
│ c_no (PK)   │     │ g_no (PK)   │     │ p_no (FK)   │
│ cid         │     │ c_no (FK)   │     │ g_no (FK)   │
│ name        │     │ work_place  │     │ c_no (FK)   │
│ pwd         │     │ career      │     └─────────────┘
└─────────────┘     │ closedate   │            │
       │            └─────────────┘            │
       ▼                                       ▼
┌─────────────┐                        ┌─────────────┐
│COMPANY_INFO │                        │ PERSON_MEM  │
│─────────────│                        │─────────────│
│ c_no (FK)   │                        │ p_no (PK)   │
│ field_code  │                        │ pid         │
│ addr        │                        │ nickname    │
└─────────────┘                        └─────────────┘
```

---

*작성일: 2025-01*
*기술 스택: Oracle 11g XE, Spring Boot 2.x, MyBatis 3.x*

---

## 9. Redis + 로컬(Caffeine) 캐시 적용 (성능 개선)

### 9.1 적용 배경
- 공고/게시판/통계성 데이터는 **조회 빈도는 높고 변경 주기는 길어** DB 부하가 누적됨.
- 로그인/회원 관련 쿼리 외에도 **목록·집계 조회**가 반복되어 응답 지연이 발생.
- DB 인덱스 최적화만으로는 피크 타임 트래픽 대응에 한계가 있어 **캐시 계층** 도입.

### 9.2 구현 과정
**1) 의존성 추가**
- Redis, Spring Cache, Caffeine, Jackson 직렬화 라이브러리 추가.

**2) 캐시 설정**
- `application.properties`
  - `spring.cache.type=redis`
  - `cache.type=redis|caffeine|both` (환경에 따라 전환 가능)
  - Redis 호스트/포트/타임아웃/풀 옵션 설정

**3) 캐시 매니저 구성**
- `CacheConfig`에서 다음을 구성:
  - `RedisConnectionFactory` (Lettuce)
  - `RedisTemplate` (Key: String, Value: JSON 직렬화)
  - `RedisCacheManager` (캐시별 TTL 적용)
  - `CaffeineCacheManager`
  - `CompositeCacheManager`로 **2‑Level 캐시** 구성 가능  
    (L1: Caffeine → L2: Redis)

**4) 캐시 적용 지점**
- 서비스 레이어의 조회 메서드에 `@Cacheable` 적용.
- 예: 회사 리스트, 공지/게시판 목록, 인기 데이터, 지역 통계 등.

**5) 운영 가시성**
- Actuator + 캐시 메트릭 대시보드 페이지 구성
- 요청 로그/히트율/응답시간을 캐시 타입별로 비교 가능.

### 9.3 적용 내용 요약
- **캐시 타입 스위칭**
  - `redis` : Redis 단일 캐시
  - `caffeine` : 로컬 캐시 단독
  - `both` : 2‑Level 캐시
- **TTL 전략**
  - 인기/통계성 데이터: 10~30분
  - 공지/게시판 리스트: 3~5분 등

### 9.4 기대 효과 및 포인트
- **DB 조회 부하 감소** 및 응답 속도 개선
- **트래픽 급증 시 안정성 확보**
- 캐시 타입을 설정만으로 전환 가능해 **운영 환경 적응성 강화**

--- 
