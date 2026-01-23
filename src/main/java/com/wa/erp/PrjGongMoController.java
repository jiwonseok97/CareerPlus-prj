package com.wa.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class PrjGongMoController {
   
	@Autowired
	private BoardService boardService;
	
	@RequestMapping( value ="/prj.do")
	public ModelAndView prj(
			BoardSearchDTO boardSearchDTO
			){
		
		int prjListAllCnt = this.boardService.getPrjListAllCnt(  );
		
		int prjListCnt = this.boardService.getPrjListCnt( boardSearchDTO );
		
		Map<String,Integer> boardMap = Util.getPagingMap(
				  boardSearchDTO.getSelectPageNo()       // 선택한 페이지 번호
					, boardSearchDTO.getRowCntPerPage()  // 페이지 당 보여줄 검색 행의 개수
					, prjListCnt           				 // 검색 결과물 개수 
			);
		
		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		
		List<BoardDTO> prjList = this.boardService.getPrjList(boardSearchDTO);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("prjList", prjList);
		
		mav.addObject("prjListCnt", prjListCnt+"");

		mav.addObject("prjListAllCnt", prjListAllCnt);

		mav.addObject("boardMap", boardMap);
		
		mav.setViewName("prj.jsp");
		
		return mav;
		
	}
	
	@RequestMapping(value="/prjRegForm.do")
	public ModelAndView prjRegForm(   ){
		
		ModelAndView mav = new ModelAndView( );
		
		mav.setViewName( "prjRegForm.jsp");

		return mav;
	}
	
	
	  @RequestMapping(
	   		value="/prjRegProc.do"
		   ,method=RequestMethod.POST
		   ,produces="application/json;chaeset=UTF-8"
	   )
	   
	  @ResponseBody
	  public Map<String, String> prjRegProc(
			  
			   BoardDTO boardDTO
			   
		)throws Exception{
	   
	   Map<String, String> resultMap = new HashMap<String, String>();
	   
	   int prjRegCnt = this.boardService.insertPrj(boardDTO);
	   
	   resultMap.put("result", prjRegCnt+"");
	   
	   return resultMap;
	   
	  }
	  
	  @RequestMapping( value ="/prjDetailForm.do")
		public ModelAndView prjDetailForm(
				
				@RequestParam(value="prj_no") int prj_no
				) {
			
			BoardDTO boardDTO = this.boardService.getPrj(prj_no);
			
			ModelAndView mav = new ModelAndView();
			
			mav.addObject("boardDTO", boardDTO);
			
			mav.setViewName("prjDetailForm.jsp");
			
			return mav;
			
		}
	  
	  //프로젝트 수정/삭제
	  @RequestMapping(value = "/prjUpDelForm.do")
	   
	   public ModelAndView prjUpDelForm(
			   
	         @RequestParam(value = "prj_no") int prj_no

	   ) {
		   
	      BoardDTO boardDTO = this.boardService.getPrjForUpDel(prj_no);
	      
	      ModelAndView mav = new ModelAndView();
	      
	      mav.addObject("boardDTO", boardDTO);

	      mav.setViewName("prjUpDelForm.jsp");

	      return mav;

	   }
	  
	  @RequestMapping(
			   
			   value="/prjUpProc.do"
			   ,method=RequestMethod.POST
			   ,produces="application/json;chaeset=UTF-8"
			   )
	   
	  @ResponseBody
	   public Map<String, String> prjUpProc(
			   
			   BoardDTO boardDTO
			   
		)throws Exception {
		   Map<String, String> resultMap = new HashMap<String, String>();
		   
		   int prjUpCnt = this.boardService.updatePrj(boardDTO);
		   
		   resultMap.put("result", prjUpCnt+"");
		   
		   return resultMap;
	   }
	  
	 @RequestMapping(
		   		value="/prjDelProc.do"
			   ,method=RequestMethod.POST
			   ,produces="application/json;chaeset=UTF-8"
		   )
	   
	 @ResponseBody
	 public Map<String, String> prjDelProc(
			   BoardDTO boardDTO
			   
		){
		   
		   Map<String, String> resultMap = new HashMap<String, String>();
		   
		   int prjDelCnt = this.boardService.deldatePrj(boardDTO);
		   
		   resultMap.put("result", prjDelCnt+"");
		   
		   return resultMap;
	  }
	  ///////////////////////////////////////////////////
	  //공모전 관련 코드
	  ///////////////////////////////////////////////////
	  @RequestMapping( value ="/gongMo.do")
		public ModelAndView gongMo(
				BoardSearchDTO boardSearchDTO
				) {
		  
		  int gongMoListAllCnt = this.boardService.getGongMoListAllCnt(  );
		  
		  int gongMoListCnt = this.boardService.getGongMoListCnt( boardSearchDTO );
		  
		  Map<String,Integer> boardMap = Util.getPagingMap(
				  boardSearchDTO.getSelectPageNo()       // 선택한 페이지 번호
					, boardSearchDTO.getRowCntPerPage()    // 페이지 당 보여줄 검색 행의 개수
					, gongMoListCnt           // 검색 결과물 개수 
			);
		  
		  	boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
			boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
			boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
			boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		  
		  
			List<BoardDTO> gongMoList = this.boardService.getGongMoList(boardSearchDTO);
			ModelAndView mav = new ModelAndView();
			
			mav.addObject("gongMoList", gongMoList);
			
			mav.addObject("gongMoListCnt", gongMoListCnt+"");
			
			mav.addObject("gongMoListAllCnt", gongMoListAllCnt);
			
			mav.addObject("boardMap", boardMap);
			
			System.out.println(gongMoListCnt +" / "+ gongMoListAllCnt);
			
			mav.setViewName("gongMo.jsp");
			return mav;
		}
	  
	  @RequestMapping(value="/gongMoRegForm.do")
		public ModelAndView gongMoRegForm(   ){
			
			ModelAndView mav = new ModelAndView( );
			
			mav.setViewName( "gongMoRegForm.jsp");

			return mav;
		}
	  
	  		@RequestMapping(
		   		value="/gongMoRegProc.do"
			   ,method=RequestMethod.POST
			   ,produces="application/json;chaeset=UTF-8"
		   )
		   
		  @ResponseBody
		  public Map<String, String> gongMoRegProc(
				  
				   BoardDTO boardDTO
				   
			)throws Exception{
		   
		   Map<String, String> resultMap = new HashMap<String, String>();
		   
		   int gongMoRegCnt = this.boardService.insertGongMo(boardDTO);
		   
		   resultMap.put("result", gongMoRegCnt+"");
		   
		   return resultMap;
		   
		  }
	  		
	  		@RequestMapping( value ="/gongMoDetailForm.do")
			public ModelAndView gongMoDetailForm(
					
					@RequestParam(value="comp_pk") int comp_pk
					) {
				
				BoardDTO boardDTO = this.boardService.getGongMo(comp_pk);
				
				ModelAndView mav = new ModelAndView();
				
				mav.addObject("boardDTO", boardDTO);
				
				mav.setViewName("gongMoDetailForm.jsp");
				
				return mav;
				
			}
	  
	  	//공모전 수정/삭제
	  	  @RequestMapping(value = "/gongMoUpDelForm.do")
	  	   
	  	   public ModelAndView gongMoUpDelForm(
	  	         // --------------------------------------
	  	         // "b_no" 라는 파라미터명에 해당하는 파라미터값을 꺼내서
	  	         // 매개변수 b_no 에 저장하고 들어온다.
	  	         // 즉 게시판 고유 번호가 매개변수 b_no 로 들어온다.
	  	         // 저런식으러 선언하면 파라미터는 필수로 들어와야한다 아니면 예외가 터짐
	  	         // 사실 숫자 문자지만 정수로 바꿔서 들어오는거다.
	  	         // --------------------------------------
	  	         @RequestParam(value = "comp_pk") int comp_pk

	  	   ) {
	  		   
	  		  // boardServiceImpl 객체의 getBoardForUpDel 메소드를 호출하여
	  		  // 수정/삭제 화면에 필요한 1개의 게시판 글을 가져오기
	  	      BoardDTO boardDTO = this.boardService.gongMoForUpDel(comp_pk);
	  	      System.out.print(comp_pk);
	  	      // [ModelAndView 객체] 생성하기
	  	      ModelAndView mav = new ModelAndView();
	  	      // --------------------------------
	  	      // [ModelAndView 객체]에
	  	      // 키값 "boardDTO" 에
	  	      // 1행m열의 검색 데이터가 저장된 BoardDTO 객체 붙여 저장하기
	  	      // ModelAndView 객체에 저장된 객체는
	  	      // HttpServletRequest 객체에도 저장된다.
	  	      // --------------------------------
	  	      mav.addObject("boardDTO", boardDTO);

	  	      mav.setViewName("gongMoUpDelForm.jsp");

	  	      return mav;

	  	   }
	  	  
	  	  @RequestMapping(
	  			   
	  			   value="/gongMoUpProc.do"
	  			   ,method=RequestMethod.POST
	  			   ,produces="application/json;chaeset=UTF-8"
	  			   )
	  	   
	  	  @ResponseBody
	  	   public Map<String, String> gongMoUpProc(
	  			   // 파라미터값이 저장된 [BoardDTO 객체]가 들어올 매개변수 선언
	  			   		// [파라미터명]과 [BoardDTO 객체]의 [멤버변수명]이 같으면
	  			   		// setter 메소드가 작동되어 [파라미터명]이 [매개변수]에 저장된다.
	  			   BoardDTO boardDTO
	  			   
	  		)throws Exception {
	  		   // 게시판 수정 결과물을 저장할 HashMap 객체 생성하기
	  		   Map<String, String> resultMap = new HashMap<String, String>();
	  		   // boardServiceImpl 객체의 updateBoard 메소드 호출로
	  		   // 게시판 글 수정하고 [수정 적용행의 개수] 얻기
	  		   int boardUpCnt = this.boardService.updateGongMo(boardDTO);
	  		   // HashMap 객체에 게시판 수정 행의 개수 저장하기
	  		   resultMap.put("result", boardUpCnt+"");
	  		   // HashMap 객체의 메위주 리턴하기
	  		   return resultMap;
	  	   }
	  	  
	  	  @RequestMapping(
	  		   		value="/gongMoDelProc.do"
	  			   ,method=RequestMethod.POST
	  			   ,produces="application/json;chaeset=UTF-8"
	  		   )
	  	   
	  	 @ResponseBody
	  	 public Map<String, String> gongMoDelProc(
	  			   BoardDTO boardDTO
	  			   
	  		) {
	  		   
	  		   Map<String, String> resultMap = new HashMap<String, String>();
	  		   
	  		   int boardDelCnt = this.boardService.deldateGongMo(boardDTO);
	  		   
	  		   resultMap.put("result", boardDelCnt+"");
	  		   
	  		   return resultMap;
	  	  }
}
