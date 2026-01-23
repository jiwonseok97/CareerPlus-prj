package com.wa.erp;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



//==============================================
//[LoginService 인터페이스]를 구현한 LoginServiceImpl 클래스 선언하기
//==============================================
//-------------------------------------------
// 스프링에서 관용적으로   Service 라는 단어가 들어간 클래스는  
// [트랜잭션이 걸린 세분화된 DB 연동 지시]를 내리는 메소드 소유한 클래스 이다.
// 클래스 이름 앞에는 @Service , @Transactional 라는 어노테이션이 붙는다.
//-------------------------------------------
@Service
@Transactional
public class MemberServiceImpl implements MemberService{
	

	@Autowired
	private MemberDAO memberDAO;
	

	public int insertMember(MemberDTO memberDTO){
		
		int midCnt = this.memberDAO.getPidCnt(memberDTO);
		if(midCnt>0) {
			return 2;
		}
//		int insertSkill = this.memberDAO.insertSkill(memberDTO);
//		
//		
//		if(insertSkill==0) {
//			return insertSkill;
//		}
		System.out.println(memberDTO.getPid());
		System.out.println(memberDTO.getPwd());
		System.out.println(memberDTO.getName());
		System.out.println(memberDTO.getPhone());
		System.out.println(memberDTO.getAddr1());
		System.out.println(memberDTO.getAddr2());
		System.out.println(memberDTO.getAddr3());
		System.out.println(memberDTO.getEmail1());
		System.out.println(memberDTO.getEmail2());
		System.out.println(memberDTO.getField_code());
		System.out.println(memberDTO.getIs_job());
		System.out.println(memberDTO.getNickname());
		System.out.println(memberDTO.getSex());
		System.out.println(memberDTO.getJumin_num1());
		System.out.println(memberDTO.getJumin_num2());
		
		
		int insertMemCnt = this.memberDAO.insertMember(memberDTO);
		
		

		return insertMemCnt;
	}
	
	
	/*-------------회사 회원가입을 위한 선언--------------*/
	public int insertCompany(MemberDTO memberDTO) {


		int cidCnt = this.memberDAO.getCidCnt(memberDTO); 
		if(cidCnt>0){ return 2; }

		int insertCompanyCnt = this.memberDAO.insertCompany( memberDTO );

		System.out.print(memberDTO.getMem_c_no());
		memberDTO.setMem_c_no(memberDTO.getMem_c_no());
		return insertCompanyCnt;
	}

	/*------------ 기업정보 입력을 위한 선언-------------- */
	public int insertCompanyInfo(MemberDTO memberDTO) {

		System.out.print(memberDTO.getMem_c_no());
		 int insertCompanyCnt = this.memberDAO.insertCompanyInfo(memberDTO);   
		 if( memberDTO.getWelfare_code()!=null ) {
			int  insertComWelCnt = this.memberDAO.insertCompanyWelfare( memberDTO );
			if(insertComWelCnt==0) {return 0; } }
			
		return insertCompanyCnt;
	}


	@Override
	public int getMem_c_no() {
		
		int mem_c_no = this.memberDAO.getMem_c_no();
		
		return mem_c_no;
	}
	/*--------------------------------------------*/
	
	public int get_c_no() {
		int get_c_no = this.memberDAO.get_c_no();
		
		return get_c_no;
	}
	
	public BoardDTO getC_mem(int c_no) {
		BoardDTO boardDTO = this.memberDAO.getC_mem(c_no);
		
		return boardDTO;
	}
}
