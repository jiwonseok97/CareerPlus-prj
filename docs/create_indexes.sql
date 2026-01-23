-- ============================================================
-- 12Wa 채용포털 인덱스 생성 스크립트 (Oracle)
-- 실행 전 반드시 백업하세요!
-- ============================================================

-- ============================================================
-- 1. 채용공고 테이블 (GONGGO) 인덱스
-- ============================================================

-- 기업별 공고 조회용 (company_mem과 JOIN 시 사용)
CREATE INDEX idx_gonggo_c_no ON gonggo(c_no);

-- 공고 검색용 (지역, 경력, 학력 복합 조건)
-- 쿼리: WHERE work_place LIKE '서울%' AND career = '신입' AND graduation = '대졸'
CREATE INDEX idx_gonggo_search ON gonggo(work_place, career, graduation);

-- 마감일 기준 정렬/필터용
-- 쿼리: WHERE TRUNC(closedate-sysdate) >= 0 ORDER BY closedate
CREATE INDEX idx_gonggo_closedate ON gonggo(closedate);

-- 등록일 정렬용
-- 쿼리: ORDER BY gonggoreg_date DESC
CREATE INDEX idx_gonggo_regdate ON gonggo(gonggoreg_date DESC);


-- ============================================================
-- 2. 기업회원 테이블 (COMPANY_MEM) 인덱스
-- ============================================================

-- 로그인 조회용 (아이디로 검색)
-- 쿼리: WHERE cid = ?
CREATE INDEX idx_company_mem_cid ON company_mem(cid);

-- 기업명 검색용
-- 쿼리: WHERE name LIKE '%keyword%'
CREATE INDEX idx_company_mem_name ON company_mem(name);


-- ============================================================
-- 3. 기업정보 테이블 (COMPANY_INFO) 인덱스
-- ============================================================

-- company_mem과 JOIN용 (FK)
CREATE INDEX idx_company_info_c_no ON company_info(c_no);

-- 업종별 검색용
-- 쿼리: WHERE field_code = ?
CREATE INDEX idx_company_info_field ON company_info(field_code);

-- 지역별 검색용 (시/도 앞부분 검색)
-- 쿼리: WHERE addr LIKE '서울%'
CREATE INDEX idx_company_info_addr ON company_info(addr);

-- 인기기업 정렬용
-- 쿼리: ORDER BY rec_count DESC
CREATE INDEX idx_company_info_rec ON company_info(rec_count DESC);

-- 연봉 통계용
CREATE INDEX idx_company_info_sal ON company_info(sal_avg);


-- ============================================================
-- 4. 개인회원 테이블 (PERSON_MEM) 인덱스
-- ============================================================

-- 로그인 조회용 (아이디로 검색)
-- 쿼리: WHERE pid = ?
CREATE INDEX idx_person_mem_pid ON person_mem(pid);

-- 관심분야별 검색용
-- 쿼리: WHERE field_code = ?
CREATE INDEX idx_person_mem_field ON person_mem(field_code);

-- 차단회원 조회용
-- 쿼리: WHERE is_block = 'block'
CREATE INDEX idx_person_mem_block ON person_mem(is_block);

-- 지역별 통계용
CREATE INDEX idx_person_mem_addr ON person_mem(addr);


-- ============================================================
-- 5. 지원 테이블 (PERTOCOM) 인덱스
-- ============================================================

-- 지원 중복체크용 (복합 인덱스)
-- 쿼리: WHERE p_no = ? AND g_no = ? AND c_no = ?
CREATE INDEX idx_pertocom_check ON pertocom(p_no, g_no, c_no);

-- 공고별 지원자 조회용
CREATE INDEX idx_pertocom_gno ON pertocom(g_no);

-- 기업별 지원자 조회용
CREATE INDEX idx_pertocom_cno ON pertocom(c_no);


-- ============================================================
-- 6. 리뷰 테이블 (REVIEW) 인덱스
-- ============================================================

-- 기업별 리뷰 조회용
-- 쿼리: WHERE c_no = ?
CREATE INDEX idx_review_c_no ON review(c_no);

-- 작성자별 리뷰 조회용
CREATE INDEX idx_review_p_no ON review(p_no);


-- ============================================================
-- 7. 복지코드 테이블 (COMPANY_WELFARE) 인덱스
-- ============================================================

-- 기업별 복지 조회용
CREATE INDEX idx_company_welfare_c_no ON company_welfare(c_no);

-- 복지코드별 검색용
CREATE INDEX idx_company_welfare_code ON company_welfare(welfare_code);


-- ============================================================
-- 8. 공고 관련 서브테이블 인덱스
-- ============================================================

-- 필수/우대 조건
CREATE INDEX idx_benefit_code_g_no ON benefit_code(g_no);

-- 담당업무
CREATE INDEX idx_role_detail_g_no ON role_detail(g_no);

-- 채용프로세스
CREATE INDEX idx_gonggo_process_g_no ON gonggo_process(g_no);


-- ============================================================
-- 9. 이력서 테이블 (RESUME) 인덱스
-- ============================================================

-- 작성자별 이력서 조회용
CREATE INDEX idx_resume_p_no ON resume(p_no);


-- ============================================================
-- 10. 공지사항 테이블 (NOTICE) 인덱스
-- ============================================================

-- 카테고리별 조회용
CREATE INDEX idx_notice_category ON notice(category);

-- 최신순 정렬용
CREATE INDEX idx_notice_regdate ON notice(reg_date DESC);


-- ============================================================
-- 인덱스 생성 확인
-- ============================================================
SELECT index_name, table_name, uniqueness, status
FROM user_indexes
WHERE table_name IN (
    'GONGGO', 'COMPANY_MEM', 'COMPANY_INFO', 'PERSON_MEM',
    'PERTOCOM', 'REVIEW', 'COMPANY_WELFARE', 'BENEFIT_CODE',
    'ROLE_DETAIL', 'GONGGO_PROCESS', 'RESUME', 'NOTICE'
)
ORDER BY table_name, index_name;


-- ============================================================
-- 인덱스 삭제 스크립트 (롤백용)
-- ============================================================
/*
DROP INDEX idx_gonggo_c_no;
DROP INDEX idx_gonggo_search;
DROP INDEX idx_gonggo_closedate;
DROP INDEX idx_gonggo_regdate;
DROP INDEX idx_company_mem_cid;
DROP INDEX idx_company_mem_name;
DROP INDEX idx_company_info_c_no;
DROP INDEX idx_company_info_field;
DROP INDEX idx_company_info_addr;
DROP INDEX idx_company_info_rec;
DROP INDEX idx_company_info_sal;
DROP INDEX idx_person_mem_pid;
DROP INDEX idx_person_mem_field;
DROP INDEX idx_person_mem_block;
DROP INDEX idx_person_mem_addr;
DROP INDEX idx_pertocom_check;
DROP INDEX idx_pertocom_gno;
DROP INDEX idx_pertocom_cno;
DROP INDEX idx_review_c_no;
DROP INDEX idx_review_p_no;
DROP INDEX idx_company_welfare_c_no;
DROP INDEX idx_company_welfare_code;
DROP INDEX idx_benefit_code_g_no;
DROP INDEX idx_role_detail_g_no;
DROP INDEX idx_gonggo_process_g_no;
DROP INDEX idx_resume_p_no;
DROP INDEX idx_notice_category;
DROP INDEX idx_notice_regdate;
*/
