package com.spring.finall.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


public class AuthenticationFilter extends UsernamePasswordAuthenticationFilter {

	public static final String SPRING_SECURITY_FORM_USERNAME_KEY = "username";
	public static final String SPRING_SECURITY_FORM_PASSWORD_KEY = "password";
	public static final String SPRING_SECURITY_CHECK = "security_check";

	private String usernameParameter = SPRING_SECURITY_FORM_USERNAME_KEY;
	private String passwordParameter = SPRING_SECURITY_FORM_PASSWORD_KEY;
	private String filterProcessesUrl = "logingo.do";

	public AuthenticationFilter() {

		super();
		setFilterProcessesUrl("/" + filterProcessesUrl); // 로그인 인증 필터에 로그인 검증 URL 등록
		setUsernameParameter(usernameParameter); // username custom 변수 등록
		setPasswordParameter(passwordParameter); // password custom 변수 등록
//		setAuthenticationSuccessHandler( new LoginSuccessHandler());// 몰러 씨발 인증후 넘길 핸들러 세팅
		System.err.println("UsernamePasswordAuthenticationFilter 슈퍼 호출");

	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {

		System.err.println("UsernamePasswordAuthenticationFilter 검증시도 시작.");
		String principal = request.getParameter("user_id");
		String credentials = request.getParameter("user_pwd");

		// 이름에 낚이지 말자 임시 비인증 객체를 만든다.
		AuthenticationToken authRequest = new AuthenticationToken(principal, credentials);

		 setDetails(request, authRequest);

		// 개발자가 구현한  implements AuthenticationProvider
		// 의 메서드 authenticate 를 호출하여 인증 된 객체를 받는다.
		Authentication authentication = this.getAuthenticationManager().authenticate(authRequest);
	
		return authentication;

	}



}
