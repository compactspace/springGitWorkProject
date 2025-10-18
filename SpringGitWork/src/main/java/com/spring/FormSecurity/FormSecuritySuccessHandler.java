package com.spring.FormSecurity;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class FormSecuritySuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	String Role;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		System.out.println("------------------------------------------------");

		// 인증에 성공한뒤 인증된 객체를 List<GrantedAuthority> 으로 받는다.
		List<GrantedAuthority> list = (List<GrantedAuthority>) authentication.getAuthorities();

		System.out.println("성공핸들의 권한 리스트 체크 "+list.toString());
		for (GrantedAuthority g : list) {

			System.out.println("권한 목록들:  "+g);
		}

		SecurityContextHolder.getContext().setAuthentication(authentication);
		RequestDispatcher dispatcher=request.getRequestDispatcher("/loginsuccess.do");
		dispatcher.forward(request,response);

	}

}