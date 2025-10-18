package com.spring.login.serviceImple.ToBe;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.login.service.ToBe.LoginService;

@Service("LoginServiceToBe")
public class LoginServiceImple  implements LoginService{

	@Autowired
	public LoginDAOToBe loginDAO;
	
	
	
	@Override
	public Object loginSignUpService(Map<String, Object> params) {
		
		return loginDAO.loginSignUpService(params);
	}

}
