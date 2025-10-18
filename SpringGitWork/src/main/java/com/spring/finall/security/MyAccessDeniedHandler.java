package com.spring.finall.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;

public class MyAccessDeniedHandler implements AccessDeniedHandler {

    private String errorPage;

    public void setErrorPage(String errorPage) {
    	System.out.println("개 씹망 권한이 없어요");
    	errorPage="/WEB-INF/views/error/SecurityErrorPage";
    	System.out.println("errorPage:  "+errorPage);
        this.errorPage = errorPage;
    }

    @Override
    public void handle(HttpServletRequest req, HttpServletResponse resp, AccessDeniedException e)
            throws IOException, ServletException {
    	
    	System.out.println("개 씹망 권한이 없어요");
    	Authentication x = SecurityContextHolder.getContext().getAuthentication();
		System.out.println("인증객체 : " + x);
		if(x!=null) {
			System.out.println("principal : " + x.getPrincipal());			
		}
    	
    	
        //TODO 수행할 비즈니스 로직
        req.getRequestDispatcher(errorPage).forward(req, resp);
    }

}