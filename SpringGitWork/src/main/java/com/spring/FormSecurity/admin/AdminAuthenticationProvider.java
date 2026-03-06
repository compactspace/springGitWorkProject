package com.spring.FormSecurity.admin;

import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import com.spring.finall.security.AuthenticationToken;
import com.spring.finall.security.UserDetailsVO2;
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


	    if (user == null) {
	        System.out.println("❌ 아이디 없음: " + userId);
	        throw new BadCredentialsException("존재하지 않는 사용자입니다.");
	    }

	    // 타입 체크 후 캐스팅
	    if (!(user instanceof UserAdminDetail)) {
	        throw new InternalAuthenticationServiceException("UserDetails 타입이 예상과 다릅니다.");
	    }

	 
	    
	    if (!BCrypt.checkpw(userPwd, user.getPassword())) {
	        throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
	    }
	    
	  
		
		
		
		
		// 인증 성공, 권한은 
		return new UsernamePasswordAuthenticationToken(user, userPwd, user.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(AuthenticationToken.class);
	}

}
