package com.spring.finall.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.spring.finall.jwt.JWTUtil;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	@Autowired
	JWTUtil jwtutile;
	String Role;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
	
		
		
		System.out.println(authentication.getAuthorities().toString());
		System.out.println("------------------------------------------------");
		
		// 인증에 성공한뒤 인증된 객체를 List<GrantedAuthority> 으로 받는다.
		List<GrantedAuthority> list = (List<GrantedAuthority>)authentication.getAuthorities();
	
		
	
		for(GrantedAuthority  g: list) {
			
			System.out.println(g);
		}
		
		
		
		
		
		// 사실 세션 방식이엇다면 여기서 UsernamePasswordAuthenticationToken 객체로 인증후 객체 재생성 하고
			SecurityContextHolder.getContext().setAuthentication(authentication);		
//		filterChain.doFilter(request, response); 이렇게 하면 된다 
		// 그러나 지금은  jwt 토큰 방식 인증으로 하려고  디스패쳐 처리
		
//		System.out.println("로그인시 권한 빼오기" + list.get(0).getAuthority());
//		Role=list.get(0).getAuthority();
//		// jwt 토큰 발급 내용에 유저의 권한 정보등을 삽입
//		String token = jwtutile.createJwt((String) authentication.getPrincipal(),Role, 1000L);
//		request.setAttribute("token", token);
//		request.getRequestDispatcher("/loginsuccess.do").forward(request, response);

	}

}
