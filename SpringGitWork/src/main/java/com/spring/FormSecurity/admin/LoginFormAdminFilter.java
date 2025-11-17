package com.spring.FormSecurity.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.spring.finall.security.LoginSuccessHandler;

public class LoginFormAdminFilter extends UsernamePasswordAuthenticationFilter {

	private String usernameParameter = SPRING_SECURITY_FORM_USERNAME_KEY;
	private String passwordParameter = SPRING_SECURITY_FORM_PASSWORD_KEY;

	@Autowired
	public AdminAuthenticationProvider fp;

	public LoginFormAdminFilter() {
		super();
		setFilterProcessesUrl("/admin/logingo.do"); // 로그인 인증 필터에 로그인 검증 URL 등록
		setUsernameParameter(usernameParameter); // username custom 변수 등록
		setPasswordParameter(passwordParameter); // password custom 변수 등록
		setAuthenticationSuccessHandler(new LoginSuccessHandler());// 몰러 씨발 인증후 넘길
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {

		String name = request.getParameter("loginId");
		String password = request.getParameter("loginPwd");

		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(name, password);

		Authentication authentication = fp.authenticate(authRequest);

		return authentication;

	}
}
