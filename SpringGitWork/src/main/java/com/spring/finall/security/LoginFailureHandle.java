package com.spring.finall.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class LoginFailureHandle implements AuthenticationFailureHandler   {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		try {
			System.err.println("로그인 실패했다 그냥 꺼져");
			response.sendRedirect("/finall/loginfom.do");
		}catch(Exception E) {
			System.err.println("아이디없는걸로 로그인시  페일러 핸들러가 받은 에러는?");
			System.err.println(E);
			System.err.println("로그인 실패했다 그냥 꺼져");
			response.sendRedirect("/finall/loginfom.do");
		}
		
		
		

	}

}
