package com.wa.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BuupDAO {
	
		// (부업)
	    List<BuupDTO> getbuupList(BuupSearchDTO buupSearchDTO);

//		int insertbuup(BuupDTO buupDTO);
//		int updatebuup(BuupDTO buupDTO);
//		int deletebuup(BuupDTO buupDTO);
		
		int getbuupPwdCnt(BuupDTO buupDTO);
		int updatebuupEmpty( BuupDTO buupDTO);
	    int getbuupCnt(int b_no);
	    
	    BuupDTO getbuup(int b_no);
	    BuupDTO getbuupForUpDel(int b_no);
		
		int getbuupListCnt(BuupSearchDTO buupSearchDTO);
		int getbuupListAllCnt();
		
}
