package com.wa.erp;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//===========================
//개발 다한 후에 적용해야한다.
//===========================


//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
//개발자가 만든 SessionInterceptor 클래스를 
//[인터셉터]로 등록하기 위한 MvcConfiguration 클래스 선언하기
//즉 설정을 위한 클래스이다.
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
@Configuration
	//-------------------------------------------
	// @Configuration ?
	//-------------------------------------------
		// 클래스 앞에 붙는다.
		// @Configuration 이 붙은 클래스는 자동 객체화 되어 스프링이 관리한다.
		// @Configuration 이 붙은 클래스는 설정 관련 메소드를 소유하고 있다.
		// @Configuration 이 붙은 WebMvcConfigurer 인터페이스를 구현한다.
public class MvcConfiguration implements WebMvcConfigurer{
//	SessionInterceptor 객체를 인터셉터로 등록하는 코딩이 내포된
//	addInterceptors 메소드를 오버라이딩 한다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		//---------------------------------------------------
		// InterceptorRegistry 객체의 
		// addInterceptor      메소드를 호출하여 SessionInterceptor 객체를 인터셉터로 등록하고
		// excludePathPatterns 메소드를 호출하여 인터셉터에서 예외되는 URL 주소 패턴을 등록한다.
		//---------------------------------------------------
		// Temporarily disabled to unblock login flow.
		// registry.addInterceptor(new SessionInterceptor()).excludePathPatterns(
		// 		"/loginForm.do","/loginProc.do","/js/**","/style/**","/images/**","/memRegForm.do"
		// 		,"/memProc.do"
		// 		,"/comProc.do"
		// 		,"/personalRegForm.do"
		// 		,"/companyRegForm.do"
		// 		,"/freedome.do"
		// 		,"/newComer.do"
		// 		,"/qna.do"
		// 		,"/jobReady.do"
		// 		,"/interview.do"
		// 		,"/joongGo.do"
		// 		,"/12Wa.do"
		// 		,"/gongGoList.do"
		// 		,"/companyList.do"
		// 		,"/timeShare.do"
		// 		,"/buupList.do"
		// 		,"/prj.do"
		// 		,"/gongMo.do"
		// 		);
		
		
	}
}
