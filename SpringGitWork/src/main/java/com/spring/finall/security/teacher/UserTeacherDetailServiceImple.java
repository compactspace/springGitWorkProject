package com.spring.finall.security.teacher;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.spring.FormSecurity.teacher.UserTeacherDetail;

@Service("userTeacherDetailServiceImple")
public class UserTeacherDetailServiceImple implements UserDetailsService {

	
	@Autowired
	private SqlSessionTemplate mybatis;	
	
	
	@Override
	public UserTeacherDetail loadUserByUsername(String username) throws UsernameNotFoundException {


		UserTeacherDetail  userTeacherDetail=mybatis.selectOne("UserTeacherDetailMapper.selectByUsername", username);	
		
		
		return userTeacherDetail;
	}

}
