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
public class AuthenticationUserFilter extends UsernamePasswordAuthenticationFilter {

	private String usernameParameter = SPRING_SECURITY_FORM_USERNAME_KEY;
	private String passwordParameter = SPRING_SECURITY_FORM_PASSWORD_KEY;


	
	
	@Autowired
	public UserFormAuthenticationProvider  fp;	
	
	
	public AuthenticationUserFilter() {
		super();
		setFilterProcessesUrl("/guest/api/logingo.do");
		setUsernameParameter(usernameParameter); // username custom 변수 등록
		setPasswordParameter(passwordParameter); // password custom 변수 등록
		setAuthenticationSuccessHandler( new LoginSuccessHandler());// 몰러 씨발 인증후 넘길
		
		
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {
	    	System.out.println("내가떠야함");
		  String name = request.getParameter("loginId");   
		    String password = request.getParameter("loginPwd");
		    
		
		 UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(name, password);
		
	
		 
		 
		 
		 Authentication authentication = fp.authenticate(authRequest);		
		 
//		AuthenticationToken authRequest = new AuthenticationToken(name, password);	

//		
//		Authentication authentication = this.getAuthenticationManager().authenticate(authRequest);
		return authentication;

		
		
		
	}

}
