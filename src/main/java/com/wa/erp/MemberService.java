package com.wa.erp;

import java.util.Map;

public interface MemberService {
	
	public int insertMember( MemberDTO memberDTO);
	
	/*--------------회사 정보를 위한 선언-------------*/
	public int insertCompany(MemberDTO companyDTO);

	public int insertCompanyInfo(MemberDTO companyDTO);
	/*-------------------------------------------*/

	int getMem_c_no();
	
	public int get_c_no();

	public BoardDTO getC_mem(int c_no);
	}
