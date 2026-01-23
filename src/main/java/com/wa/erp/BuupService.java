package com.wa.erp;

import java.util.List;
import java.util.Map;

//BoardService 인터페이스 선언
public interface BuupService{


	

	//(부업)	
	List<BuupDTO> getbuupList(BuupSearchDTO buupSearchDTO);
	
	BuupDTO getbuup(int b_no);
	
	int getbuupListAllCnt();
	
	int getbuupListCnt(BuupSearchDTO buupSearchDTO);


}
