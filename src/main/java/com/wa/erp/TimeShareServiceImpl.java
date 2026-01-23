package com.wa.erp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TimeShareServiceImpl implements TimeShareService{
	
	@Autowired
	private TimeShareDAO timeShareDAO;
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// n행m열의 게시판 검색을 위한 gettimeShare 메소드 선언하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	//@Override
	public List<TimeShareDTO> gettimeShareList(TimeShareSearchDTO timeShareSearchDTO){
		//--------------------------------------
		List<TimeShareDTO> timeShareList = this.timeShareDAO.gettimeShareList(timeShareSearchDTO);
		return timeShareList;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 게시판 검색 개수 구하는 메소드 선언하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int gettimeShareListCnt( TimeShareSearchDTO timeShareSearchDTO ) {
		//--------------------------------------
		// BoardDAOImpl 객체의 getBoardListCnt 메소드를 호출하여
		// 게시판 검색 개수를 구하여 변수 boardListCnt 에 저장하기
		//--------------------------------------
		int timeShareListCnt = this.timeShareDAO.gettimeShareListCnt(timeShareSearchDTO);
		//--------------------------------------
		// 변수 boardListCnt 안의 데이터를 리턴하기
		//--------------------------------------
		return timeShareListCnt;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 게시판 총 개수 구하는 메소드 선언하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	public int gettimeShareAllCnt() {
		//--------------------------------------
		// BoardDAOImpl 객체의 getBoardListCnt 메소드를 호출하여
		// 게시판 총 개수를 구하여 변수 boardListCnt 에 저장하기
		//--------------------------------------
		int timeShareAllCnt = this.timeShareDAO.gettimeShareAllCnt();
		//--------------------------------------
		// 변수 boardListAllCnt 안의 데이터를 리턴하기
		//--------------------------------------
		return timeShareAllCnt;
	}
	
	
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 프리랜서 글 상세보기 화면에서 필요한 
// [1개 게시판 글]을 검색 해 리턴하는 메소드 선언.
// 매개변수로 검색할 게시판의 고유 번호가 들어온다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public TimeShareDTO gettimeShare(int b_no){
	//-------------------------------------------
	// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
	// [조회수 증가]하고 수정한 행의 개수를 얻는다
	//-------------------------------------------
	//int updateCount    = this.timeShareDAO.updateReadcount(b_no);
	//------------------------------------------
	// [BoardDAOImpl 객체]의  getBoard 메소드를 호출하여
	// [1개 게시판 글]을 얻는다
	//------------------------------------------
	TimeShareDTO timeShareDTO  = this.timeShareDAO.gettimeShare(b_no);
	//------------------------------------------
	// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
	//------------------------------------------
	return timeShareDTO;
	}
}
