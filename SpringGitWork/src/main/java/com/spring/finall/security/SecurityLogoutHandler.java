package com.spring.finall.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

public class SecurityLogoutHandler implements LogoutHandler {
	
	
	public SecurityLogoutHandler() {
		super();
	}
	

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		
		System.out.println("SecurityLogoutHandler 호출");
		HttpSession session = request.getSession(false);
		
	}

}
