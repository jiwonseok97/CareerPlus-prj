package com.wa.erp;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
//LoginController 클래스 선언하기
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
/*
* 스프링에서 관용적으로 Controller 라는 단어가 들어간 클래스는 
* URL 주소 접속 시 대응해서 호출되는 메소드를 소유하고 있다.
* 클래스 이름 앞에는 @Controller 라는 어노테이션이 붙는다.
* 클래스 내부의 URL 주소 접속 시 호출되는 메소드명 앞에는
* @RequestMapping 이라는 어노테이션이 붙는다.
* ------------------------------------
* @Controller 어노테이션이 붙은 클래스 특징
* ------------------------------------
* 	(1) 스프링프레임워크가 알아서 객체를 생성하고 관리한다.
*  (2) URL 주소 접속 시 대응해서 호출되는 메소드를 소유하고 있다.
*/

@Controller
public class TimeShareController {

	@Autowired
	private TimeShareService timeShareService;
	
	
	// (프리랜서) 
	@RequestMapping( value="/timeShare.do")
	public ModelAndView timeShare( 
		
	TimeShareSearchDTO timeShareSearchDTO
	){			
	//--------------------------------------
	// 게시판 총 개수를 구해서 변수 timeShareAllCnt 에 저장하기
	//--------------------------------------
	int timeShareAllCnt =  this.timeShareService.gettimeShareAllCnt();
	
	
	//--------------------------------------
	// 게시판 검색 결과 개수를 구해서 변수 timeShareListCnt 에 저장하기
	// <주의> 페이징 처리 관련 데이터를 얻으려면 반드시 먼저 검색 결과 개수가  필요하다.
	//--------------------------------------
	int timeShareListCnt =  this.timeShareService.gettimeShareListCnt(timeShareSearchDTO);
	
	//--------------------------------------
	// 게시판 페이징 처리 관련 정보들 저장한 Map<String,Object> 객체 구하고
	// 이 객체의 메위주를 변수 boardMap 에 저장하기
	// 이 객체안의 대부분 정보는 boardList.jsp 페이지에서 사용될 예정이다.
	//--------------------------------------
	Map<String,Integer> boardMap = Util.getPagingMap(
			  timeShareSearchDTO.getSelectPageNo()       // 선택한 페이지 번호
			, timeShareSearchDTO.getRowCntPerPage()    // 페이지 당 보여줄 검색 행의 개수
			, timeShareListCnt                         // 검색 결과물 개수 
	);

	//-------------------------------------------------------------
	// 위에서 구한 Map<String,Integer> 객체 안의 데이터 중에
	//		선택 페이지 번호
	//      , 페이지 당 보일 행 개수
	//		, 테이블에서 검색 시 사용할 시작 행 번호
	//		, 테이블에서 검색 시 사용할 끝 행 번호
	//  를 BoardSearchDTO 객체 저장하기
	//-------------------------------------------------------------
	timeShareSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
	timeShareSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
	timeShareSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
	timeShareSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );

	// ******************************************************************* //
		
	List<TimeShareDTO> timeShare = this.timeShareService.gettimeShareList(timeShareSearchDTO);
	ModelAndView mav = new ModelAndView();
	
	mav.addObject("timeShare", timeShare);
	
	
	//--------------------------------------
	// [ModelAndView 객체]에 검색된 게시판의 개수를 저장하기
	// [ModelAndView 객체]에 게시판 총개수를 저장하기
	// [ModelAndView 객체]에 페이징 처리 관련 데이터를 가진 HashMap 객체를 저장하기
	//--------------------------------------
	mav.addObject("timeShareListCnt", timeShareListCnt+"" );
	mav.addObject("timeShareAllCnt", timeShareAllCnt );
	mav.addObject("boardMap", boardMap );
	
	//System.out.println( timeShareListCnt +" / "+timeShareAllCnt);
	// ******************************************************************* //

	mav.setViewName("timeShare.jsp");
	return mav;
	}
	

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// URL 주소 /timeShareDetailForm.do 로 접근하면 호출되는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@RequestMapping( value="/timeShareDetailForm.do")
	public ModelAndView timeShareDetailForm( 
			//--------------------------------------
			// "b_no" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 
			// 매개변수 b_no 에 저장하고 들어온다.
			// 즉 게시판 고유 번호가 매개변수 b_no 로 들어온다.
			//--------------------------------------
		@RequestParam(value="b_no") int b_no
		
	    ){	
		//--------------------------------
		// BoardServiceImpl 객체의 gettimeShare 메소드를 호출하여
		// 상세보기 화면에서 필요한 [1개의 게시판 글]을 가져오기
		//--------------------------------
		TimeShareDTO timeShareDTO = this.timeShareService.gettimeShare(b_no);
		//--------------------------------
		// [ModelAndView 객체] 생성하기
		//--------------------------------
		ModelAndView mav = new ModelAndView( );
		//--------------------------------
		// [ModelAndView 객체]에
		// 키값  "boardDTO" 에
		// 1행m열의 검색 데이터가 저장된 BoardDTO 객체 붙여 저장하기
		// ModelAndView 객체에 저장된 객체는
		// HttpServletRequest 객체에도 저장된다.
		//--------------------------------
		mav.addObject("timeShareDTO", timeShareDTO);
		//--------------------------------
		// [ModelAndView 객체]의 setViewName 메소드 호출하여  
		// [호출할 JSP 페이지명]을 문자로 저장하기
		//--------------------------------
		mav.setViewName("timeShareDetailForm.jsp");
		//--------------------------------
		// [ModelAndView 객체] 리턴하기
		// [ModelAndView 객체]를 리턴한 후에 스프링프레임워크가 JSP 페이지를 호출한다
		//--------------------------------
		return mav;
	}

}
