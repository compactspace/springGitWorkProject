package com.spring.finall.service;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.spring.finall.businessresult.SignUpSmsSendResult;

public interface SignUpSmsSendService {
	SignUpSmsSendResult requestSmsCode(String sessionId, String phone, HttpSession session, Model model);

	SignUpSmsSendResult verifySmsCode(String sessionId, HttpSession session, String inputCode, String token);

	SignUpSmsSendResult  aliveverifySmsCode(String sessionId, HttpSession session, String token);
	
	
	Long  isExpired(String sessionId, HttpSession session, String token);
 
	void removeSmsCooldown(HttpSession session);
	
	
}
