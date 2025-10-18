package com.spring.finall.jwt;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.spring.finall.security.AuthenticationToken;

//또 이제부터 정신 똑바로 차려야 한다..! 이제 석세스 핸들러에선 jwt를 발급할거다..

public class JwtLoginFilter extends UsernamePasswordAuthenticationFilter {
	private String usernameParameter = SPRING_SECURITY_FORM_USERNAME_KEY;
	private String passwordParameter = SPRING_SECURITY_FORM_PASSWORD_KEY;
	private String filterProcessesUrl = "logingo.do";

	public JwtLoginFilter() {
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

		System.out.println("UsernamePasswordAuthenticationFilter 검증시도 시작.");
		String principal = request.getParameter("user_id");
		String credentials = request.getParameter("user_pwd");

		// 스프링 시큐리티에서 username과 password를 검증하기 위해서는 
		// 여러가지 제공클래스token에 담아 아래 매니져의 인증 함수에 넘겨야함 무조건!
		// ex: AuthenticationToken,UsernamePasswordAuthenticationToken,RememberMeAuthenticationToken 등등
		//https://velog.io/@blessing333/Spring-Security1 의 중단부 참조.
		AuthenticationToken authRequest = new AuthenticationToken(principal, credentials);		
		
		//UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(principal, credentials);
		
		System.out.print("authRequest:  ");
		System.out.println(authRequest);
		
		// 여기서 드디어 사용자가 구현한 authenticate 을 호출하게 된다.
		
		Authentication authentication = this.getAuthenticationManager().authenticate(authRequest);
		System.out.println(authentication.getAuthorities());
		System.out.println("리턴직전??");
		return authentication;

		
	}

}