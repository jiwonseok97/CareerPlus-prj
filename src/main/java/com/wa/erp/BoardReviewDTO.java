package com.wa.erp;



public class BoardReviewDTO {
	private int selectPageNo;   // 선택한 페이지 번호 관련 파값 저장 변수
	private int rowCntPerPage;  // 페이지 당 보여줄 행의 개수 관련 파값 저장 변수
	private int begin_rowNo;    // 테이블 검색 시 시작행 번호 저장 변수 선언.
	private int end_rowNo;      // 테이블 검색 시 끝행 번호 저장 변수 선언.
	private String content;
	private int star;
	private String reviewSort;
	private int c_no;
	private int p_no;
	private int r_no;
	

	public int getR_no() {
		return r_no;
	}

	public void setR_no(int r_no) {
		this.r_no = r_no;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public int getC_no() {
		return c_no;
	}

	public void setC_no(int c_no) {
		this.c_no = c_no;
	}

	public String getReviewSort() {
		return reviewSort;
	}

	public void setReviewSort(String reviewSort) {
		this.reviewSort = reviewSort;
	}
	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public int getSelectPageNo() {
		return selectPageNo;
	}

	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}

	public int getRowCntPerPage() {
		return rowCntPerPage;
	}

	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}

	public int getBegin_rowNo() {
		return begin_rowNo;
	}

	public void setBegin_rowNo(int begin_rowNo) {
		this.begin_rowNo = begin_rowNo;
	}

	public int getEnd_rowNo() {
		return end_rowNo;
	}

	public void setEnd_rowNo(int end_rowNo) {
		this.end_rowNo = end_rowNo;
	}

	

	
	
}
