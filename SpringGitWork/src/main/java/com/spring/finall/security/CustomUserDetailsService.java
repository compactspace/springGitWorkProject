package com.spring.finall.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.spring.finall.user.UserVO;

public class CustomUserDetailsService implements UserDetailsService{

	/*
	 * @Autowired private UserMapper userMapper;
	 */

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		// TODO Auto-generated method stub

		//베티스로 수정
		UserVO user =null;

		if(user == null) {
			throw new UsernameNotFoundException(userName);
		}

		//UserVO UserDetails 상속할것!!..
		return null;
	}
}
