# 데이터베이스 인덱스 가이드

CareerPlus 프로젝트에서 실제로 사용한 기준을 바탕으로 정리한 인덱스 가이드입니다.

## 1) 인덱스가 필요한 이유

인덱스는 "조건에 맞는 행을 빠르게 찾기 위한 자료구조"입니다.

- 인덱스 없음: Full Table Scan (대용량에서 느림)
- 인덱스 있음: 범위 탐색/고유 탐색 가능

## 2) 기본 원칙

1. WHERE/JOIN/ORDER BY에 자주 쓰이는 컬럼부터
2. 복합 인덱스는 컬럼 순서가 핵심
3. 선택도 낮은 컬럼은 단독 인덱스 지양
4. 쓰기 비용과 저장공간 증가를 항상 함께 고려

## 3) 복합 인덱스 예시

```sql
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);
```

이 인덱스는 `work_place`로 시작하는 조건에서 효과가 큽니다.

- `work_place = ...` -> 활용 가능
- `work_place = ... AND career = ...` -> 활용 가능
- `career = ...`만 단독 -> 활용 어려움

## 4) 실행계획으로 검증

```sql
EXPLAIN PLAN FOR
SELECT * FROM gonggo WHERE work_place LIKE '서울%';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

확인 기준:

- 긍정 신호: `INDEX RANGE SCAN`, `INDEX UNIQUE SCAN`
- 경고 신호: `TABLE ACCESS FULL`

## 5) 프로젝트 적용 인덱스 (요약)

```sql
CREATE INDEX idx_gonggo_c_no ON gonggo(c_no);
CREATE INDEX idx_company_info_c_no ON company_info(c_no);
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);
CREATE INDEX idx_gonggo_closedate ON gonggo(closedate);
CREATE INDEX idx_gonggo_regdate ON gonggo(gonggoreg_date DESC);

CREATE INDEX idx_person_mem_pid ON person_mem(pid);
CREATE INDEX idx_company_mem_cid ON company_mem(cid);
CREATE INDEX idx_pertocom_check ON pertocom(p_no, g_no, c_no);
```

## 6) 운영 시 주의사항

- 인덱스 추가는 조회 성능 향상과 쓰기 성능 저하의 교환관계
- 데이터 분포/트래픽이 바뀌면 인덱스 재평가 필요
- 인덱스 효과는 반드시 실행계획과 실제 응답시간으로 확인
