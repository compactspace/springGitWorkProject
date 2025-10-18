package com.spring.finall.jwt;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.springframework.web.filter.GenericFilterBean;

//로그아웃 필터
public class JwtLogoutFilter extends GenericFilterBean {

	
	//솔직히 잘 모르겠다 두필터 이후 그냥 내가 만든 석세스 핸들러로 자동으로 가는데 동작 원리를 모르겠음
	//근데 큰 와꾸는 GenericFilterBean 의 구현체인 LogoutFilter 속의
	// doFilter 메서드 속에서 각각 2개의 메서드를 호출하게됨
	//logout 메서드를 호출 -> session(false)로 시큐리티컨텍스트를 아예 없애버리는 듯 하고
	//onLogoutSuccess 메소드를 호출 -> 위 메서드가 끝한후 적절히 리다이렉트를 처리
	// 핵심은 저 chain.doFilter(request, response); 이 무언가에 의해 어떤 또 필터로 연결되는 듯한데..
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("로그아웃 필터 프로세스 유알엘");
		// chain.doFilter(req, resp); => 다음 필터실행, 실행할 필터가 없으면 jsp나 servlet실행하라는 명령.
		chain.doFilter(request, response);

	}



}
