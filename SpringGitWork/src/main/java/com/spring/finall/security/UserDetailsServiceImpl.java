package com.spring.finall.security;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	

	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public UserDetails loadUserByUsername(String user_id) {

		System.out.println("로드바이 호출않됨?");
		List<SecurityUserVO> executequery = mybatis.selectList("SecurityUserVO.loadUserByUsername", user_id);
	System.out.println("executequery " + executequery.get(0) );
	System.out.println("return executequery.get(0) " + executequery.get(0) );

		if (executequery.size() > 1 || executequery.size() <= 0 || executequery == null) {
			System.out.println("아이디 없으면 걍 로드바이 메서드에서 널값 리턴");
			return null;
		} else {

			return executequery.get(0);
		}

	}

}
