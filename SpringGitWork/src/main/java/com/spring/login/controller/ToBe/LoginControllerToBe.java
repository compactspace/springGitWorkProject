package com.spring.login.controller.ToBe;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.login.service.ToBe.LoginService;

@Controller
public class LoginControllerToBe {

	@Autowired
	public LoginService loginService;

	@RequestMapping(value = "/loginsignup.do")
	@ResponseBody
	public Map<String, Object> loginSignUp(@RequestBody Map<String, Object> params, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		int loginStatusCode = -1;
		Object id = loginService.loginSignUpService(params);
		if (id != null) {
			session.setAttribute("loginId", id);
			loginStatusCode = 1;
			map.put("loginId", id);
		}

		map.put("loginStatusCode", loginStatusCode);

		return map;
	}

	@RequestMapping(value = "/tobelogout.do")
	@ResponseBody
	public Map<String, Object> logout(HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		session.removeAttribute("loginId");
		int logOutStatusCode = 1;

		map.put("logOutStatusCode", logOutStatusCode);

		return map;
	}

}
