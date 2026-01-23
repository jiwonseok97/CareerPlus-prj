package com.wa.erp;

import java.util.List;


//게시판 검색화면에서 검색버튼 누르면
//WAS 로 접속할 때 가져올 파라미터값을 저장할 DTO 객체 선언하기
//이 객체에는 검색조건이 주로 들어있다.
public class BuupSearchDTO {
	
	private String keyword;
	private String sort;

	private String ing;
	private String work_place;
	private String BuupsearchType;
	
	private int selectPageNo;		// 선택한 페이지 번호 관련 파값 저장 변수
	private int rowCntPerPage;		// 페이지 당 보여줄 행의 개수 관련 파값 저장 변수
	private int begin_rowNo;		// 테이블 검색 시 시작행 번호 저장 변수 선언.
	private int end_rowNo;			// 테이블 검색 시 끝행 번호 저장 변수 선언.
	
	public String getWork_place() {
		return work_place;
	}
	public void setWork_place(String work_place) {
		this.work_place = work_place;
	}
	public String getIng() {
		return ing;
	}
	public void setIng(String ing) {
		this.ing = ing;
	}
	
	public String getKeyword() {
		return keyword;
	}
	
	
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
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

	public String getBuupsearchType() {
		return BuupsearchType;
	}
	public void setBuupsearchType(String buupsearchType) {
		BuupsearchType = buupsearchType;
	}
	
}
