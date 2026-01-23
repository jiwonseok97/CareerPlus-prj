package com.wa.erp;

import java.util.List;
import java.util.Map;

//BoardService 인터페이스 선언
public interface BoardService {

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
	
	int getboardListCnt(BoardSearchDTO boardSearchDTO );

	int getboardListAllCnt(BoardSearchDTO boardSearchDTO);

	int getReviewListAllCnt();

	int getReviewListCnt(BoardReviewDTO boardReviewDTO);

	List<BoardReviewDTO> getreviewContent(BoardReviewDTO boardReviewDTO);

	BoardDTO getcompanyListDetail(int c_no);
	//기업정보관련

	int getcompanyListCnt(BoardSearchDTO boardSearchDTO);

	int getcompanyListAllCnt(BoardSearchDTO boardSearchDTO);
	
	BoardDTO getcompanyWelfare(int c_no);

	
	
		//프로젝트를 위한 선언
		List<BoardDTO> getPrjList(BoardSearchDTO boardSearchDTO);
		
		BoardDTO getPrj(int prj_no);
		
		BoardDTO getPrjForUpDel(int prj_no);
		
		int insertPrj(BoardDTO boardDTO) throws Exception;
		
		int updatePrj(BoardDTO boardDTO) throws Exception;

		int deldatePrj(BoardDTO boardDTO);

		int getPrjListAllCnt();

		int getPrjListCnt(BoardSearchDTO boardSearchDTO);
	
		
		
		// 공모전 관련
		List<BoardDTO> getGongMoList(BoardSearchDTO boardSearchDTO);
		
		BoardDTO getGongMo(int comp_no);

		BoardDTO gongMoForUpDel(int comp_pk);
		
		int insertGongMo(BoardDTO boardDTO)  throws Exception;

		int updateGongMo(BoardDTO boardDTO) throws Exception;

		int deldateGongMo(BoardDTO boardDTO);

		int getGongMoListAllCnt();

		int getGongMoListCnt(BoardSearchDTO boardSearchDTO);

		List<BoardDTO> getCommentLike(Map<String, Object> paramMap);
		
		// 기업 마이페이지
		List<BoardDTO> getMyGongMoList(int c_no);

			//공지사항
		BoardDTO getNoticeUpDel(int n_no); 
		int getnoticeListCnt(BoardSearchDTO boardSearchDTO);

		List<BoardDTO> getNoticeList(BoardSearchDTO boardSearchDTO);

		int getnoticeListAllCnt(BoardSearchDTO boardSearchDTO);

		BoardDTO getNotice(int n_no);

		List<BoardDTO> getMainNoticeList(BoardSearchDTO boardSearchDTO);
		List<BoardDTO> getMyGongGoList(int c_no);

		List<BoardDTO> getMyCompanyInfo(int c_no);

		List<BoardDTO> getGonggoPertocom(int c_no);

		BoardDTO getComInfoSujung(int c_no);

		int updateComInfo(BoardDTO boardDTO);

		int updateComMem(BoardDTO boardDTO);

		int updateComWel(BoardDTO boardDTO);

		List<BoardDTO> getlikeCompany(int p_no);


		
		//관리자
		int getMemberListCnt(BoardSearchDTO boardSearchDTO);

		int getMemberListAllCnt(BoardSearchDTO boardSearchDTO);

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
		
		List<BoardDTO> getPer_Region();

		BoardDTO getSexRatio();

		BoardDTO getMemberRatio();

		List<BoardDTO> getMemberPerMonthCnt();
		
}
