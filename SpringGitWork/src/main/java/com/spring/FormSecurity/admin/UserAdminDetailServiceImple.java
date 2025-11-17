package com.spring.FormSecurity.admin;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service("userAdminDetailServiceImple")
public class UserAdminDetailServiceImple implements UserDetailsService {

	
	@Autowired
	private SqlSessionTemplate mybatis;	
	
	
	@Override
	public UserAdminDetail loadUserByUsername(String username) throws UsernameNotFoundException {


		UserAdminDetail  userAdminDetail=mybatis.selectOne("UserAdminDetailMapper.selectByAdminUsername", username);	
		
		
		return userAdminDetail;
	}

}