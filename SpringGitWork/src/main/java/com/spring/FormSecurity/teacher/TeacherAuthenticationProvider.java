package com.spring.FormSecurity.teacher;

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

import com.spring.finall.impl.ManageOnedayClassServiceImpl;
import com.spring.finall.security.AuthenticationToken;
import com.spring.finall.security.teacher.UserTeacherDetailServiceImple;
import com.spring.finall.service.ManageOnedayClassService;
import com.spring.finall.user.OneDayClassVO;

@Component  // ✅ 반드시 추가
public class TeacherAuthenticationProvider implements AuthenticationProvider {

	public TeacherAuthenticationProvider() {
		System.out.println("FormAuthenticationProvider 자동주입?");
	}

	@Autowired
	public UserTeacherDetailServiceImple userTeacherDetailServiceImple;
	
	 @Autowired
	    private ManageOnedayClassService manageOnedayClassService; // ✅ 이제 자동 주입됨

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		 String userId = (String) authentication.getPrincipal();
	        String userPwd = (String) authentication.getCredentials();

	        UserTeacherDetail user = (UserTeacherDetail) userTeacherDetailServiceImple.loadUserByUsername(userId);

	        if (user == null) {
	            throw new BadCredentialsException("Teacher not found");
	        }

	        if (!BCrypt.checkpw(userPwd, user.getPassword())) {
	            throw new BadCredentialsException("비밀번호가 잘못되었습니다.");
	        }

	        if (!user.isEnabled()) {
	            throw new BadCredentialsException("계정이 비활성화 상태입니다.");
	        }

	        
	        
	       
	        Long teacherId = user.getTeacher_id();

	        OneDayClassVO myOneDayClassInfo = manageOnedayClassService.getMyOneDayClassInfo(teacherId);
	        if (myOneDayClassInfo != null) {
	            user.setMyOneDayClassInfo(myOneDayClassInfo);

	            List<Map<String, Object>> activeMonthList = manageOnedayClassService.getMyActiveMonthList(teacherId);
	            if (activeMonthList != null && !activeMonthList.isEmpty()) {
	                user.setActiveMonthList(activeMonthList);
	            }
	        }

	    	
	    	
	    	
	        // 인증 성공, 권한은 UserTeacherDetail.getAuthorities()로 가져오기
	        return new UsernamePasswordAuthenticationToken(user, userPwd, user.getAuthorities());
	}


	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(AuthenticationToken.class);
	}

}