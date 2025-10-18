package com.spring.finall.admin.adminService;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.finall.admin.adminRepository.UserInfoRepository;

public class UserInfoService {
	
	@Autowired
	UserInfoRepository userInfoRepository;
	
	public void test() {
		userInfoRepository.findAll();
	}

}
