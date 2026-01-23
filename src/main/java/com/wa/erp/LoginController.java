package com.wa.erp;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
public class LoginController {
	/*======================================================
	@Autowired
	접근지정자 인터페이스명 멤버변수명;
	    --------------------------------------------------
		위와 같은 멤버변수가 선언되면 아래와 같은 과정을 거친다.
			----------------------------------------------
			인터페이스명에 해당하는 인터페이스를 구현한 클래스를 찾아서
			객체화 하고 멤버변수에 객체의 메위주를 저장.
	==========================================================*/
	
	
	//===============================================
	//LoginService 인터페이스 구현한 클래스를 찾아서 객체화 해서
	//멤버변수 loginService 에 객체의 메위주를 저장.
	//즉 현재 LoginServiceImpl 객체의 메위주가 저장되어있음.
	//===============================================
	@Autowired
	private LoginService loginService;
	
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 웹브라우저가 "/loginForm.do" 라는 URL 주소로 접근하면 호출되는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		//--------------------------------------------------
		// URL 주소에 대응하여 호출되려면 메소드 앞에 
		// @RequestMapping( value="포트번호 이후 주소")  이라는 어노테이션이 붙어야한다.
		//--------------------------------------------------
		// <주의> @RequestMapping 이 붙은 메소드의 이름은 개발자 맘대로이다. 
		//        될수 있는 대로 URL 주소의 의도를 살리는 메소드 이름을 주는 것이 좋다.

	// --------------------------------------------------
	@RequestMapping(value="/loginForm.do")
	public ModelAndView loginForm(
			//--------------------------------------
			// HttpSession 객체의 메위주를 저장하는 매개변수 session 선언하기
			// <주의>이 HttpSession 객체는 이전에 loginForm.do 로 접속 시 생성된 놈이다.
			// 이놈이 매개변수로 들어온다는 말은 뭔가 맡기겠다는 의미이다.
			// 로그인이 성공하면 아이디를 맡길 예정이다.
			//--------------------------------------
			HttpSession session
			) {
		
				//--------------------------------------------------
				// HttpSession 객체에 키값 "mid" 에 붙어 저장된 데이터 지우기
				// 즉 예전에 로그인 성공했을 때 HttpSession 객체에 저장한 로그인 아이디를 삭제한다.
				// 즉 로그 아웃을 한다.
				//--------------------------------------------------
				session.removeAttribute("mid");
				session.removeAttribute("pwd");
				session.removeAttribute("member");
				session.removeAttribute("nickname");
				session.removeAttribute("board");
				session.removeAttribute("admin_no");
				session.removeAttribute("p_no");
				session.removeAttribute("c_no");
				session.removeAttribute("is_block");

		
				//--------------------------
				//[ModelAndView 객체] 생성하기
				//--------------------------
				ModelAndView mav = new ModelAndView();
				//--------------------------------------------------
				// [ModelAndView 객체]의 setViewName 메소드 호출하여  
				// [호출할 JSP 페이지명]을 문자로 저장하기
				//--------------------------------------------------
		
				mav.setViewName("loginForm.jsp");
				
				// [ModelAndView 객체] 리턴하기
					//[ModelAndView 객체]를 리턴한 후 스프링은
					// [ModelAndView 객체] 저장된 JSP 페이지를 찾아 호출한다.
				return mav;
			}
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// URL 주소  /loginProc.do 로 접근하면 호출되는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 메소드 앞에 
	// @RequestMapping(~,~,produces="application/json;charset=UTF-8") 하고
	// @ResponseBody  가 붙으면 리턴하는 데이터가 웹브라우저에게 전송된다.
	@RequestMapping(
			value="/loginProc.do"
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int loginProc(
			@RequestParam( value="mid" ) String mid
			,@RequestParam( value="pwd" ) String pwd
			,@RequestParam(value="board") String board
//			,@RequestParam( value="autoLogin", required=false) String autoLogin
			,HttpSession session
			,HttpServletResponse response
			) {
		
				Map<String,String> map = new HashMap<String,String>();
				
				map.put("mid", mid);
				map.put("pwd", pwd);
				map.put("board", board);
				
				int checkpercom = this.loginService.checkpercom(map);
				
				map.put("member",checkpercom+"");
				
				BoardDTO getMem= this.loginService.getMem(map);

				if(checkpercom==1) {
					//개인
					session.setAttribute("member", "person" );
					session.setAttribute("p_no", getMem.getP_no());
					session.setAttribute("nickname", getMem.getNickname());
					session.setAttribute("is_block", getMem.getIs_block());
					int is_resume = this.loginService.getIs_resume(map);
					if(is_resume == 1) {return 3;}
				}
				else if(checkpercom==2) {
					//기업
					session.setAttribute("member", "company");
					session.setAttribute("c_no", getMem.getC_no());
					session.setAttribute("name", getMem.getName());
					int is_info = this.loginService.getIs_info(map);
					if(is_info==1) {return 4;}
				}
				else if(checkpercom==5) {
					session.setAttribute("member", "admin");
					session.setAttribute("admin_no", getMem.getAdmin_no());

				}
				else {
					return checkpercom;
				}
				
				
				
				
				
				
//				System.out.println("p_no"+getNo);
//				만약에 midPwdCnt 변수안의 데이터가 1이면, 즉 아이디와 암호가 DB에 있으면
				
				//--------------------------------------
				// 매개변수 autoLogin 에 null 이 저장되어 있으면
				// 즉  [아이디,암호 자동 입력] 의사 없으면
				//--------------------------------------
					
//				System.out.print(autoLogin);
				//--------------------------------------
				// 매개변수 autoLogin 에 "yes" 이 저장되어 있으면(=[아이디,암호 자동 입력]의사 있을 경우 )
				//--------------------------------------	
//				if(autoLogin!=null) {
					//---------------------------------------------------
					// Cookie 객체를 생성하고 쿠키명-쿠키값을 ["mid"-"입력아이디"]로 하기
					// Cookie 객체에 저장된 쿠키의 수명은 60*60*24으로 하기
					// Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd"-"입력암호"]로 하기
					// Cookie 객체에 저장된 쿠키의 수명은 60*60*24으로 하기
					//---------------------------------------------------
//					Cookie cookie1 = new Cookie("pid",pid);
//						cookie1.setMaxAge(60*60*24);
//					Cookie cookie2 = new Cookie("pwd",pwd);
//						cookie2.setMaxAge(60*60*24);
//						response.addCookie(cookie1);
//						response.addCookie(cookie2);
//					}
//				//--------------------------------------
				// 매개변수 autoLogin 에 null 이면
				// 즉  [아이디,암호 자동 입력] 의사 없으면
				//--------------------------------------
//				else {
//					Cookie cookie1 = new Cookie("pid",null);
//					cookie1.setMaxAge(0);
//					Cookie cookie2 = new Cookie("pwd",null);
//					cookie2.setMaxAge(0);
//					
//					response.addCookie(cookie1);
//					response.addCookie(cookie2);
//					}
//				}
				
				//로그인 아이디와 암호의 DB 존재 개수를 리턴하기.
				return checkpercom;
			}	
		
}







		/*
		@RequestMapping(value="/loginProc.do")
		public ModelAndView loginProc(
				@RequestParam( value="mid") String id, 
				@RequestParam( value="pwd") String pwd
				) {
			int idPwdCnt = 0;
			if(id.equals("abc")&&pwd.equals("123")) {			
				idPwdCnt = 1;
			}	
			
			//DB에 아이디와 암호의 존재 개수를 구하기.
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("idPwdCnt", idPwdCnt);
			mav.setViewName("loginProc.jsp");
			return mav;
		}*/