# 데이터베이스 인덱스 가이드

## 1. 인덱스란?

인덱스는 **책의 목차**와 같습니다. 책에서 원하는 내용을 찾을 때 처음부터 끝까지 읽지 않고 목차를 보고 해당 페이지로 바로 가듯이, 데이터베이스도 인덱스를 통해 원하는 데이터를 빠르게 찾습니다.

```
[ 인덱스 없이 검색 ]
전체 테이블 스캔 (Full Table Scan)
1번 행 확인 → 2번 행 확인 → 3번 행 확인 → ... → N번 행 확인
시간 복잡도: O(N)

[ 인덱스 사용 검색 ]
B-Tree 인덱스 탐색
루트 → 브랜치 → 리프 → 데이터
시간 복잡도: O(log N)
```

---

## 2. PK 인덱스 (기본키 인덱스)

### 특징
- **자동 생성**: Primary Key 제약조건 설정 시 자동으로 생성
- **클러스터형 인덱스**: 데이터가 PK 순서대로 물리적으로 정렬
- **유일성 보장**: 중복값 허용 안함

### 예시
```sql
-- PK 설정 시 자동으로 인덱스 생성됨
CREATE TABLE gonggo (
    g_no NUMBER PRIMARY KEY,  -- 자동으로 인덱스 생성
    ...
);

-- 아래 쿼리는 PK 인덱스 사용
SELECT * FROM gonggo WHERE g_no = 100;  -- Index Scan
```

---

## 3. 단일 컬럼 인덱스

### 언제 사용하나?
- `WHERE` 절에서 자주 검색하는 컬럼
- `ORDER BY` 절에서 자주 정렬하는 컬럼
- `JOIN` 조건에서 자주 사용하는 컬럼

### 예시
```sql
-- 기업회원 아이디로 자주 검색
CREATE INDEX idx_company_mem_cid ON company_mem(cid);

-- 아래 쿼리에서 인덱스 사용
SELECT * FROM company_mem WHERE cid = 'samsung';  -- Index Scan
```

### 주의사항
```sql
-- 인덱스를 사용하지 못하는 경우
SELECT * FROM company_mem WHERE UPPER(cid) = 'SAMSUNG';  -- Full Scan (함수 사용)
SELECT * FROM company_mem WHERE cid LIKE '%sung';        -- Full Scan (앞에 %)
SELECT * FROM company_mem WHERE cid IS NOT NULL;         -- Full Scan (부정조건)
```

---

## 4. 복합 인덱스 (Composite Index)

### 컬럼 순서가 중요!
복합 인덱스는 **왼쪽부터 순서대로** 사용됩니다.

```sql
-- 인덱스 생성: (work_place, career, graduation) 순서
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);
```

### 인덱스 사용 여부

| WHERE 조건 | 인덱스 사용 |
|------------|-------------|
| `work_place = '서울'` | O (첫번째 컬럼) |
| `work_place = '서울' AND career = '신입'` | O (1,2번째 컬럼) |
| `work_place = '서울' AND career = '신입' AND graduation = '대졸'` | O (전체 사용) |
| `career = '신입'` | X (첫번째 컬럼 없음) |
| `career = '신입' AND graduation = '대졸'` | X (첫번째 컬럼 없음) |
| `work_place = '서울' AND graduation = '대졸'` | 부분 사용 (work_place만) |

### 핵심 원칙
1. **선택도가 높은 컬럼을 앞에** (고유값이 많은 컬럼)
2. **WHERE 조건에서 항상 사용되는 컬럼을 앞에**
3. **범위 조건(>, <, BETWEEN)은 뒤에** (범위 이후 컬럼은 인덱스 사용 불가)

---

## 5. 인덱스 설계 시 고려사항

### DO (권장)
- 자주 검색/정렬되는 컬럼에 인덱스 생성
- JOIN에 사용되는 FK 컬럼에 인덱스 생성
- 선택도가 높은 컬럼에 인덱스 생성

### DON'T (비권장)
- 데이터가 적은 테이블 (1000건 미만)
- INSERT/UPDATE/DELETE가 빈번한 테이블에 과도한 인덱스
- 선택도가 낮은 컬럼 (성별처럼 값이 2-3개뿐인 경우)

---

## 6. 실행 계획으로 인덱스 확인

```sql
-- Oracle에서 실행 계획 확인
EXPLAIN PLAN FOR
SELECT * FROM gonggo WHERE work_place LIKE '서울%';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

결과 해석:
- `INDEX RANGE SCAN` : 인덱스를 사용한 범위 검색 (좋음)
- `INDEX UNIQUE SCAN` : 인덱스를 사용한 유일값 검색 (좋음)
- `TABLE ACCESS FULL` : 전체 테이블 스캔 (인덱스 미사용)

---

## 7. 프로젝트 적용 인덱스 목록

### 채용공고 관련 (gonggo)
| 인덱스명 | 컬럼 | 용도 |
|----------|------|------|
| idx_gonggo_c_no | c_no | 기업별 공고 조회 |
| idx_gonggo_search | work_place, career, graduation | 공고 검색 |
| idx_gonggo_closedate | closedate | 마감일 정렬/필터 |
| idx_gonggo_regdate | gonggoreg_date | 등록일 정렬 |

### 회원 관련
| 인덱스명 | 컬럼 | 용도 |
|----------|------|------|
| idx_company_mem_cid | cid | 로그인 조회 |
| idx_person_mem_pid | pid | 로그인 조회 |
| idx_company_info_c_no | c_no | 기업정보 조회 |
| idx_company_info_field | field_code | 업종별 검색 |
| idx_company_info_addr | addr | 지역별 검색 |

### 게시판 관련
| 인덱스명 | 컬럼 | 용도 |
|----------|------|------|
| idx_board_p_no | p_no | 작성자별 조회 |
| idx_board_regdate | reg_date | 최신순 정렬 |

### 지원/리뷰 관련
| 인덱스명 | 컬럼 | 용도 |
|----------|------|------|
| idx_pertocom_search | g_no, c_no, p_no | 지원 중복체크 |
| idx_review_c_no | c_no | 기업별 리뷰 조회 |

---

## 8. 인덱스 관리 명령어

```sql
-- 인덱스 목록 조회
SELECT index_name, table_name, uniqueness
FROM user_indexes
WHERE table_name = 'GONGGO';

-- 인덱스 삭제
DROP INDEX idx_gonggo_search;

-- 인덱스 재구성 (조각화 해결)
ALTER INDEX idx_gonggo_search REBUILD;

-- 인덱스 사용 통계 확인
SELECT * FROM v$object_usage WHERE index_name = 'IDX_GONGGO_SEARCH';
```
