package com.spring.finall.service;

import com.spring.finall.user.UserVO;



public interface MemberService {

	public abstract void insertMembership(UserVO vo);
	
	public abstract Integer selectusercode(UserVO vo);
	
	public abstract Integer selectmainhomeuser_code(UserVO vo);
	

	public abstract boolean checkidMembership(UserVO vo);

	public abstract String getHashedPassword(UserVO vo);

	public abstract boolean checkidMembershiptwo(UserVO vo);

	public abstract int changepasswordcomplete(UserVO vo);

	public abstract void insertPhone(UserVO vo);
	
	public abstract boolean checkPhoneMembership(UserVO vo);
	
	
	public abstract UserVO mypersonalinfo(UserVO vo);
	
	public Long incrementPasswordFailCount(String userId);
	public Long isPasswordFailLimitExceeded(String userId);
	
}
