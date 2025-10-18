package com.spring.finall.security;


import java.util.Collection;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

//또 아가리 마다 다른데..
//UsernamePasswordAuthenticationToken 은 두 개의 필드를 가지고 있는데 
//principal 은 Username 등의 신원을 의미하고,
//credentials 는 Password를 의미한다.
public class AuthenticationToken extends UsernamePasswordAuthenticationToken {

	private static final long serialVersionUID = 1L;

	private String customName = null;

	private Object principal;

	private Object credentials;
	
	private String Role;
	
	
	private List<? extends GrantedAuthority> authorities;

	public AuthenticationToken(Object principal, Object credentials) {
		super(principal, credentials);
		this.principal = principal;
		this.credentials = credentials;
//		System.out.println(principal);
//		System.out.println(credentials);
//		System.out.println("프린씨팔과 크레딘텅ㄹ스종료");

	}

	//
	public AuthenticationToken(Object principal, Object credentials,
			List<? extends GrantedAuthority> authorities) {
		super(principal, credentials, authorities);
		this.principal = principal;
		this.credentials = credentials;
		this.authorities=authorities;
		this.Role=Role;
		System.out.println(principal);
		System.out.println(credentials);
		System.out.println(authorities);
		//System.out.println("검증후 새롭게 권한 까지 부여되는 토큰 객체 씨팔놈프린씨팔과 크레딘텅ㄹ스종료");
	}
	
	

	public AuthenticationToken(Object principal, Object credentials, String customName) {
		super(principal, credentials);
		this.customName = customName;
	}

	public AuthenticationToken(Object principal, Object credentials, Collection<? extends GrantedAuthority> authorities,
			String customName) {
		super(principal, credentials, authorities);
		this.customName = customName;
	}

	public String getCustomName() {
		return customName;
	}

	public void setCustomName(String customName) {
		this.customName = customName;
	}
		
	
	
	public String getRole() {
		return Role;
	}

	public void setRole(String Role) {
		this.Role = Role;
	}
	
	
	@Override
	public String toString() {
		return "AuthenticationToken [authorities=" + authorities + ", principal=" + principal + "]";
	}

}
