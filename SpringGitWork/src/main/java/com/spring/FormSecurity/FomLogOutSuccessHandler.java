package com.spring.FormSecurity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;


// 걍 상속 하지말고 밑자.. LogoutFilter  속에서 로그아웃석세스 핸들러 호출하니.. 로그아웃석세스헨들러 빈등록해서 그쪽에서
// 리다이렉트 러치하던 포워드 처리하던 하자.
public class FomLogOutSuccessHandler  implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
			System.out.println("로그아웃 성공 핸들러");
//			request.getSession().invalidate();
//			response.sendRedirect("securityloginform.jsp");
			
	}

	

}
