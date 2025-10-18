package com.spring.interceptor;

import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

public class SecurityLogInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

    	
    	String contextPath = request.getContextPath();
    	String uri = request.getRequestURI();
    	String path = uri.substring(contextPath.length());

    	    // 정적 리소스 패턴 제외
    	    if (uri.startsWith("/resources/") || uri.startsWith("/static/") || uri.matches(".*(\\.css|\\.js|\\.png|\\.jpg|\\.gif)$")) {
    	        return true; // 통과, 인터셉터 기능 안 함
    	    }
    	
    	
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("\n\n>>> 요청 URI: " + path + "\n");

        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            String username = auth.getName();
            Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();

            System.out.println("✅ 현재 로그인 사용자: " + username);
            System.out.println("✅ 권한 목록:");
            for (GrantedAuthority role : authorities) {
                System.out.println("   - " + role.getAuthority());
            }

        } else {
            System.out.println("❌ 인증 정보가 없습니다. (비로그인 상태)");
        }

        System.out.println("\n\n");  // 끝에 엔터 두 개 추가

        return true; // 컨트롤러 계속 진행
    }
}