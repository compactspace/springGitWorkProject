package com.spring.finall.security;

public interface SecurityUserVOService {
	
	public abstract Integer checkidMembership(SecurityUserVO vo);
	
	public abstract Integer insertMembership(SecurityUserVO vo);
}
