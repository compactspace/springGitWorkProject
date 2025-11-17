package com.spring.FormSecurity.admin;

import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import com.spring.finall.security.AuthenticationToken;

import com.spring.finall.service.ManageOnedayClassService;

@Component  // ✅ 반드시 추가
public class AdminAuthenticationProvider implements AuthenticationProvider {

	public AdminAuthenticationProvider() {

	}

	@Autowired
	public UserAdminDetailServiceImple userAdminDetailServiceImple;

	@Autowired
	private ManageOnedayClassService manageOnedayClassService; // ✅ 이제 자동 주입됨

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		String userId = (String) authentication.getPrincipal();
		String userPwd = (String) authentication.getCredentials();

		UserAdminDetail user = (UserAdminDetail) userAdminDetailServiceImple.loadUserByUsername(userId);

		// 인증 성공, 권한은 
		return new UsernamePasswordAuthenticationToken(user, userPwd, user.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(AuthenticationToken.class);
	}

}
