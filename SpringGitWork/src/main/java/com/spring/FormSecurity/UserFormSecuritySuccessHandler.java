package com.spring.FormSecurity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.spring.finall.security.UserDetailsVO2;

public class UserFormSecuritySuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	String Role;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
	                                    Authentication authentication) throws IOException, ServletException {

//	    System.out.println("------------------------------------------------"+authentication.getPrincipal());
//
//	    UserDetailsVO2 user = (UserDetailsVO2) authentication.getPrincipal();
//
//	    // 인증 객체를 UserDetailsVO2로 그대로 세션에 저장
//	    UsernamePasswordAuthenticationToken auth =
//	            new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
//
//	    SecurityContextHolder.getContext().setAuthentication(auth);
//
//	    System.out.println("로그인 성공, principal: " + user);

	    // 성공 시 리다이렉트
	    response.sendRedirect("/finall/");
	}


}