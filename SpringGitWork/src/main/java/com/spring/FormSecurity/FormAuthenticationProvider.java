package com.spring.FormSecurity;

import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.spring.finall.security.AuthenticationToken;
import com.spring.finall.security.SecurityUserVO;
import com.spring.finall.security.UserDetailsServiceImpl;

public class FormAuthenticationProvider implements AuthenticationProvider {

	public FormAuthenticationProvider() {
		System.out.println("FormAuthenticationProvider 자동주입?");
	}

	@Autowired
	public UserDetailsServiceImpl userDetailsServiceImpl;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		UsernamePasswordAuthenticationToken AuthenticationToken = (UsernamePasswordAuthenticationToken) authentication;

		// System.out.println(AuthenticationToken.toString());

//		WebAuthenticationDetails detail = (WebAuthenticationDetails)authentication.getDetails();
//		System.out.println("detail->>>>"+detail);


		String user_id = (String) AuthenticationToken.getPrincipal();
		SecurityUserVO user = (SecurityUserVO) userDetailsServiceImpl.loadUserByUsername(user_id);

		
		if (user != null) {

			String user_pwd = (String) AuthenticationToken.getCredentials();
			BCrypt.checkpw(user_pwd, user.getUser_pwd());

			if (BCrypt.checkpw(user_pwd, user.getUser_pwd())) {
				// 인증 처리 ..
				List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();

				if (user.getUser_role().equals("ROLE_ADMIN")) {
					grantedAuths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
				} else {
					grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));
				}

				// 개발자가 extends UsernamePasswordAuthenticationToken 을 상속한 AuthenticationToken
				UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(user_id,
						AuthenticationToken.getCredentials(), grantedAuths);

				return auth;
			} else {
				throw new RuntimeException("비빌번호가 잘못되었습니다.");
			}

		} else {
		
			System.out.println("아이없으면 널을 리턴하자.");
			return null;
		}

	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(AuthenticationToken.class);
	}

}