package com.spring.login.serviceImple.ToBe;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.UserVO;

@Repository
public class LoginDAOToBe {

	@Autowired
	public SqlSessionTemplate mybatis;
	
	
	public Object loginSignUpService(Map<String,Object> params) {
		
		System.out.println(params);
		UserVO	userVO=mybatis.selectOne("UserVO.loginSignUpToBe", params);
	
		Object userId=null;
		if(userVO!=null) {
			userId=userVO.getId();
		}
		
		return userId;
	}
	

}
