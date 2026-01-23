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
public class BuupController {

	@Autowired
	private BuupService buupService;

	    //(부업)
		@RequestMapping( value ="/buupList.do")
		public ModelAndView buupList(
		BuupSearchDTO buupSearchDTO
		){
				
		int buupListAllCnt =  this.buupService.getbuupListAllCnt();
		
		int buupListCnt =  this.buupService.getbuupListCnt(buupSearchDTO);
				
		Map<String,Integer> boardMap = Util.getPagingMap(
							  buupSearchDTO.getSelectPageNo()       // 선택한 페이지 번호
							, buupSearchDTO.getRowCntPerPage()    // 페이지 당 보여줄 검색 행의 개수
							, buupListCnt                         // 검색 결과물 개수 
		);		
		buupSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		buupSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		buupSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		buupSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		
//		System.out.print("시작"+boardSearchDTO.getBegin_rowNo());
//		System.out.print("끝"+boardSearchDTO.getEnd_rowNo());
		
			List<BuupDTO> buupList = this.buupService.getbuupList(buupSearchDTO);
			ModelAndView mav = new ModelAndView();
			mav.addObject("buupList", buupList);
			
			mav.addObject("buupListCnt", buupListCnt+"" );
			mav.addObject("buupListAllCnt", buupListAllCnt );
			mav.addObject("boardMap", boardMap );
			
			mav.setViewName("buupList.jsp");
			return mav;
		    }
		
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// URL 주소 /buupListDetailForm.do 로 접근하면 호출되는 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping( value="/buupListDetailForm.do")
		public ModelAndView buupListDetailForm( 
				//--------------------------------------
				// "b_no" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 
				// 매개변수 b_no 에 저장하고 들어온다.
				// 즉 게시판 고유 번호가 매개변수 b_no 로 들어온다.
				//--------------------------------------
				@RequestParam(value="b_no") int b_no	
		    ){	
			//--------------------------------
			// BoardServiceImpl 객체의 getbuup 메소드를 호출하여
			// 상세보기 화면에서 필요한 [1개의 부업 글]을 가져오기
			//--------------------------------
			BuupDTO buupDTO = this.buupService.getbuup(b_no);
			
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
			mav.addObject("buupDTO", buupDTO);
			//--------------------------------
			// [ModelAndView 객체]의 setViewName 메소드 호출하여  
			// [호출할 JSP 페이지명]을 문자로 저장하기
			//--------------------------------
			mav.setViewName("buupListDetailForm.jsp");
			//--------------------------------
			// [ModelAndView 객체] 리턴하기
			// [ModelAndView 객체]를 리턴한 후에 스프링프레임워크가 JSP 페이지를 호출한다
			//--------------------------------
			return mav;
		}		
		
}
