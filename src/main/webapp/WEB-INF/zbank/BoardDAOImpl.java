package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
//	public List<Map<String,String>> getBoardList(){
//		
//		List<Map<String,String>> boardList = this.sqlSession.selectList(
//			"com.naver.erp.BoardDAO.getBoardList"
//		);
//	
//		
//		return boardList;
//	}

	
	public List<BoardDTO> getBoardList(){
//		sqlSessionTemplate 객체의
//		selectList 메소드를 호출하여
//		n행m열의 게시판 검색 결과물을 저장한 List<BoardDTO> 객체를 얻기
		List<BoardDTO> boardList = this.sqlSession.selectList(
//				실행할 sql구문의 위치를 지정하기
//					xml 파일 안의
//					<mapper namespace="com.naver.erp.BoardDAO">를 가진 mapper 태그 내부에
//					id="getBoardList" 를 가진 태그 내부의 sql 구문
				"com.naver.erp.BoardDAO.getBoardList"
				);
		
		
		return boardList;
	}

	public List<BoardDTO> getBoardListCnt(BoardSearchDTO boardSearchDTO){
//		sqlSessionTemplate 객체의
//		selectOne 메소드를 호출하여
//		게시판 검색 결과물을 개수를 저장한 boardListCnt를 얻기
		int boardListCnt = this.sqlSession.selectOne(
//				실행할 sql구문의 위치를 지정하기
//					xml 파일 안의
//					<mapper namespace="com.naver.erp.BoardDAO">를 가진 mapper 태그 내부에
//					id="getBoardListCnt" 를 가진 태그 내부의 sql 구문
				"com.naver.erp.BoardDAO.getBoardListCnt"
				, boardSearchDTO
				);
		
		
		return boardListCnt;
	}
	
//	1개 게시판 글 을 검색해 리턴하는 메소드 선언
//	매개변수로 검색할 게시판의 고유번호가 들어온다.
	public BoardDTO getBoard(int b_no) {
//		SqlSessionTemplate 객체의
//		selectOne 메소드를 호출하여
//		1행m열의 게시판 검색 결과물을 저장한 BoardDTO 객체를 얻기
		BoardDTO boardDTO = this.sqlSession.selectOne(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="getBoard" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.getBoard"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				,b_no
				);
//		1행 m열의 게시판 검색 결과물을 저장한 BoardDTO 객체를 리턴하기
		return boardDTO;
	}
	
//	[조회수 증가]하고 수정한 행의 개수를 얻는 메소드 선언
	public int updateReadCount(int b_no) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// update 메소드를 호출하여 
		// [조회수 증가]하고 수정한 행의 개수를 얻기
		//------------------------------------
		int updateCnt = this.sqlSession.update(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="updateReadcount" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.updateReadCount"
				, b_no
				);
			//------------------------------------
			// [조회수 증가]하고 수정한 행의 개수를 리턴하기
			//------------------------------------
			return updateCnt;
	}
	
	
//	암호의 존재 개수를 리턴하는 메소드 선언
//	만약 암호의 존재 개수가 0개면(=암호가 틀렸으면) -1 리턴하기
	public int getBoardPwdCnt( BoardDTO boardDTO ) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// selectOne 메소드를 호출하여 
		// 암호의 존재 개수를 얻기
		//------------------------------------
		int boardPwdCnt = this.sqlSession.selectOne(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="getBoardPwdCnt" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.getBoardPwdCnt"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				, boardDTO
				);
			//------------------------------------
			// 암호의 존재 개수를 얻기
			//------------------------------------
			return boardPwdCnt;
	}
	
//	1개 게시판 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	public int updateBoard(BoardDTO boardDTO) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// update 메소드를 호출하여 
		// 수정 적용행의 개수를 얻기
		//------------------------------------
		
		int updateCnt = this.sqlSession.update(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="updateBoard" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.updateBoard"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				, boardDTO
				);
			//------------------------------------
			// 수정 적용행의 개수를 리턴하기
			//------------------------------------
			return updateCnt;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 1개 게시판의 존재 개수 얻기
	// 만약 게시판의 존재 개수가 0개면 삭제되었다는 의미이다.
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int getBoardCnt(int b_no) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// selectOne 메소드를 호출하여 
		// 1개 게시판의 존재 개수를 얻기
		//------------------------------------
		int boardCnt = this.sqlSession.selectOne(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="getBoardCnt" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.getBoardCnt"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				,b_no
				);
		//------------------------------------
		// 1개 게시판의 존재 개수를 리턴하기
		//------------------------------------
		return boardCnt;
	}
	
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판] 삭제 실행하고 삭제 적용행의 개수를 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int deleteBoard(BoardDTO boardDTO) {
		int deleteCnt = this.sqlSession.delete(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="deleteBoard" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.deleteBoard"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				, boardDTO
				);
		//------------------------------------
		// 삭제 적용행을 리턴하기
		//------------------------------------
		return deleteCnt;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [1개 게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int insertBoard(BoardDTO boardDTO) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// insert 메소드를 호출하여 
		// 입력 적용행의 개수를 얻기
		//------------------------------------
		int insertCnt = this.sqlSession.insert(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="insertBoard" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.insertBoard"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				, boardDTO
				);
		//------------------------------------
		// 1개 게시판의 존재 개수를 리턴하기
		//------------------------------------
		return insertCnt;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 엄마글의 후손 글 출력 순서번호를 1 업데이트하는 메소드 선언하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int upPrintNo(BoardDTO boardDTO) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// update 메소드를 호출하여 
		// 수정 적용행의 개수를 얻기
		//------------------------------------
		int upPrintNoCnt = this.sqlSession.update("com.naver.erp.BoardDAO.upPrintNo"
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="upPrintNo" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				, boardDTO
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				);
		//------------------------------------
		// 수정 적용행의 개수를 리턴하기
		//------------------------------------
		return upPrintNoCnt;
				
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 자식글의 개수를 리턴하는 메소드 -->
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int getBoardChildrenCnt(BoardDTO boardDTO) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// selectOne 메소드를 호출하여 
		// 자식글의 개수를 얻기
		//------------------------------------
		int boardChildrenCnt = this.sqlSession.selectOne(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="getBoardChildrenCnt" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.getBoardChildrenCnt"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				, boardDTO
				);
		//------------------------------------
		// 자식글의 개수를 리턴하기
		//------------------------------------
		return boardChildrenCnt;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
	// 제목과 내용을 '삭제된 게시물입니다.' 라고 수정하는 메소드 선언하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
	public int updateBoardEmpty(BoardDTO boardDTO) {
		//------------------------------------
		// SqlSessionTemplate 객체의 
		// update 메소드를 호출하여 
		// 수정 적용행의 개수를 얻기
		//------------------------------------
		int updateBoardEmptyCnt = this.sqlSession.update(
				//------------------------------------
				// 실행할 SQL 구문의 위치를 지정하기
				//------------------------------------
					//------------------------------------
					// xml 파일 안의 
					// <mapper namespace="com.naver.erp.BoardDAO"> 를 가진 mapper 태그 내부에
					// id="updateBoardEmpty" 를 가진 태그 내부의 SQL 구문
					//------------------------------------
				"com.naver.erp.BoardDAO.updateBoardEmpty"
				//------------------------------------
				// SQL 구문에 참여할 데이터
				//------------------------------------
				,boardDTO
				);
		//------------------------------------
		// 수정 적용행의 개수를 리턴하기
		//------------------------------------
		return updateBoardEmptyCnt;
	}
	
	
	
	
	
	
	
	
//	public List<BoardDTO> getSearchBoardList(){
////		sqlSessionTemplate 객체의
////		selectList 메소드를 호출하여
////		n행m열의 게시판 검색 결과물을 저장한 List<BoardDTO> 객체를 얻기
//		List<BoardDTO> searchboardList = this.sqlSession.selectList(
////				실행할 sql구문의 위치를 지정하기
////					xml 파일 안의
////					<mapper namespace="com.naver.erp.BoardDAO">를 가진 mapper 태그 내부에
////					id="getBoardList" 를 가진 태그 내부의 sql 구문
//				"com.naver.erp.BoardDAO.getSearchBoardList"
//				);
//		
//		
//		return searchboardList;
//	}
}
