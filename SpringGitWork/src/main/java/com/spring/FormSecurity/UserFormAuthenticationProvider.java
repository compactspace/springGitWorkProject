package com.spring.FormSecurity;

import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.spring.finall.security.UserDetailsServiceImpl2;
import com.spring.finall.security.UserDetailsVO2;

public class UserFormAuthenticationProvider implements AuthenticationProvider {

	public UserFormAuthenticationProvider() {
		System.out.println("FormAuthenticationProvider 자동주입?");
	}

	@Autowired
	public UserDetailsServiceImpl2 userDetailsServiceImpl2;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
System.out.println();
	    UsernamePasswordAuthenticationToken authToken = (UsernamePasswordAuthenticationToken) authentication;

	    String user_id = (String) authToken.getPrincipal();
	    String rawPassword = (String) authToken.getCredentials();

	    // 유저 조회
	    UserDetails userDetails = userDetailsServiceImpl2.loadUserByUsername(user_id);
	    
	    
	    System.out.println("유저디테일정보:"+userDetails);
	    
	    

	    if (userDetails == null) {
	        System.out.println("❌ 아이디 없음: " + user_id);
	        throw new BadCredentialsException("존재하지 않는 사용자입니다.");
	    }

	    // 타입 체크 후 캐스팅
	    if (!(userDetails instanceof UserDetailsVO2)) {
	        throw new InternalAuthenticationServiceException("UserDetails 타입이 예상과 다릅니다.");
	    }

	    UserDetailsVO2 user = (UserDetailsVO2) userDetails;

	    
	    System.out.println("✅ 로그인 유저 이름: " + user.getUser_name());
	    System.out.println("✅ 로그인 유저 권한: " + user.getUser_role());
	    System.out.println("✅ 일반 유저 로그인 인증 성공: " + user.getUsername());

	    
	    
	    
	    if (!BCrypt.checkpw(rawPassword, user.getPassword())) {
	        throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
	    }

	    List<GrantedAuthority> grantedAuths = new ArrayList<>();
	    grantedAuths.add(new SimpleGrantedAuthority(user.getUser_role()));

	    // principal에 user 객체 그대로 넣고 setDetails 제거
	    return new UsernamePasswordAuthenticationToken(user, null, grantedAuths);
	}


	@Override
	public boolean supports(Class<?> authentication) {
	    return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

}