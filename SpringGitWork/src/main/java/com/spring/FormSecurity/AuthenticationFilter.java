package com.spring.FormSecurity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.spring.finall.security.LoginSuccessHandler;


// 스프링 시큐리티 경로에 잡히면 먼저 타는 선봉대장 Filter 이다.
public class AuthenticationFilter extends UsernamePasswordAuthenticationFilter {

	private String usernameParameter = SPRING_SECURITY_FORM_USERNAME_KEY;
	private String passwordParameter = SPRING_SECURITY_FORM_PASSWORD_KEY;
	private String filterProcessesUrl = "logingo.do";

	
	
	@Autowired
	public FormAuthenticationProvider  fp;	
	
	
	public AuthenticationFilter() {
		super();
		setFilterProcessesUrl("/" + filterProcessesUrl); // 로그인 인증 필터에 로그인 검증 URL 등록
		setUsernameParameter(usernameParameter); // username custom 변수 등록
		setPasswordParameter(passwordParameter); // password custom 변수 등록
		setAuthenticationSuccessHandler( new LoginSuccessHandler());// 몰러 씨발 인증후 넘길
		
		
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {
		
		String name = request.getParameter("user_id");
		String password = request.getParameter("user_pwd");
		//인터넷 님들아?? UsernamePasswordAuthenticationToken 는 안됨 자체 에러 처리하고 아무것도 않알려줌
		// 1시간 날림 이악물 안되니 AuthenticationToken 으로 간다...
		 UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(name, password);
		
	
		 
		 
		 
		 Authentication authentication = fp.authenticate(authRequest);		
		 
//		AuthenticationToken authRequest = new AuthenticationToken(name, password);	

//		
//		Authentication authentication = this.getAuthenticationManager().authenticate(authRequest);
		return authentication;

	}

}
