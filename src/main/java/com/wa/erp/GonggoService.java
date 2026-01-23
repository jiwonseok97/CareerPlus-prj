package com.wa.erp;

import java.util.List;

public interface GonggoService {

	List<GonggoDTO> getgongGoList(BoardSearchDTO boardSearchDTO);
	
	int getGonggoListCnt(BoardSearchDTO boardSearchDTO);
	
	int getGonggoListAllCnt(BoardSearchDTO boardSearchDTO );
	
	GonggoDTO getgonggoDetailForm(int g_no );
	
	public int insertGongo(GonggoDTO gonggoDTO);
	
	GonggoDTO getGonggo(int g_no);
	
	int deleteFromGonggo(GonggoDTO gonggoDTO);
	
	 int updateGonggo(GonggoDTO gonggoDTO);
	 
	 int gonggoSupport(GonggoDTO gonggoDTO);

}
