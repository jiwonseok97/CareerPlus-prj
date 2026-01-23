package com.wa.erp;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	

	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/myCompany.do")
	public ModelAndView myCompany(
			@RequestParam(value="c_no") int c_no)
			 {
		
		List<BoardDTO> gongMoList = this.boardService.getMyGongMoList(c_no);
		
		List<BoardDTO> gongGoList = this.boardService.getMyGongGoList(c_no);
		
		List<BoardDTO> myComapnyInfo = this.boardService.getMyCompanyInfo(c_no);
		
		List<BoardDTO> gonggoPertocom = this.boardService.getGonggoPertocom(c_no);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("gongGoList", gongGoList);
		
		mav.addObject("gongMoList", gongMoList);
		
		mav.addObject("myCompanyInfo", myComapnyInfo);
		
		mav.addObject("gonggoPertocom", gonggoPertocom);
		
		mav.setViewName("myCompany.jsp");
		
		return mav;
	}
	
	@RequestMapping(value="/memberRegForm.do")
	public ModelAndView memberRegForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberRegForm.jsp");
		return mav;
	}
	
	@RequestMapping(value="/personalRegForm.do")
	public ModelAndView personalRegForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("personalRegForm.jsp");
		return mav;
	}
	
	@RequestMapping(value="/companyRegForm.do")
	public ModelAndView companyRegForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("companyRegForm.jsp");
		return mav;
	}
	
	@RequestMapping(value="/resumRegForm.do")
	public ModelAndView resumRegForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("resumRegForm.jsp");
		return mav;
	}
	
	@RequestMapping(value="/companyUpdelForm.do")
	public ModelAndView companyUpdelForm(
			HttpSession session
			) {
		Object c_noObj = session.getAttribute("c_no");
		int c_no = 0;
		if(c_noObj != null) {
			c_no = Integer.parseInt(c_noObj.toString());
		}
		
		System.out.print(":"+c_no);
		
		BoardDTO boardDTO = this.memberService.getC_mem(c_no);
		
		ModelAndView mav = new ModelAndView();
		int max_no = this.memberService.getMem_c_no();
		
		mav.addObject("max_no", max_no);
		
		
		mav.addObject("boardDTO", boardDTO);
		mav.setViewName("companyUpdelForm.jsp");
		
		return mav;
	}
	
//	@RequestMapping(value="/timeShareRegForm.do")
//	public ModelAndView timeShareRegForm() {
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("timeShareRegForm.jsp");
//		return mav;
//	}
	
	@RequestMapping(
			value="/memProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
			)
	@ResponseBody
	public Map<String,String> insertMemProc(
			//-------------------------------------------
			//파라미터값이 저장된 [BoardDTO 객체]가 들어올 매개변수 선언
			//-------------------------------------------
				//[파라미터명]과 [BoardDTO 객체]의 멤버변수명이 같으면
				//setter 메소드가 작동되어 [파라미터값]이 [멤버변수]에 저장된다.
				MemberDTO memberDTO
			) {
//		게시판 수정 결과물을 저장할 HashMap 객체 생성하기.
		Map<String,String> resultMap = new HashMap<String,String>();

		

		//-------------------------------------------
		// [BoardServiceImpl 객체]의 updateBoard 메소드 호출로 
		// 게시판 글 수정하고 [수정 적용행의 개수] 얻기
		//-------------------------------------------
		int insertMemCnt = this.memberService.insertMember(memberDTO);
		
		System.out.print("+"+insertMemCnt);
		//-------------------------------------------
		// HashMap 객체에 게시판 수정 행의 개수 저장하기
		//-------------------------------------------
		resultMap.put("result", insertMemCnt+"");

		//-------------------------------------------
		// HashMap 객체의 메위주 리턴하기
		//-------------------------------------------
		return resultMap;
	}

	/*--------------회사회원가입----------------*/
	@RequestMapping( 
			value="/comProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String,String> comRegProc (  
			MemberDTO  companyDTO
	){

		Map<String,String> resultMap = new HashMap<String,String>();

		int companyRegCnt = this.memberService.insertCompany(companyDTO);

		resultMap.put( "result", companyRegCnt+"" );

		return resultMap;
	}
	/*----------------------------------------*/
	
	
	
	
	
	
	
	
	/*--------------회사정보등록----------------*/
	@RequestMapping( 
			value="/comUpDelProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String,String> comInfoProc (  
			MemberDTO  companyDTO
	){
		
		System.out.print(companyDTO.getMem_c_no());
		
		Map<String,String> resultMap = new HashMap<String,String>();

		int companyInfoCnt = this.memberService.insertCompanyInfo(companyDTO);

		System.out.println("=="+companyInfoCnt);
		resultMap.put( "result", companyInfoCnt+"" );

		return resultMap;
	}
	/*----------------------------------------*/
	
	//기업 회원 정보 수정
	@RequestMapping(value="/companySujungForm.do")
	
	public ModelAndView companySujungForm(
			
			@RequestParam(value = "c_no") int c_no
			
			) {
		
		
		BoardDTO boardDTO = this.boardService.getComInfoSujung(c_no);
		
		ModelAndView mav = new ModelAndView();
		
		 mav.addObject("boardDTO", boardDTO);

		// 주소를 공백으로 분리
	        String[] addressParts = boardDTO.getAddr().split(" ", 3);
	        
	        // 주소의 각 부분을 모델에 추가
	            mav.addObject("addr1", addressParts[0]); // 서울특별시
	            mav.addObject("addr2", addressParts[1]); // 성북구
	            mav.addObject("addr3", addressParts[2]); // 나머지 주소
		 
		mav.setViewName("companySujungForm.jsp");
		
		return mav;
	}
	
			// /boardUpProc.do 접속 시 호출되는 메소드 선언
				// <참고> boardUpDelForm.jsp 에서 수정 버튼 클릭했을 때 접속하는 URL 주소이다.
		   @RequestMapping(
				   
				   value="/comInfoUpProc.do"
				   ,method=RequestMethod.POST
				   ,produces="application/json;chaeset=UTF-8"
				   )
		   
		  @ResponseBody
		   public Map<String, String> comInfoUpProc(
				   // 파라미터값이 저장된 [BoardDTO 객체]가 들어올 매개변수 선언
				   		// [파라미터명]과 [BoardDTO 객체]의 [멤버변수명]이 같으면
				   		// setter 메소드가 작동되어 [파라미터명]이 [매개변수]에 저장된다.
				   BoardDTO boardDTO
				   
			) {
			   // 게시판 수정 결과물을 저장할 HashMap 객체 생성하기
			   Map<String, String> resultMap = new HashMap<String, String>();
			   // boardServiceImpl 객체의 updateBoard 메소드 호출로
			   // 게시판 글 수정하고 [수정 적용행의 개수] 얻기
			   
			   int comMemUpCnt = this.boardService.updateComMem(boardDTO);
			   	if(comMemUpCnt!=0) {
			   		int comInfoUpCnt = this.boardService.updateComInfo(boardDTO);			   
			   		
			   		int comWelUpCnt = this.boardService.updateComWel(boardDTO);
			   	}
			   
			   
			   // HashMap 객체에 게시판 수정 행의 개수 저장하기
			   resultMap.put("result", comMemUpCnt+"");
			   // HashMap 객체의 메위주 리턴하기
			   return resultMap;
			   
		   }
	
		   
}






