package com.spring.FormSecurity.teacher;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.spring.finall.service.ManageOnedayClassService;

public class TeacherLoginsuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {


	

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		 // 성공 시 리다이렉트
	    response.sendRedirect("/finall/");
	}

}
