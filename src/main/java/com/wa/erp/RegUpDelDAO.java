package com.wa.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RegUpDelDAO {
	/*nnnnnnnnnnnn게시판 등록, 수정, 삭제을 위한nnnnnnnnnnnnn*/
	BoardDTO getBoard(BoardSearchDTO boardSearchDTO);
	
	int insertBoard(BoardDTO boardDTO);

	int insertComment(BoardDTO boardDTO);
	
	int updateRec(BoardDTO boardDTO);

	int downdateRec(BoardDTO boardDTO);
	
	int updateBoard(BoardDTO boardDTO);
	
	int getboardCnt(BoardDTO boardDTO);
	
	int getboardPwdCnt(BoardDTO boardDTO);

	int deleteBoard(BoardDTO boardDTO);
	/*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*/
	
	/*nnnnnnnnnnnn회사공고nnnnnnnnnnnnn*/
	int insertGonggo(BoardDTO boardDTO);
//
//	int insertGonggo_field(BoardDTO boardDTO);
//	
//	int insertBenefit_code(BoardDTO boardDTO);
//	
//	int insertRole_Detail(BoardDTO boardDTO);
	/*nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn*/
	
	// (부업)	
	int insertbuup(BuupDTO buupDTO); 
	int updatebuup(BuupDTO buupDTO); 
	int deletebuup(BuupDTO buupDTO); 
	
	int getbuupPwdCnt(BuupDTO buupDTO);
	int updatebuupEmpty( BuupDTO buupDTO );
    int getbuupCnt(int b_no);
    
    BuupDTO getbuup(int b_no);
    BuupDTO getbuupForUpDel(int b_no); 
		
	
	// (프리랜서)	
    int inserttimeShare(TimeShareDTO timeShareDTO); 
    int updatetimeShare(TimeShareDTO timeShareDTO); 
	int deletetimeShare(TimeShareDTO timeShareDTO); 
	
	int gettimeSharePwdCnt(TimeShareDTO timeShareDTO);
	int updatetimeShareEmpty(TimeShareDTO timeShareDTO );
    int gettimeShareCnt(int b_no);
  
    TimeShareDTO gettimeShare(int b_no);      
    TimeShareDTO gettimeShareForUpDel(int b_no);  
	
		//기업리뷰 작성

		int upReview(BoardDTO boardDTO);
		
		//이력서 등록
		int insertResume(BoardDTO boardDTO);
		
		int insertAwards(BoardDTO boardDTO);
		
		int insertEducation(BoardDTO boardDTO);
		
		int insertCareer(BoardDTO boardDTO);
		
		int insertPerson_license(BoardDTO boardDTO);
		
		int insertSkill_Code(BoardDTO boardDTO);

		int insertLike(BoardDTO boardDTO);

		int deleteLike(BoardDTO boardDTO);

		int insertLikeCompany(BoardDTO boardDTO);
		
		
		// 마이페이지 회원정보 수정 
		int  updatePrivacy (MypageDTO mypageDTO );
		int  deletePrivacy (MypageDTO mypageDTO );
		
		int  getPrivacyPwdCnt(MypageDTO mypageDTO );
		int  getPrivacyCnt(int p_no);

		MypageDTO getPrivacy(int p_no);
	
		MypageDTO getPrivacyForUpDel(int p_no);		

		int updateCompanyRec(BoardDTO boardDTO);

		int downdateCompanyRec(BoardDTO boardDTO);

		int deleteLikeCompany(BoardDTO boardDTO);

		int updateComment(BoardDTO boardDTO);

		int deleteComment(BoardDTO boardDTO);

		int deleteLikecomment(BoardDTO boardDTO);
		int deleteReview(BoardDTO boardDTO);



		int insertNotice(BoardDTO boardDTO);

		int updateNotice(BoardDTO boardDTO);

		int deleteNotice(BoardDTO boardDTO);

		int deleteSelectPost(BoardDTO boardDTO);
		
		int updateReview(BoardDTO boardDTO);

		
		int checkLike(BoardDTO boardDTO);
		
		
		
		//관리자

		int deletePersonMember(BoardDTO boardDTO);

		int deleteCompanyMember(BoardDTO boardDTO);

		int updateBlockMember(BoardDTO boardDTO);

		int updateBlockCancleMember(BoardDTO boardDTO);

		int deleteBlockMember(BoardDTO boardDTO);

		
		
		
		//이력서 수정, 삭제
		int  updateResume (BoardDTO boardDTO);
		int  deleteResume (BoardDTO boardDTO);
	
		int  getResumePwdCnt(MypageDTO mypageDTO );
		int  getResumeCnt(int resume_no);	
       
		BoardDTO getResume(int resume_no);		
		BoardDTO getResumeForUpDel(int resume_no);	
		List<BoardDTO> getSkillList(int resume_no);
			
		int  updateAwards (BoardDTO boardDTO);
		int  updateEducation (BoardDTO boardDTO);
		int  updateCareer (BoardDTO boardDTO);
		int  updatePerson_license (BoardDTO boardDTO);
		int  deletePersonSkill (BoardDTO boardDTO);
	    int  insertSkill_Code1 (BoardDTO boardDTO);

	    int  deleteCareer (BoardDTO boardDTO);
	    int  deleteEducation (BoardDTO boardDTO);
	    int  deleteAwards (BoardDTO boardDTO);
	    int  deletePerson_license (BoardDTO boardDTO);
	    

		
	}
