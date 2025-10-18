package com.spring.finall.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.AuthVO;

@Repository
public class SendMessageApiDAObatis {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertAuthnum(AuthVO vo) {
		mybatis.insert("authVO.insertAuthnum",vo);
		
	}
	
	public int deleteAuthnum(AuthVO vo) {
		return mybatis.delete("authVO.deleteAuthnum",vo);
		
		
		
	}

	

}
