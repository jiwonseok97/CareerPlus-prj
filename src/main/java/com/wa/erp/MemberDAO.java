package com.wa.erp;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDAO {
	
	int insertMember( MemberDTO memberDTO);

//	int insertSkill( MemberDTO memberDTO);
	
	int getPidCnt( MemberDTO memberDTO);
	
	/*-------------회사 정보를 위한 서언-------------*/
	int insertCompany(MemberDTO companyDTO);

	int getCidCnt(MemberDTO companyDTO);

	int insertCompanyInfo(MemberDTO companyDTO);

	int insertCompanyWelfare(MemberDTO companyDTO);
	/*-------------------------------------------*/

	int getMem_c_no();

	int  getUpWelfare_code();
	
	int get_c_no();

	BoardDTO getC_mem(int c_no);
	
	}
