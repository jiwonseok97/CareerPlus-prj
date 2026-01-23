package com.wa.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TimeShareDAO {
	
	// (프리랜서)	
	List<TimeShareDTO> gettimeShareList(TimeShareSearchDTO timeShareSearchDTO);
//	
//    int inserttimeShare(TimeShareDTO timeShareDTO);
//    int updatetimeShare(TimeShareDTO timeShareDTO);
//	  int deletetimeShare(TimeShareDTO timeShareDTO);
	
	int gettimeSharePwdCnt(TimeShareDTO timeShareDTO);
	int updatetimeShareEmpty( TimeShareDTO timeShareDTO );
    int gettimeShareCnt(int b_no);
      
   
    TimeShareDTO gettimeShare(int b_no);
    TimeShareDTO gettimeShareForUpDel(int b_no);
	
	int gettimeShareListCnt(TimeShareSearchDTO timeShareSearchDTO);
	int gettimeShareAllCnt();
	
					
}
