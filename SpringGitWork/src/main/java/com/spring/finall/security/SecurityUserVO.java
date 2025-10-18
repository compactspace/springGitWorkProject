package com.spring.finall.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

//securityuser 테이블이다.
public class SecurityUserVO implements UserDetails {

	
 private  Collection<? extends GrantedAuthority> authorities;
	  
	private int suser_num;
	private String user_id;
	private String user_pwd;
	private String user_create;
	private String user_role;

	public int getSuser_num() {
		return suser_num;
	}

	public void setSuser_num(int suser_num) {
		this.suser_num = suser_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getUser_create() {
		return user_create;
	}

	public void setUser_create(String user_create) {
		this.user_create = user_create;
	}

	public String getUser_role() {
		return user_role;
	}

	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}

	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		 Collection<GrantedAuthority> authorities = new ArrayList<>();

		 authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
	        return authorities;
	}

	@Override
	public String getPassword() {
		
		return this.getUser_pwd();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.getUser_id();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String toString() {
		
		return "[ user_id"+this.getUser_id()+"user_pwd"+this.getUser_pwd()+"user_create"+this.getUser_create()+"]";
	}
	
	
}
