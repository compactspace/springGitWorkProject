package com.spring.finall.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("SecurityUserVOServiceImpl")
public class SecurityUserVOServiceImpl implements  SecurityUserVOService {

	@Autowired
	SecurityUserDaoBatis dao;
	
	@Override
	public Integer checkidMembership(SecurityUserVO vo) {	
		return dao.checkidMembership(vo);
	}
	@Override
	public	Integer insertMembership(SecurityUserVO vo) {
		
		return dao.insertMembership(vo);
	};

}
