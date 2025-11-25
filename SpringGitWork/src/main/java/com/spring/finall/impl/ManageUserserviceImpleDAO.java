package com.spring.finall.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.resDto.mannageUserListResPonse.ManageUserListResponseDTO;

@Repository
public class ManageUserserviceImpleDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<ManageUserListResponseDTO> getUserList() {
	
		List<ManageUserListResponseDTO>   userList=mybatis.selectList("ManageUserMapper.getUserList");
		
		
		return userList;
	}

	
	

}
