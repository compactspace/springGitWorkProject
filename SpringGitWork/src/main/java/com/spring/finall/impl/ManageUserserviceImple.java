package com.spring.finall.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.resDto.mannageUserListResPonse.ManageUserListResponseDTO;
import com.spring.finall.service.ManageUserService;

@Service
public class ManageUserserviceImple implements ManageUserService{

	
	@Autowired
	private ManageUserserviceImpleDAO manageUserserviceImpleDAO;
	
	@Override
	public List<ManageUserListResponseDTO> getUserList() {
		// TODO Auto-generated method stub
		return manageUserserviceImpleDAO.getUserList();
	}

}
