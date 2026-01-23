package com.wa.erp;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GonggoDAO {

	// 공고
		List<GonggoDTO> getgongGoList(BoardSearchDTO boardSearchDTO);
		
		int getGonggoListCnt(BoardSearchDTO boardSearchDTO);
		
		int getGonggoListAllCnt(BoardSearchDTO boardSearchDTO);
	
		GonggoDTO getgonggoDetailForm(int g_no);
		
		int insertGonggo(GonggoDTO gonggoDTO);
		
		GonggoDTO getGonggo(int g_no);
		
		int deleteFromGonggo(GonggoDTO gonggoDTO);
		
		int updateRole_detail(GonggoDTO gonggoDTO);
		
		int updateGonggo(GonggoDTO gonggoDTO);
		
		int updateBenefit_code(GonggoDTO gonggoDTO);
		
		int gonggoSupport(GonggoDTO gonggoDTO);
		
		int getPertocom(GonggoDTO gonggoDTO);

		int insertGonggo_field(GonggoDTO gonggoDTO);

		int insertBenefit_code(GonggoDTO gonggoDTO);

		int insertRole_Detail(GonggoDTO gonggoDTO);
}
