package com.spring.finall.security;

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



public class AdminAuthenticationProvider implements AuthenticationProvider {

//	@Autowired
//	AdminAuth adminAuth;
	@Autowired
	public UserDetailsServiceImpl userDetailsServiceImpl;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {


		AuthenticationToken AuthenticationToken = (AuthenticationToken) authentication;	

//		WebAuthenticationDetails detail = (WebAuthenticationDetails)authentication.getDetails();
//		System.out.println("detail->>>>"+detail);


		// 주의 하라!
		// 필터에서 임시로 만든 인증객체를 받아와서
		// 현재 실제 DB랑 연동되는 메서드를 가져와서 인증객체에 속한 아이디 비번과 DB와의 아이디와 비번을 대조한후
		// ok이면 아래 인증처리 하는거고 아니면 fialer 핸들러 처리하면 될듯
		String user_id = (String) AuthenticationToken.getPrincipal();
		SecurityUserVO user = (SecurityUserVO) userDetailsServiceImpl.loadUserByUsername(user_id);

	
		
		// implements UserDetails 을 상속한 SecurityUserVO 클래스로
		// 임시 비인증 객체에 담긴 아이디와 비번을 대조한다.
		// 검증에 성공한다면 인증된 새로운 객체 sernamePasswordAuthenticationToken 을 만들어
		//success 헨들러로 간다.
		if (user != null) {			
			
			String user_pwd = (String) AuthenticationToken.getCredentials();
			BCrypt.checkpw(user_pwd, user.getUser_pwd());

			if (BCrypt.checkpw(user_pwd, user.getUser_pwd())) {
				// 인증 처리 ..
				List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
				
				if(user.getUser_role().equals("ROLE_ADMIN")) {
					grantedAuths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));	
				}else {
					grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));	
				}		

				// 개발자가 extends UsernamePasswordAuthenticationToken 을 상속한 AuthenticationToken
				UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(user_id, AuthenticationToken.getCredentials(), grantedAuths);
		
				return auth;
			}
			else {
				throw new RuntimeException("비빌번호가 잘못되었습니다.");
			}

		} else {
			//범인을 찾았다.  여기서 널값이면? 바로 페일러 핸들러로 가고
			// 널이 아니면 필터로가서 석세스 핸들러를 리턴하게 됨
			System.out.println("아이없으면 널을 리턴하자.");
			return null;
		}


	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(AuthenticationToken.class);
	}

}