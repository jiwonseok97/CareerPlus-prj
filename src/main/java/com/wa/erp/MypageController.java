package com.wa.erp;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MypageController {

    @Autowired
    private MypageService mypageService;

    @RequestMapping(value="/myPage.do")
	 public ModelAndView myPage(


HttpSession session
	){
    	
    	Object p_noObj = session.getAttribute("p_no");
        int p_no = 0;
        if(p_noObj != null) {
           p_no = Integer.parseInt(p_noObj.toString());
        }
    //	System.out.print("::"+session.getAttribute("p_no"));
    	
    List<MypageDTO>  MyPrivacy                     = this.mypageService.getMyPrivacy( p_no);
    List<MypageDTO>  MytimshareList            = this.mypageService.getMytimshareList(p_no);
   	List<MypageDTO>  ResumeList                   = this.mypageService.getResumeList( p_no);
    List<MypageDTO>  WriteList                         = this.mypageService.getWriteList(p_no);	
   	List<MypageDTO> ApplycompanyList       = this.mypageService.getApplycompanyList( p_no);
    List<MypageDTO> ScoutcompanyList      = this.mypageService.getScoutcompanyList( p_no);
    
    ModelAndView mav = new ModelAndView();	

	    mav.addObject("ScoutcompanyList", ScoutcompanyList);    	
	    mav.addObject("ApplycompanyList", ApplycompanyList);    	  	
		mav.addObject("MyPrivacy", MyPrivacy);
		mav.addObject("WriteList", WriteList);
		mav.addObject("MytimshareList", MytimshareList);
		mav.addObject("ResumeList", ResumeList);
		mav.setViewName("myPage.jsp");

		return mav;
	}
   
}
