package com.spring.FormSecurity.teacher;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

public class TeacherAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
	                     AuthenticationException authException) throws IOException {
	    // 권한 없는 요청에 대해 404 Not Found 응답 -> 그러나 친절히 알릴필요 없스니 가시적으로 없는페이지 입니다 처리
		
		response.sendRedirect(request.getContextPath() + "/err/notfound");
	}

}
