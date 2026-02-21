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
public class GonggoController {

	@Autowired
	private GonggoService gonggoService;
	

	@RequestMapping( value ="/gongGoList.do")

	// 怨듦퀬 由ъ뒪??
	public ModelAndView gongGoList(

			BoardSearchDTO boardSearchDTO) {

		int gonggoListAllCnt = this.gonggoService.getGonggoListAllCnt(boardSearchDTO);

		int gonggoListCnt = this.gonggoService.getGonggoListCnt(boardSearchDTO);

		Map<String, Integer> boardMap = Util.getPagingMap(boardSearchDTO.getSelectPageNo() // ?좏깮???섏씠吏 踰덊샇
				, boardSearchDTO.getRowCntPerPage() // ?섏씠吏 ??蹂댁뿬以?寃???됱쓽 媛쒖닔
				, gonggoListCnt // 寃?됯껐怨?媛쒖닔
		);

		boardSearchDTO.setSelectPageNo((int) boardMap.get("selectPageNo"));
		boardSearchDTO.setRowCntPerPage((int) boardMap.get("rowCntPerPage"));
		boardSearchDTO.setBegin_rowNo((int) boardMap.get("begin_rowNo"));
		boardSearchDTO.setEnd_rowNo((int) boardMap.get("end_rowNo"));

		System.out.println("[gongGoList] selectPageNo=" + boardSearchDTO.getSelectPageNo()
				+ ", rowCntPerPage=" + boardSearchDTO.getRowCntPerPage()
				+ ", begin_rowNo=" + boardSearchDTO.getBegin_rowNo()
				+ ", end_rowNo=" + boardSearchDTO.getEnd_rowNo()
				+ ", keyword=" + boardSearchDTO.getKeyword()
				+ ", work_place=" + boardSearchDTO.getWork_place()
				+ ", industry=" + boardSearchDTO.getIndustry()
				+ ", gonggoStatus=" + boardSearchDTO.getGonggoStatus()
				+ ", sort=" + boardSearchDTO.getSort());
		/*
		 * System.out.print("?쒖옉"+boardSearchDTO.getBegin_rowNo());
		 * System.out.print("??+boardSearchDTO.getEnd_rowNo());
		 */

		List<GonggoDTO> gonggoList = this.gonggoService.getgongGoList(boardSearchDTO);

		System.out.println("[gongGoList] listSize=" + (gonggoList == null ? 0 : gonggoList.size())
				+ ", gonggoListCnt=" + gonggoListCnt
				+ ", gonggoListAllCnt=" + gonggoListAllCnt);
		ModelAndView mav = new ModelAndView();

		mav.addObject("gonggoList", gonggoList);
		mav.addObject("gonggoListAllCnt", gonggoListAllCnt);

		mav.addObject("gonggoListCnt", gonggoListCnt);
		mav.addObject("boardMap", boardMap);

		mav.setViewName("gongGoList.jsp");

		return mav;
	}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// /gonggo ?뷀뀒??
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
@RequestMapping(value="/gonggoDetailForm.do")
public ModelAndView gonggoDetailForm(
		@RequestParam(value="g_no") int g_no
		) {
	

	GonggoDTO gonggoDTO = this.gonggoService.getgonggoDetailForm(g_no);
	
	ModelAndView mav = new ModelAndView();
	
	mav.addObject("GonggoDTO", gonggoDTO);
	
	mav.setViewName("gongGoLocationListDetail.jsp");
	
	return mav;
}
// 怨듦퀬 ?섏젙
@RequestMapping( value ="/gongGoRegForm.do")
public ModelAndView gongGoRegForm(
		BoardSearchDTO boardSearchDTO
		) {
	
	ModelAndView mav = new ModelAndView();
	
	mav.setViewName("gongGoRegForm.jsp");
	return mav;
}

//怨듦퀬?깅줉 ?섏씠吏
	@RequestMapping( 
		value="/gongGoReg.do" 
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
)
@ResponseBody
public Map<String,String> gongGoRegProc (  
		GonggoDTO  gonggoDTO
){
	
	Map<String,String> resultMap = new HashMap<String,String>();
	
	int gongGoRegCnt = this.gonggoService.insertGongo(gonggoDTO);
	
	resultMap.put( "result", gongGoRegCnt+"" );
	
	return resultMap;
}
	
	// 怨듦퀬 ?섏젙/??젣?섏씠吏
	@RequestMapping(value = "/gonggoUpDelForm.do")
	
	public ModelAndView gonggoUpDelForm(

			@RequestParam(value = "g_no") int g_no) {
		
			System.out.println(g_no);
		GonggoDTO gonggoDTO = this.gonggoService.getGonggo(g_no);

			System.out.println("::"+gonggoDTO.getCareer());
			System.out.println("::"+gonggoDTO.getBenefit_code1());
			System.out.println("::"+gonggoDTO.getSalary());
			System.out.println("::"+gonggoDTO.getPosition_code1());
		ModelAndView mav = new ModelAndView();

		mav.addObject("gonggoDTO", gonggoDTO);

		mav.setViewName("gongGoUpDelForm.jsp");

		return mav;
	}
	
	// 怨듦퀬 ??젣
	@RequestMapping( 
			value="/gonggoDelProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public Map<String,String> gonggoDelProc( 
			GonggoDTO gonggoDTO	
	) {
		Map<String,String> resultMap = new HashMap<String,String>();
		
		int gonggoDelCnt = this.gonggoService.deleteFromGonggo(gonggoDTO);

		resultMap.put( "result", gonggoDelCnt+"" );
		
		return resultMap;
	}
	
	// 怨듦퀬 ?섏젙
	@RequestMapping(value = "/gonggoUpProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> gonggoUpProc(

			GonggoDTO gonggoDTO) {

		Map<String, String> resultMap = new HashMap<String, String>();

		int gonggoUpCnt = this.gonggoService.updateGonggo(gonggoDTO);

		resultMap.put("result", gonggoUpCnt + "");

		return resultMap;
	}
	
	// 怨듦퀬 ?대젰??吏??	
	@RequestMapping(value="/gonggoSupportProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
			)
	@ResponseBody
	public Map<String,String> gonggoSupport(
			GonggoDTO  gonggoDTO
			) {
		
	
		Map<String,String> resultMap = new HashMap<String,String>();
		
		int gonggoSupportCnt = this.gonggoService.gonggoSupport(gonggoDTO);

		resultMap.put( "result", gonggoSupportCnt+"" );
		
		return resultMap;
	}	
}

