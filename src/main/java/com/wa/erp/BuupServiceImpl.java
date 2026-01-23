package com.wa.erp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BuupServiceImpl implements BuupService{
	
	@Autowired
	private BuupDAO buupDAO;

		//@Override
		public List<BuupDTO> getbuupList(BuupSearchDTO buupSearchDTO){
			List<BuupDTO> buupList = this.buupDAO.getbuupList(buupSearchDTO);
			return buupList;
		 }
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 게시판 검색 개수 구하는 메소드 선언하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public int getbuupListCnt( BuupSearchDTO buupSearchDTO ) {
			//--------------------------------------
			// BoardDAOImpl 객체의 getBoardListCnt 메소드를 호출하여
			// 게시판 검색 개수를 구하여 변수 boardListCnt 에 저장하기
			//--------------------------------------
			int buupListCnt = this.buupDAO.getbuupListCnt(buupSearchDTO);
			//--------------------------------------
			// 변수 boardListCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return buupListCnt;
		}
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 게시판 총 개수 구하는 메소드 선언하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public int getbuupListAllCnt() {
			//--------------------------------------
			// BoardDAOImpl 객체의 getBoardListCnt 메소드를 호출하여
			// 게시판 총 개수를 구하여 변수 boardListCnt 에 저장하기
			//--------------------------------------
			int buupListAllCnt  = this.buupDAO.getbuupListAllCnt();
			//--------------------------------------
			// 변수 boardListAllCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return buupListAllCnt ;
		}

		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 부업글 상세보기 화면에서 필요한 
		// [1개 게시판 글]을 검색 해 리턴하는 메소드 선언.
		// 매개변수로 검색할 게시판의 고유 번호가 들어온다.
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		public BuupDTO getbuup(int b_no) {
			//-------------------------------------------
			// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
			// [조회수 증가]하고 수정한 행의 개수를 얻는다
			//-------------------------------------------
		    //int updateCount    = this.boardDAO.updateReadcount(b_no);
			//------------------------------------------
			// [BoardDAOImpl 객체]의  getBoard 메소드를 호출하여
			// [1개 게시판 글]을 얻는다
			//------------------------------------------
			BuupDTO buupDTO  = this.buupDAO.getbuup(b_no);
			//------------------------------------------
			// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
			//------------------------------------------
			return buupDTO;
			}

}
