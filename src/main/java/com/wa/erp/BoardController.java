package com.wa.erp;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	
	// URL 주소 /boardList.do 로 접근하면 호출되는 메소드 선언
	@RequestMapping(value = "/freedome.do")
	public ModelAndView freedome(
			@RequestParam(value="boardname", required=false) String boardname,
				BoardSearchDTO boardSearchDTO
			) {
		
		boardSearchDTO.setBoardname(boardname);
		
//		게시판 검색 결과 개수 저장할 변수 boardListCnt 선언하여 저장하기
//		<주의> 페이징 처리 관련 데이터를 얻으려면 반드시 검색 결과 개수가 필요하다.
		int freedomeListCnt = this.boardService.getboardListCnt( boardSearchDTO );

		
//		게시판 총 개수 저장할 변수 boardListAllCnt 선언하여 저장하기
		int freedomeListAllCnt = this.boardService.getboardListAllCnt(boardSearchDTO);
		
		
		
		
//		게시판 페이징 처리관련 정보들 저장한 Map<String,Object> 객체 구하고
//		이 객체의 메위주를 변수 boardMap 에 저장하기
//		이 객체안의 모든 정보는 boardList.jsp 페이지에서 사용될 예정이다.
		Map<String,Integer> boardMap = Util.getPagingMap(
				boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
				,freedomeListCnt			//검색결과 개수
				);
		
		//-------------------------------------------------------------
		// BoardSearchDTO 객체에 
		//		선택 페이지 번호, 페이지 당 보일 행 개수
		//		테이블에서 검색 시 사용할 시작 행 번호
		//		테이블에서 검색 시 사용할 끝 행 번호
		// 저장하기.
		//-------------------------------------------------------------
		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		
		
		//--------------------------------------------------------------
		//BoardServiceImpl 객체의 getBoardList 메소드를 호출하여
		// n행m열의 게시판 검색 데이터가 저장된 List<BoardDTO> 객체 얻기
		//List<BoardDTO>객체의 메위주를 boardList에 저장한다.
		//--------------------------------------------------------------
		List<BoardDTO> freedomeList = this.boardService.getboardList(boardSearchDTO);
//		List<Map<String, String>> boardList = this.boardService.getBoardList();
		List<BoardDTO> noticeList = this.boardService.getNoticeList(boardSearchDTO);

		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		
		System.out.println(noticeList.size());
		//ModelAndView 객체 생성하기
		ModelAndView mav = new ModelAndView();
		
		//--------------------------------------------------------------
		//[ModelAndView 객체]에 키값 "boardList"에
		// n행m열의 검색 데이터가 저장된 List<BoardDTO> 객체 붙여 저장하기.
		//[ModelAndView 객체]에 저장된 객체는 [HttpServletRequest 객체] 에도 저장이 된다.
		//--------------------------------------------------------------
		mav.addObject("freedomeList", freedomeList);
		mav.addObject("noticeList", noticeList);

		//ModelAndView 객체 검색된 게시판의 개수를 저장한다.
		mav.addObject("freedomeListCnt", freedomeListCnt+"");

		//ModelAndView 객체 게시판의 총 개수를 저장한다.
		mav.addObject("freedomeListAllCnt", freedomeListAllCnt);

//		ModelAndView 객체에 페이징 처리 관련 데이터를 가진 HashMap 객체를 저장하기
		mav.addObject("boardMap", boardMap);

		
		//[ModelAndView 객체]의 setViewName 메소드 호출하여
		//[호출할 JSP 페이지명]을 문자로 저장하기
		mav.setViewName("freedome.jsp");

		//[ModelAndView 객체] 리턴하기
		//[ModelAndView 객체]를 리턴한 후에 Springframework가 JSP페이지를 호출한다.
		return mav;
		
		
		
	}
	
	
	
	
	
	//--------------------------------------------------------------------------------------
	// qna 게시판 불러오기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/qna.do")
	public ModelAndView qna(
			@RequestParam(value="boardname", required=false) String boardname,
			BoardSearchDTO boardSearchDTO
			) {
		
		boardSearchDTO.setBoardname(boardname);
		
		int qnaListCnt = this.boardService.getboardListCnt( boardSearchDTO );

		int qnaListAllCnt = this.boardService.getboardListAllCnt(boardSearchDTO);
		
		Map<String,Integer> boardMap = Util.getPagingMap(
				boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
				,qnaListCnt			//검색결과 개수
				);

		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		
		List<BoardDTO> qnaList = this.boardService.getboardList(boardSearchDTO);
		List<BoardDTO> noticeList = this.boardService.getNoticeList(boardSearchDTO);

		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("qnaList", qnaList);
		mav.addObject("noticeList", noticeList);

		mav.addObject("qnaListCnt", qnaListCnt+"");

		mav.addObject("qnaListAllCnt", qnaListAllCnt);

		mav.addObject("boardMap", boardMap);
		
		mav.setViewName("qna.jsp");
		return mav;
	}
	
	
	
	
	
	//--------------------------------------------------------------------------------------
	// interview 게시판 불러오기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/interview.do")
	public ModelAndView interview(
			@RequestParam(value="boardname", required=false) String boardname,
			BoardSearchDTO boardSearchDTO
			) {
		
		boardSearchDTO.setBoardname(boardname);
		
		int interviewListCnt = this.boardService.getboardListCnt( boardSearchDTO );

		int interviewListAllCnt = this.boardService.getboardListAllCnt(boardSearchDTO);
		
		Map<String,Integer> boardMap = Util.getPagingMap(
				boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
				,interviewListCnt			//검색결과 개수
				);

		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		List<BoardDTO> noticeList = this.boardService.getNoticeList(boardSearchDTO);
		System.out.println(noticeList.size());
		List<BoardDTO> interviewList = this.boardService.getboardList(boardSearchDTO);
		
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("interviewList", interviewList);
		mav.addObject("noticeList", noticeList);

		mav.addObject("interviewListCnt", interviewListCnt+"");

		mav.addObject("interviewListAllCnt", interviewListAllCnt);

		mav.addObject("boardMap", boardMap);
		
		mav.setViewName("interview.jsp");
		return mav;
	}
	

	
	
	
	
	//--------------------------------------------------------------------------------------
	// newComer 게시판 불러오기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/newComer.do")
	public ModelAndView newComer(
			@RequestParam(value="boardname", required=false) String boardname,
			BoardSearchDTO boardSearchDTO
			) {
		
		boardSearchDTO.setBoardname(boardname);
		
		int newComerListCnt = this.boardService.getboardListCnt( boardSearchDTO );

		int newComerListAllCnt = this.boardService.getboardListAllCnt(boardSearchDTO);
		
		Map<String,Integer> boardMap = Util.getPagingMap(
				boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
				,newComerListCnt			//검색결과 개수
				);

		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		List<BoardDTO> noticeList = this.boardService.getNoticeList(boardSearchDTO);

		List<BoardDTO> newComerList = this.boardService.getboardList(boardSearchDTO);
		
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("newComerList", newComerList);
		mav.addObject("noticeList", noticeList);

		mav.addObject("newComerListCnt", newComerListCnt+"");

		mav.addObject("newComerListAllCnt", newComerListAllCnt);

		mav.addObject("boardMap", boardMap);
		
		mav.setViewName("newComer.jsp");
		
		return mav;
	}
	
	
	
	
	
	//--------------------------------------------------------------------------------------
	// jobReady 게시판 불러오기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/jobReady.do")
	public ModelAndView jobReady(
			@RequestParam(value="boardname", required=false) String boardname,
			BoardSearchDTO boardSearchDTO
			) {
		
		boardSearchDTO.setBoardname(boardname);
		
		int jobReadyListCnt = this.boardService.getboardListCnt( boardSearchDTO );

		int jobReadyListAllCnt = this.boardService.getboardListAllCnt(boardSearchDTO);
		
		Map<String,Integer> boardMap = Util.getPagingMap(
				boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
				,jobReadyListCnt			//검색결과 개수
				);

		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		
		List<BoardDTO> jobReadyList = this.boardService.getboardList(boardSearchDTO);
		List<BoardDTO> noticeList = this.boardService.getNoticeList(boardSearchDTO);

		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("jobReadyList", jobReadyList);
		mav.addObject("noticeList", noticeList);

		mav.addObject("jobReadyListCnt", jobReadyListCnt+"");

		mav.addObject("jobReadyListAllCnt", jobReadyListAllCnt);

		mav.addObject("boardMap", boardMap);
		
		mav.setViewName("jobReady.jsp");
		
		return mav;
	}

	
	
	
	
	//--------------------------------------------------------------------------------------
	// joongGo 게시판 불러오기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/joongGo.do")
	public ModelAndView joongGo(
			@RequestParam(value="boardname", required=false) String boardname,
			BoardSearchDTO boardSearchDTO
			) {
		
		boardSearchDTO.setBoardname(boardname);
		
		int joongGoListCnt = this.boardService.getboardListCnt( boardSearchDTO );
		
		int joongGoListAllCnt = this.boardService.getboardListAllCnt(boardSearchDTO);
		System.out.print(boardSearchDTO.getTradetype());
		Map<String,Integer> boardMap = Util.getPagingMap(
				boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
				,joongGoListCnt			//검색결과 개수
				);
		
		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		List<BoardDTO> noticeList = this.boardService.getNoticeList(boardSearchDTO);

		List<BoardDTO> joongGoList = this.boardService.getboardList(boardSearchDTO);
		
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("joongGoList", joongGoList);
		mav.addObject("noticeList", noticeList);
		mav.addObject("joongGoListCnt", joongGoListCnt+"");
		
		mav.addObject("joongGoListAllCnt", joongGoListAllCnt);
		
		mav.addObject("boardMap", boardMap);
		
		mav.setViewName("joongGoList.jsp");
		
		return mav;
	}

	
	//=================================================
	//기업정보 리스트 불러오기
	//=================================================
	@RequestMapping( value ="/companyList.do")
	public ModelAndView companyList(
			BoardSearchDTO boardSearchDTO,
			HttpSession session
			) {

		Object p_noObj = session.getAttribute("p_no");
		int p_no = 0;
		if(p_noObj != null) {
			p_no = Integer.parseInt(p_noObj.toString());
		}
		
		int companyListCnt = this.boardService.getcompanyListCnt(boardSearchDTO);
		int companyListAllCnt = this.boardService.getcompanyListAllCnt(boardSearchDTO);
		
		Map<String, Integer> boardMap = Util.getPagingMap(boardSearchDTO.getSelectPageNo() // 선택한 페이지 번호
				, boardSearchDTO.getRowCntPerPage() // 페이지 당 보여줄 검색 행의 개수
				, companyListCnt // 검색결과 개수
		);
		boardSearchDTO.setSelectPageNo((int) boardMap.get("selectPageNo"));
		boardSearchDTO.setRowCntPerPage((int) boardMap.get("rowCntPerPage"));
		boardSearchDTO.setBegin_rowNo((int) boardMap.get("begin_rowNo"));
		boardSearchDTO.setEnd_rowNo((int) boardMap.get("end_rowNo"));
		List<BoardDTO> companyList = this.boardService.getcompanyList(boardSearchDTO);
		List<BoardDTO> like_company = this.boardService.getlikeCompany(p_no);
		
		ModelAndView mav = new ModelAndView();
		
		if(like_company.size()!=0) {
			   List<Integer> likeNoList = new ArrayList<>();
			   if (like_company != null) {
				    for (int i = 0; i < like_company.size(); i++) {
				        BoardDTO likeDTO = like_company.get(i);
				        int likeNo = likeDTO.getC_no();
				        if (likeNo != 0) {
				            likeNoList.add(likeNo);
				        }   
				    }
			   }
			mav.addObject("likeNoList", likeNoList);
		}
		
		mav.addObject("companyListCnt", companyListCnt + "");
		mav.addObject("companyListAllCnt", companyListAllCnt);
		mav.addObject("boardMap", boardMap);
		mav.addObject("companyList", companyList);
		mav.addObject("companyListCnt", companyListCnt+"");
		
		mav.addObject("companyListAllCnt", companyListAllCnt);
		
		mav.addObject("boardMap", boardMap);
		mav.setViewName("companyList.jsp");
		return mav;
	}
	
	
	
	

	


	
	//--------------------------------------------------------------------------------------
	// 자유게시판 상세보기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/freedomeDetailForm.do")
	public ModelAndView freedomeDetailForm(
			//--------------------------------------
			// "b_no" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 
			// 매개변수 b_no 에 저장하고 들어온다.
			// 즉 게시판 고유 번호가 매개변수 b_no 로 들어온다.
			// RequestParam으로 파라미터값을 불러오면 반드시 파라미터값이 있어야한다.
			// 파라미터 값은 모두 문자로 처리된다. int b_no 에서 int로 변환한다.
			//--------------------------------------
			@RequestParam(value="Detail_b_no") int b_no,
			@RequestParam(value="Detail_board") String table,
			@RequestParam(value="Comment_board") String comment,
			@RequestParam(value="comment_sort", required=false) String sort,
			@RequestParam(value="p_no", required=false) int p_no,
			@RequestParam(value="c_no", required=false) int c_no
			
			) {
		
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("tablename", table);
		paramMap.put("b_no", b_no);
		paramMap.put("comment",comment );
		paramMap.put("sort", sort);
		paramMap.put("p_no", p_no);
		paramMap.put("c_no", c_no);
		
//		BoardServiceImpl 객체의 getBoard 메소드를 호출하여
//		상세보기 화면에서 필요한 [1개의 게시판 글] 가져오기
		BoardDTO boardDTO = this.boardService.getBoard(paramMap);
		List<BoardDTO> commentList = this.boardService.getComment(paramMap);
		
		//ModelAndView 객체 생성하기
		ModelAndView mav = new ModelAndView();
		
		if(c_no!=0 || p_no!=0) {
			List<BoardDTO> commentLike = this.boardService.getCommentLike(paramMap);		
			   List<Integer> likeNoList = new ArrayList<>();
			   if (commentLike != null) {
				    for (int i = 0; i < commentLike.size(); i++) {
				        BoardDTO likeDTO = commentLike.get(i);
				        int likeNo = likeDTO.getLike_no();
				        if (likeNo != 0) {
				            likeNoList.add(likeNo);
				        }   
				    }
			   }
			mav.addObject("likeNoList", likeNoList);
		}
		
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("commentList", commentList);
		
		//[ModelAndView 객체]의 setViewName 메소드 호출하여
		//[호출할 JSP 페이지명]을 문자로 저장하기
		mav.setViewName("freedomeDetailForm.jsp");
		
		return mav;
		
	}

	
	
	
	
	
	
	
	//--------------------------------------------------------------------------------------
	// QnA게시판 상세보기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/qnaDetailForm.do")
	public ModelAndView qnaDetailForm(
			@RequestParam(value="Detail_b_no") int b_no,
			@RequestParam(value="Detail_board") String table,
			@RequestParam(value="Comment_board") String comment,
			@RequestParam(value="comment_sort", required=false) String sort,
			@RequestParam(value="p_no", required=false) int p_no,
			@RequestParam(value="c_no", required=false) int c_no
			) {
		
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("tablename", table);
		paramMap.put("b_no", b_no);
		paramMap.put("comment",comment );
		paramMap.put("sort", sort);
		paramMap.put("p_no", p_no);
		paramMap.put("c_no", c_no);
		
		BoardDTO boardDTO = this.boardService.getBoard(paramMap);
		List<BoardDTO> commentList = this.boardService.getComment(paramMap);

		ModelAndView mav = new ModelAndView();
		
		if(c_no!=0 || p_no!=0) {
			List<BoardDTO> commentLike = this.boardService.getCommentLike(paramMap);		
			   List<Integer> likeNoList = new ArrayList<>();
			   if (commentLike != null) {
				    for (int i = 0; i < commentLike.size(); i++) {
				        BoardDTO likeDTO = commentLike.get(i);
				        int likeNo = likeDTO.getLike_no();
				        if (likeNo != 0) {
				            likeNoList.add(likeNo);
				        }   
				    }
			   }
			mav.addObject("likeNoList", likeNoList);
		}
		
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("commentList", commentList);

		mav.setViewName("qnaDetailForm.jsp");
		
		return mav;
		
	}

	
	
	
	//--------------------------------------------------------------------------------------
	// 신입게시판 상세보기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/newComerDetailForm.do")
	public ModelAndView newComerDetailForm(
			@RequestParam(value="Detail_b_no") int b_no,
			@RequestParam(value="Detail_board") String table,
			@RequestParam(value="Comment_board") String comment,
			@RequestParam(value="comment_sort", required=false) String sort,
			@RequestParam(value="p_no", required=false) int p_no,
			@RequestParam(value="c_no", required=false) int c_no
			) {
		
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("tablename", table);
		paramMap.put("b_no", b_no);
		paramMap.put("comment",comment );
		paramMap.put("sort", sort);
		paramMap.put("p_no", p_no);
		paramMap.put("c_no", c_no);
		
		BoardDTO boardDTO = this.boardService.getBoard(paramMap);
		List<BoardDTO> commentList = this.boardService.getComment(paramMap);
		
		ModelAndView mav = new ModelAndView();
		
		if(c_no!=0 || p_no!=0) {
			List<BoardDTO> commentLike = this.boardService.getCommentLike(paramMap);		
			   List<Integer> likeNoList = new ArrayList<>();
			   if (commentLike != null) {
				    for (int i = 0; i < commentLike.size(); i++) {
				        BoardDTO likeDTO = commentLike.get(i);
				        int likeNo = likeDTO.getLike_no();
				        if (likeNo != 0) {
				            likeNoList.add(likeNo);
				        }   
				    }
			   }
			mav.addObject("likeNoList", likeNoList);
		}
		
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("commentList", commentList);
		
		mav.setViewName("newComerDetailForm.jsp");
		
		return mav;
		
	}

	
	
	
	
	
	
	
	
	//--------------------------------------------------------------------------------------
	// 신입게시판 상세보기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/jobReadyDetailForm.do")
	public ModelAndView jobReadyDetailForm(
			@RequestParam(value="Detail_b_no") int b_no,
			@RequestParam(value="Detail_board") String table,
			@RequestParam(value="Comment_board") String comment,
			@RequestParam(value="comment_sort", required=false) String sort,
			@RequestParam(value="p_no", required=false) int p_no,
			@RequestParam(value="c_no", required=false) int c_no
			) {
		
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("tablename", table);
		paramMap.put("b_no", b_no);
		paramMap.put("comment",comment );
		paramMap.put("sort", sort);
		paramMap.put("p_no", p_no);
		paramMap.put("c_no", c_no);
		
		BoardDTO boardDTO = this.boardService.getBoard(paramMap);
		List<BoardDTO> commentList = this.boardService.getComment(paramMap);
		
		ModelAndView mav = new ModelAndView();
		
		if(c_no!=0 || p_no!=0) {
			List<BoardDTO> commentLike = this.boardService.getCommentLike(paramMap);		
			   List<Integer> likeNoList = new ArrayList<>();
			   if (commentLike != null) {
				    for (int i = 0; i < commentLike.size(); i++) {
				        BoardDTO likeDTO = commentLike.get(i);
				        int likeNo = likeDTO.getLike_no();
				        if (likeNo != 0) {
				            likeNoList.add(likeNo);
				        }   
				    }
			   }
			mav.addObject("likeNoList", likeNoList);
		}
		
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("commentList", commentList);
		
		mav.setViewName("jobReadyDetailForm.jsp");
		
		return mav;
		
	}

	
	
	
	
	
	
	
	
	//--------------------------------------------------------------------------------------
	// 면접게시판 상세보기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/interviewDetailForm.do")
	public ModelAndView interviewDetailForm(
			@RequestParam(value="Detail_b_no") int b_no,
			@RequestParam(value="Detail_board") String table,
			@RequestParam(value="Comment_board") String comment,
			@RequestParam(value="comment_sort", required=false) String sort,
			@RequestParam(value="p_no", required=false) int p_no,
			@RequestParam(value="c_no", required=false) int c_no
			) {
		
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("tablename", table);
		paramMap.put("b_no", b_no);
		paramMap.put("comment",comment );
		paramMap.put("sort", sort);
		paramMap.put("p_no", p_no);
		paramMap.put("c_no", c_no);
		
		BoardDTO boardDTO = this.boardService.getBoard(paramMap);
		List<BoardDTO> commentList = this.boardService.getComment(paramMap);
		
		ModelAndView mav = new ModelAndView();
		
		if(c_no!=0 || p_no!=0) {
			List<BoardDTO> commentLike = this.boardService.getCommentLike(paramMap);		
			   List<Integer> likeNoList = new ArrayList<>();
			   if (commentLike != null) {
				    for (int i = 0; i < commentLike.size(); i++) {
				        BoardDTO likeDTO = commentLike.get(i);
				        int likeNo = likeDTO.getLike_no();
				        if (likeNo != 0) {
				            likeNoList.add(likeNo);
				        }   
				    }
			   }
			mav.addObject("likeNoList", likeNoList);
		}
		
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("commentList", commentList);
		
		mav.setViewName("interviewDetailForm.jsp");
		
		return mav;
		
	}

	
	
	
	
	
	
	
	//--------------------------------------------------------------------------------------
	// 중고게시판 상세보기
	//--------------------------------------------------------------------------------------
	@RequestMapping( value ="/joongGoDetailForm.do")
	public ModelAndView joongGoDetailForm(
			@RequestParam(value="Detail_b_no") int b_no,
			@RequestParam(value="Detail_board") String table,
			@RequestParam(value="Comment_board") String comment,
			@RequestParam(value="comment_sort", required=false) String sort,
			@RequestParam(value="p_no", required=false) int p_no,
			@RequestParam(value="c_no", required=false) int c_no
			) {
		
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("tablename", table);
		paramMap.put("b_no", b_no);
		paramMap.put("comment",comment );
		paramMap.put("sort", sort);
		paramMap.put("p_no", p_no);
		paramMap.put("c_no", c_no);
		
		BoardDTO boardDTO = this.boardService.getBoard(paramMap);
		List<BoardDTO> commentList = this.boardService.getComment(paramMap);
		
		ModelAndView mav = new ModelAndView();
		
		if(c_no!=0 || p_no!=0) {
			List<BoardDTO> commentLike = this.boardService.getCommentLike(paramMap);		
			   List<Integer> likeNoList = new ArrayList<>();
			   if (commentLike != null) {
				    for (int i = 0; i < commentLike.size(); i++) {
				        BoardDTO likeDTO = commentLike.get(i);
				        int likeNo = likeDTO.getLike_no();
				        if (likeNo != 0) {
				            likeNoList.add(likeNo);
				        }   
				    }
			   }
			mav.addObject("likeNoList", likeNoList);
		}
		
		mav.addObject("boardDTO", boardDTO);
		mav.addObject("commentList", commentList);
		
		mav.setViewName("joongGoDetailForm.jsp");
		
		return mav;
		
	}
	

		
	
			//--------------------------------------------------------------------------------------
			// 기업정보 상세보기
			//--------------------------------------------------------------------------------------
			@RequestMapping( value="/companyListDetail.do")
			public ModelAndView companyListDetailForm( 
					
					@RequestParam(value="c_no") int c_no	,
					BoardReviewDTO boardReviewDTO,
					HttpSession session


			){	
				Object p_noObj = session.getAttribute("p_no");
				int p_no = 0;
				if(p_noObj != null) {
					p_no = Integer.parseInt(p_noObj.toString());
				}
				
				int reviewListAllCnt =  this.boardService.getReviewListAllCnt( );
				int reviewListCnt =  this.boardService.getReviewListCnt( boardReviewDTO );
				if(boardReviewDTO.getReviewSort()==""){
					boardReviewDTO.setReviewSort(null);
				}
				Map<String,Integer> boardMap = Util.getPagingMap(
						boardReviewDTO.getSelectPageNo()       
						, boardReviewDTO.getRowCntPerPage()    
						, reviewListCnt                         
				);
				boardReviewDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
				boardReviewDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
				boardReviewDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
				boardReviewDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     ); 
				BoardDTO boardDTO = this.boardService.getcompanyListDetail(c_no);
				BoardDTO welfare = this.boardService.getcompanyWelfare(c_no);

			    List<BoardReviewDTO> reviewContent = this.boardService.getreviewContent(boardReviewDTO);
			    List<BoardDTO> like_company = this.boardService.getlikeCompany(p_no);
				ModelAndView mav = new ModelAndView( );
				if(like_company.size()!=0) {
					   List<Integer> likeNoList = new ArrayList<>();
					   if (like_company != null) {
						    for (int i = 0; i < like_company.size(); i++) {
						        BoardDTO likeDTO = like_company.get(i);
						        int likeNo = likeDTO.getC_no();
						        if (likeNo != 0) {
						            likeNoList.add(likeNo);
						        }   
						    }
					   }
					mav.addObject("likeNoList", likeNoList);
				}
				mav.addObject("boardDTO", boardDTO);
			    mav.addObject("welfare", welfare);
			    mav.addObject("reviewContent", reviewContent);			    
				mav.setViewName("companyListDetail.jsp");
				mav.addObject("reviewListCnt", reviewListCnt+"" );
				mav.addObject("reviewListAllCnt", reviewListAllCnt );
				mav.addObject("boardMap", boardMap );
				return mav;
			}
			
			
			
			@RequestMapping( value ="/notice.do")
			public ModelAndView noticeList(
					BoardSearchDTO boardSearchDTO
					) {	
				int noticeListCnt = this.boardService.getnoticeListCnt( boardSearchDTO );
				int noticeListAllCnt = this.boardService.getnoticeListAllCnt(boardSearchDTO);
				Map<String,Integer> boardMap = Util.getPagingMap(
						boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
						,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
						,noticeListCnt			//검색결과 개수
						);
				boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
				boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
				boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
				boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
				List<BoardDTO> noticeList = this.boardService.getNoticeList(boardSearchDTO);


				
				
				ModelAndView mav = new ModelAndView();
				mav.addObject("noticeList", noticeList);
				mav.addObject("noticeListCnt", noticeListCnt+"");
				mav.addObject("noticeListAllCnt", noticeListAllCnt);
				mav.addObject("boardMap", boardMap);
				mav.setViewName("noticeList.jsp");
				System.out.println(noticeListAllCnt);
				return mav;
			}
			
			
			
			@RequestMapping( value="/noticeUpDelForm.do")
			public ModelAndView noticeUpDelForm( 
				//--------------------------------------
				// "b_no" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 
				// 매개변수 b_no 에 저장하고 들어온다.
				// 즉 게시판 고유 번호가 매개변수 b_no 로 들어온다.
				//--------------------------------------
				@RequestParam(value="n_no") int n_no	
			){	
				//--------------------------------
				// BoardServiceImpl 객체의 getBoardForUpDel 메소드를 호출하여
				// 수정/삭제 화면에서 필요한 [1개의 게시판 글]을 가져오기
				//--------------------------------
				BoardDTO boardDTO = this.boardService.getNoticeUpDel(n_no);
				ModelAndView mav = new ModelAndView( );
				
				mav.addObject("boardDTO", boardDTO);
				mav.setViewName("noticeUpDelForm.jsp");

				return mav;
		}
			
			
			
			
			@RequestMapping( value ="/12Wa.do")
			public ModelAndView Wa12(
					BoardSearchDTO boardSearchDTO
					, HttpSession session
					) {
				//아무나 접속
				List<BoardDTO> getSalaryData = this.boardService.getSalaryData();
				List<BoardDTO> getFieldData = this.boardService.getFieldGonggoData();
				List<BoardDTO> getRegionCounts = this.boardService.getRegionCounts();
				
				int noticeListCnt = this.boardService.getnoticeListCnt( boardSearchDTO );
				Map<String,Integer> boardMap = Util.getPagingMap(
						boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
						,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
						,noticeListCnt			);
				boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
				boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
				boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
				boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );		//검색결과 개수
				List<BoardDTO> noticeList = this.boardService.getMainNoticeList(boardSearchDTO);
				List<BoardDTO> popularCom = this.boardService.getpopularCom();
				
				List<Integer> SalaryList = new ArrayList<>();
				List<String> Range = new ArrayList<>();
				List<Integer> gonggoCnt = new ArrayList<>();
				List<Integer> companyCnt = new ArrayList<>();
				List<String> Field = new ArrayList<>();
				
				
				for (BoardDTO boardDTO : getSalaryData) {
					SalaryList.add(boardDTO.getCount_c_no());
					Range.add("'"+boardDTO.getSal_avg_range()+"'");	
				}

				for(int i=0; i<getFieldData.size(); i++) {
					BoardDTO boardDTO= getFieldData.get(i);
					gonggoCnt.add(boardDTO.getGonggo_count());
					companyCnt.add(boardDTO.getCompany_count());
					Field.add("'"+boardDTO.getField_name()+"'");
				}
				
				ModelAndView mav = new ModelAndView();
				//기업 로그인 시
				if("company".equals(session.getAttribute("member"))) {
					List<BoardDTO> getHope_Salary = this.boardService.getHope_Salary();
					List<BoardDTO> getHope_Field = this.boardService.getHope_Field();
					List<BoardDTO> getPer_RegionCnt = this.boardService.getPer_Region();
					
					List<Integer> Hope_Cnt = new ArrayList<>();
					List<String> Salary_Range = new ArrayList<>();
					List<Integer> Hope_PerCnt = new ArrayList<>();
					List<Integer> Apply_Cnt = new ArrayList<>();
					List<String> Hope_Field = new ArrayList<>();
					
					for(int i=0; i<getHope_Salary.size(); i++) {
						BoardDTO boardDTO= getHope_Salary.get(i);
						Hope_Cnt.add(boardDTO.getHope_cnt());
						Salary_Range.add("'"+boardDTO.getSalary_range()+"'");
					}
					for(int i=0; i<getHope_Field.size(); i++) {
						BoardDTO boardDTO= getHope_Field.get(i);
						Hope_PerCnt.add(boardDTO.getHope_cnt());
						Apply_Cnt.add(boardDTO.getApply_cnt());					
						Hope_Field.add("'"+boardDTO.getField_name()+"'");
					}
					
					mav.addObject("Hope_Cnt",Hope_Cnt);
					mav.addObject("Salary_Range",Salary_Range);
					mav.addObject("Hope_PerCnt",Hope_PerCnt);
					mav.addObject("Apply_Cnt",Apply_Cnt);
					mav.addObject("Hope_Field",Hope_Field);
					mav.addObject("getPer_RegionCnt",getPer_RegionCnt);
				}
				
				//관리자 로그인시
				if("admin".equals(session.getAttribute("member"))) {
					BoardDTO getSexRatio = this.boardService.getSexRatio();
					BoardDTO getMemberRatio = this.boardService.getMemberRatio();
					List<BoardDTO> getMemberPerMonthCnt = this.boardService.getMemberPerMonthCnt();

					List<String> month = new ArrayList<>();
		            List<Integer> company_count = new ArrayList<>();
		            List<Integer> person_count = new ArrayList<>();
		            
		            for(int i=0; i<getMemberPerMonthCnt.size(); i++) {
		                  BoardDTO boardDTO= getMemberPerMonthCnt.get(i);
		                  month.add("'"+boardDTO.getMonth()+"'");
		                  company_count.add(boardDTO.getCompany_count());
		                  person_count.add(boardDTO.getPerson_count());
		               }


					
					mav.addObject("getSexRatio",getSexRatio);
					mav.addObject("getMemberRatio",getMemberRatio);
					mav.addObject("month",month);
		            mav.addObject("company_count",company_count);
		            mav.addObject("person_count",person_count);

				}
				
				mav.addObject("SalaryData",SalaryList);
				mav.addObject("Range",Range);
				mav.addObject("gonggoCnt",gonggoCnt);
				mav.addObject("companyCnt",companyCnt);
				mav.addObject("Field",Field);
				mav.addObject("RegionCount",getRegionCounts);				
				mav.addObject("popularCom", popularCom);
				mav.addObject("noticeList", noticeList);
				mav.setViewName("main.jsp");
				return mav;
			}

			@RequestMapping( value ="/noticeDetail.do")
			   public ModelAndView noticeDetailForm( 
							@RequestParam(value="n_no") int n_no	
							

					){	
						BoardDTO boardDTO = this.boardService.getNotice(n_no);
						ModelAndView mav = new ModelAndView( );
						
						mav.addObject("boardDTO", boardDTO);
						mav.setViewName("noticeDetailForm.jsp");

						return mav;
					}

			//=================================================
			//회원정보 리스트 불러오기
			//=================================================
			@RequestMapping(value = "/memberList.do")
			public ModelAndView memberList(
			        BoardSearchDTO boardSearchDTO,
			        HttpSession session
			) {

			    Object p_noObj = session.getAttribute("p_no");
			    int p_no = 0;
			    if (p_noObj != null) {
			        p_no = Integer.parseInt(p_noObj.toString());
			    }

			    int memberListCnt = this.boardService.getMemberListCnt(boardSearchDTO);
			    int memberListAllCnt = this.boardService.getMemberListAllCnt(boardSearchDTO);
	
			    
				Map<String,Integer> boardMap = Util.getPagingMap(
						boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
						,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
						,memberListCnt			);
				boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
				boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
				boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
				boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );		//검색결과 개수
			    List<BoardDTO> memberList = this.boardService.getMemberList(boardSearchDTO);
			    

			    ModelAndView mav = new ModelAndView();


			    
			    mav.addObject("memberListCnt", memberListCnt);
			    mav.addObject("memberListAllCnt", memberListAllCnt);
			    mav.addObject("memberList", memberList);
				mav.addObject("boardMap", boardMap);

			    // boardMap 변수가 정의되지 않았으므로 추가가 필요합니다.
			    // Map<String, Object> boardMap = new HashMap<>();
			    // 필요에 따라 boardMap 초기화 및 사용
			    mav.setViewName("memberList.jsp");
			    return mav;
			}
			//=================================================
			//차단회원정보 리스트 불러오기
			//=================================================
			@RequestMapping(value = "/blockMemberList.do")
			public ModelAndView blockMemberList(
			        BoardSearchDTO boardSearchDTO,
			        HttpSession session
			) {

			    Object p_noObj = session.getAttribute("p_no");
			    int p_no = 0;
			    if (p_noObj != null) {
			        p_no = Integer.parseInt(p_noObj.toString());
			    }

			    int blockMemberListCnt = this.boardService.getBlockMemberListCnt(boardSearchDTO);
			    int blockMemberListAllCnt = this.boardService.getBlockMemberListAllCnt(boardSearchDTO);
	
			    
				Map<String,Integer> boardMap = Util.getPagingMap(
						boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
						,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
						,blockMemberListCnt			);
				boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
				boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
				boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
				boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );		//검색결과 개수
			    List<BoardDTO> blockMemberList = this.boardService.getBlockMemberList(boardSearchDTO);
			    

			    ModelAndView mav = new ModelAndView();


			    
			    mav.addObject("memberListCnt", blockMemberListCnt);
			    mav.addObject("memberListAllCnt", blockMemberListAllCnt);
			    mav.addObject("memberList", blockMemberList);
				mav.addObject("boardMap", boardMap);

			    // boardMap 변수가 정의되지 않았으므로 추가가 필요합니다.
			    // Map<String, Object> boardMap = new HashMap<>();
			    // 필요에 따라 boardMap 초기화 및 사용
			    mav.setViewName("blockMemberList.jsp");
			    return mav;
			}
}
