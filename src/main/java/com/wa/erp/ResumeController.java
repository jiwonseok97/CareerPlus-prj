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

@Controller
public class ResumeController {

	@Autowired
	private ResumeService resumeService;
	
	// 이력서열람 페이지 접속시 호출
	@RequestMapping( value ="/resumeList.do")
	public ModelAndView resumeList(
			BoardSearchDTO boardSearchDTO
			) {	
		int resumeListCnt = this.resumeService.getresumeListCnt( boardSearchDTO );
		int resumeListAllCnt = this.resumeService.getresumeListAllCnt(boardSearchDTO);
		System.out.println("컨트롤러"+resumeListCnt);
		Map<String,Integer> boardMap = Util.getPagingMap(
				boardSearchDTO.getSelectPageNo()	//선택한 페이지 번호
				,boardSearchDTO.getRowCntPerPage()	//페이지 당 보여줄 검색 행의 개수
				,resumeListCnt			//검색결과 개수
				);
		boardSearchDTO.setSelectPageNo(  (int)boardMap.get("selectPageNo")  ); 
		boardSearchDTO.setRowCntPerPage( (int)boardMap.get("rowCntPerPage") ); 
		boardSearchDTO.setBegin_rowNo(   (int)boardMap.get("begin_rowNo")   ); 
		boardSearchDTO.setEnd_rowNo(     (int)boardMap.get("end_rowNo")     );
		List<BoardDTO> resumeList = this.resumeService.getResumeList(boardSearchDTO);


		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("resumeList", resumeList);
		mav.addObject("resumeListCnt", resumeListCnt+"");
		mav.addObject("resumeListAllCnt", resumeListAllCnt);
		mav.addObject("boardMap", boardMap);
		mav.setViewName("resumeList.jsp");
		return mav;
	}
	
	
	

	@RequestMapping(value = "/comtoperProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> comtoperProc(BoardDTO boardDTO) {
	    Map<String, String> resultMap = new HashMap<String, String>();

	    int comtoperCnt = resumeService.insertcomtoper(boardDTO);

	    if (comtoperCnt == -1) {
	        resultMap.put("result", "check");
	    } else {
	        resultMap.put("result", String.valueOf(comtoperCnt));
	    }

	    return resultMap;
	}

	
	
	@RequestMapping( value ="/resumeListDetail.do")
	   public ModelAndView resumeListDetailForm( 
					@RequestParam(value="p_no") int p_no	
					,@RequestParam(value="resume_no") int resume_no	

			   ){	
				BoardDTO boardDTO = this.resumeService.getResume(p_no);
				List<BoardDTO> skillList = this.resumeService.getSkillList(resume_no);
				ModelAndView mav = new ModelAndView( );
				mav.addObject("skillList",skillList);
				mav.addObject("boardDTO", boardDTO);
				mav.setViewName("resumeListDetail.jsp");
				
				return mav;
			}
}