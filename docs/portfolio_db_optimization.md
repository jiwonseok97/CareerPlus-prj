# Oracle 인덱스·쿼리 최적화 정리

이 문서는 CareerPlus에서 검색/정렬/중복 체크 구간을 중심으로 수행한 DB 최적화 과정을 정리한 메모입니다.

## 1) 문제 정의

서비스 특성상 아래 요청이 반복적으로 발생했습니다.

- 공고 목록 검색(지역/경력/학력 조건)
- 최신순/마감순 정렬
- 로그인 인증 조회
- 지원 중복 체크

데이터가 증가하면 Full Table Scan 비중이 커질 가능성이 있어, 기능 오픈 전에 조회 경로를 기준으로 인덱스를 재설계했습니다.

## 2) 인덱스 설계 원칙

1. 선택도가 높은 컬럼을 앞에 배치
2. 실제 WHERE/ORDER BY 패턴과 인덱스 순서 일치
3. 낮은 카디널리티 컬럼은 단독 인덱스 지양
4. 쓰기 비용(INSERT/UPDATE/DELETE) 증가를 고려해 최소 세트로 운영

## 3) 적용 인덱스

### 공고/기업 조회

```sql
CREATE INDEX idx_gonggo_c_no ON gonggo(c_no);
CREATE INDEX idx_company_info_c_no ON company_info(c_no);
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);
CREATE INDEX idx_gonggo_closedate ON gonggo(closedate);
CREATE INDEX idx_gonggo_regdate ON gonggo(gonggoreg_date DESC);
```

### 로그인/중복 체크

```sql
CREATE INDEX idx_person_mem_pid ON person_mem(pid);
CREATE INDEX idx_company_mem_cid ON company_mem(cid);
CREATE INDEX idx_pertocom_check ON pertocom(p_no, g_no, c_no);
```

## 4) 실행계획 확인

```sql
EXPLAIN PLAN FOR
SELECT *
FROM gonggo
WHERE work_place LIKE '서울%';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

점검 포인트:

- 목표: `INDEX RANGE SCAN`, `INDEX UNIQUE SCAN`
- 개선 필요 신호: `TABLE ACCESS FULL` 반복

## 5) 트레이드오프

- 인덱스가 늘수록 쓰기 성능 저하 가능
- 저장공간 사용량 증가
- 쿼리 패턴 변경 시 인덱스 재평가 필요

## 6) 운영 결론

인덱스는 많이 만드는 것이 아니라, 실제 조회 경로에서 자주 쓰이는 조건을 정확히 타게 만드는 것이 핵심이었습니다.

DB 최적화는 캐시/라우팅과 함께 설계할 때 효과가 커졌고, 단일 기법보다 아키텍처 관점 조합이 실제 성능 개선에 더 유효했습니다.
