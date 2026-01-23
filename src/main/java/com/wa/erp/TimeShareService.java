package com.wa.erp;

import java.util.List;
import java.util.Map;

//BoardService 인터페이스 선언
public interface TimeShareService {
	
	//(프리랜서)
	
	List<TimeShareDTO> gettimeShareList(TimeShareSearchDTO timeShareSearchDTO);
	
	TimeShareDTO gettimeShare(int b_no);
	
	//총 개수
	int gettimeShareAllCnt();	
	//게시판 검색개수
	int gettimeShareListCnt(TimeShareSearchDTO timeShareSearchDTO);	
}
