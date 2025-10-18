package com.spring.finall.service;

import javax.servlet.http.HttpServletRequest;

import com.spring.finall.AuthVO;

public interface SendMessageApiService {

	
	public abstract boolean sendMessage(String randomNumber, AuthVO vo);
	
	
	public abstract void insertAuthnum(AuthVO vo);

	public abstract boolean deleteAuthnum(AuthVO vo);
	
	
}
