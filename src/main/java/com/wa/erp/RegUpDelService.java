package com.wa.erp;

import java.util.List;
import java.util.Map;

public interface RegUpDelService {
	/*게시판 등록,수정,삭제을 위한 선언*/
	int insertBoard(BoardDTO boardDTO);
	int updateBoard(BoardDTO boardDTO);
	int deleteBoard(BoardDTO boardDTO);
	
	/*게시판 댓글 등록*/
	int insertComment(BoardDTO boardDTO);
	//게시판 댓글 좋아요 +
	int updateRec(BoardDTO boardDTO);
	//게시판 댓글 싫어요 +
	int downdateRec(BoardDTO boardDTO);
	/*mmmmmmmmmmmmmmmmmm*/
	BoardDTO getBoard(BoardSearchDTO boardSearchDTO);
	
	//공고//
	public int insertGongo(BoardDTO boardDTO);
	//////////////////////////////////////
	
	//(부업)
	int insertbuup(BuupDTO buupDTO)throws Exception;
	int updatebuup(BuupDTO buupDTO)throws Exception;	
	int deletebuup(BuupDTO buupDTO);
	
	BuupDTO getbuupForUpDel(int b_no);
	
	//(프리랜서)
	int inserttimeShare(TimeShareDTO timeShareDTO) throws Exception;	
	int updatetimeShare(TimeShareDTO timeShareDTO)throws Exception;
	int deletetimeShare(TimeShareDTO timeShareDTO);
	
	TimeShareDTO gettimeShareForUpDel(int b_no);
		
		//리뷰 등록
		int upReview(BoardDTO boardDTO);
		//리뷰 삭제
		int deleteReview(BoardDTO boardDTO);
		
		//이력서 등록
		int insertResume(BoardDTO boardDTO);
		//관심기업 등록
		int insertLikeCompany(BoardDTO boardDTO);
		//관심 기업 해제
		int deleteLikeCompany(BoardDTO boardDTO);
		//댓글 수정
		int updateComment(BoardDTO boardDTO);
		//댓글 삭제
		int deleteComment(BoardDTO boardDTO);
		
		int insertNotice(BoardDTO boardDTO);
		int updateNotice(BoardDTO boardDTO);
		int deleteNotice(BoardDTO boardDTO);
		int deleteSelectPostCnt(BoardDTO boardDTO);
		
		
		
		// 마이페이지 회원정보 수정		
		int  deletePrivacy(MypageDTO mypageDTO );
		int  updatePrivacy(MypageDTO mypageDTO );

		MypageDTO getPrivacyForUpDel(int p_no);		
		
		int updateReview(BoardDTO boardDTO);
		int deletePersonMemberCnt(BoardDTO boardDTO);
		int deleteCompanyMemberCnt(BoardDTO boardDTO);
		int updateBlockMemberCnt(BoardDTO boardDTO);
		int updateBlockCancleMember(BoardDTO boardDTO);
		int deleteBlockMember(BoardDTO boardDTO);
		

		
		
		//이력서 등록, 수정, 삭제
		int  updateResume (BoardDTO boardDTO);
		int  deleteResume (BoardDTO boardDTO);
		
		BoardDTO getResumeForUpDel(int resume_no);	
		List<BoardDTO> getSkillList(int resume_no);
	

	}
