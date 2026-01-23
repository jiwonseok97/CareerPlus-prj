package com.wa.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {
	// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// n행m열의 게시판 검색을 위한 getBoardList 메소드 선언하기
	// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	List<BoardDTO> getboardList(BoardSearchDTO boardSearchDTO);

	List<BoardDTO> getcompanyList(BoardSearchDTO boardSearchDTO);
	
	BoardDTO getcompanyDetail(int c_no);
	
	List<BoardDTO> getReview(int c_no);
	
	List<BoardReviewDTO> getreviewContent(int c_no);

	List<BoardDTO> getgongGoList();

	List<BoardDTO> getprjList();

	List<BoardDTO> getgongMoList();
	
	BoardDTO getBoard(Map<String,Object> paramMap);

	List<BoardDTO> getComment(Map<String,Object> paramMap);
	
	int updateReadCount(Map<String,Object> paramMap);

//	게시판 검색 개수 구하는 getBoardListCnt 메소드 선언하기
	int getboardListCnt(BoardSearchDTO boardSearchDTO);

	//게시판 총 개수 구하기
	int getboardListAllCnt(BoardSearchDTO boardSearchDTO);
	
	int getReviewListAllCnt();

	int getReviewListCnt(BoardReviewDTO boardReviewDTO);

	List<BoardReviewDTO> getreviewContent(BoardReviewDTO boardReviewDTO);

	BoardDTO getcompanyListDetail(int c_no);
	
		//프로젝트 게시판 관련
		List<BoardDTO> getPrjList(BoardSearchDTO boardSearchDTO);
		
		int getPrjListCnt(BoardSearchDTO boardSearchDTO);
		
		int getPrjListAllCnt();
		
		BoardDTO getPrj(int prj_no);
		
		int prjUpdateReadcount(int prj_no);
		
		int getPrjPwdCnt( BoardDTO boardDTO );
		
		int updatePrj( BoardDTO boardDTO );

		int deldatePrj(BoardDTO boardDTO);
		
		int getPrjCnt(int prj_no);
		
		int insertPrj(BoardDTO boardDTO);
			

		//공모전 관련
		int insertGongMo(BoardDTO boardDTO);

		BoardDTO getGongMo(int comp_pk);

		int updateGongMo(BoardDTO boardDTO);

		int getGongMoPwdCnt(BoardDTO boardDTO);

		int deldateGongMo(BoardDTO boardDTO);

		int gongMoUpdateReadcount(int comp_pk);

		List<BoardDTO> getGongMoList(BoardSearchDTO boardSearchDTO);

		int getGongMoListAllCnt();

		int getGongMoListCnt(BoardSearchDTO boardSearchDTO);

		List<BoardDTO> getCommentLike(Map<String, Object> paramMap);
		
		//기업마이페이지
		List<BoardDTO> getMyGongMoList(int c_no);


		List<BoardDTO> getLikeCompany(int p_no);

		int getnoticeListCnt(BoardSearchDTO boardSearchDTO);

		int getnoticeListAllCnt(BoardSearchDTO boardSearchDTO);
		List<BoardDTO> getMyGongGoList(int c_no);

		List<BoardDTO> getMyCompanyInfo(int c_no);

		List<BoardDTO> getGonggoPertocom(int c_no);

		BoardDTO getComInfoSujung(int c_no);

		int getComInfoCnt(int c_no);
		
		int getComInfoPwdCnt( BoardDTO boardDTO );
		 
		int updateComInfo( BoardDTO boardDTO );
		
		int updateComMem( BoardDTO boardDTO );
		
		int getComMemCnt( int c_no );
		
		int getComWelCnt( int c_no );
		
		int deldateComWel( BoardDTO boardDTO );
		
		int updateComWel( BoardDTO boardDTO );
		
		int ComUpWelfare(BoardDTO boardDTO);

		int getComUpWelCnt(int c_no);


		int getcompanyListCnt(BoardSearchDTO boardSearchDTO);

		int getcompanyListAllCnt(BoardSearchDTO boardSearchDTO);
		BoardDTO getcompanyWelfare(int c_no);

		List<BoardDTO> getNoticeList(BoardSearchDTO boardSearchDTO);

		BoardDTO getNoticeDetail(int n_no);
		int updateNoticeReadcount(int n_no);

		List<BoardDTO> getMainNoticeList(BoardSearchDTO boardSearchDTO);

		
		
		
		
		
// 관리자 
		int getMemberListAllCnt(BoardSearchDTO boardSearchDTO);

		int getMemberListCnt(BoardSearchDTO boardSearchDTO);

		List<BoardDTO> getMemberList(BoardSearchDTO boardSearchDTO);

		int getBlockMemberListCnt(BoardSearchDTO boardSearchDTO);

		int getBlockMemberListAllCnt(BoardSearchDTO boardSearchDTO);

		List<BoardDTO> getBlockMemberList(BoardSearchDTO boardSearchDTO);
		
		
	//통계
		List<BoardDTO> getSalaryData();

		List<BoardDTO> getFieldGonggoData();

		List<BoardDTO> getpopularCom();

		List<BoardDTO> getRegionCounts();

		List<BoardDTO> getHope_Salary();

		List<BoardDTO> getHope_Field();

		List<BoardDTO> getApply_Field();

		List<BoardDTO> getPer_Region();

		BoardDTO getSexRatio();

		BoardDTO getMemberRatio();

		List<BoardDTO> getMemberPerMonthCnt();



	
}
