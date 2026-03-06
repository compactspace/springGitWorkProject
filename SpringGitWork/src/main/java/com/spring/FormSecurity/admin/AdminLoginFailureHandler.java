package com.spring.FormSecurity.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;

import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class AdminLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        // 실패 메시지 커스터마이징
        String errorMsg = "로그인 실패: " + exception.getMessage();
        request.getSession().setAttribute("LOGIN_ERROR", errorMsg);
        getRedirectStrategy().sendRedirect(request, response, "/admin/login-page?error=true");

    }
}