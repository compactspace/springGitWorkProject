package com.spring.finall.security;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;

public class MyAccessDeniedHandler implements AccessDeniedHandler {

    // 권한 상수
    private static final String ROLE_TEACHER = "ROLE_TEACHER";
 
    private static final String ROLE_ANONYMOUS = "anonymousUser"; // 권한 테이블 확장시 여기다가 정식으로 기술하면됨 지금음 없는 권한임

    // 권한별 URL 상수 (테스트용 하드코딩)
    private static final String URL_TEACHER = "/error/not-my-role";
  
    private static final String URL_ANONYMOUS = "/error/not-my-role";

    // 권한별 실제 URL 매핑 (실제 동작용)
    private static final Map<String, String> ROLE_URL_MAP = Map.of(
    	    ROLE_TEACHER, "/error/teacher-overreach",   // 티처가 일반 사용자 전용 페이지 접근 시
    	   
    	    ROLE_ANONYMOUS, "/error/anonymous-overreach"   // 권한 테이블 확장시 여기다가 정식으로 기술하면됨 지금음 없는 권한임
    	);


    // 에러 페이지 (jsp)
    private String errorPage;

    public void setErrorPage(String errorPage) {
        errorPage = "/WEB-INF/views/error/SecurityErrorPage.jsp";
        this.errorPage = errorPage;
    }

    @Override
    public void handle(HttpServletRequest req, HttpServletResponse resp, AccessDeniedException e)
            throws IOException, ServletException {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

//        if (auth != null) {
//            System.out.println("인증객체 : " + auth.getName());
//            System.out.println("권한목록 : " + auth.getAuthorities());
//        }

        // 기본 리다이렉트 URL
        String redirectUrl = req.getContextPath() + "/error/not-my-role";

        if (auth != null) {
            // 사용자의 첫 번째 권한 가져오기
            String role = auth.getAuthorities().stream()
                    .findFirst()
                    .map(a -> a.getAuthority())
                    .orElse(ROLE_ANONYMOUS);

            // 매핑된 URL 찾기 (없으면 기본 not-my-role)
            String mappedUrl = ROLE_URL_MAP.getOrDefault(role, "/error/not-my-role");
            redirectUrl = req.getContextPath() + mappedUrl;
        }

        // Ajax 요청 여부 확인
        boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));

        // 공통 처리 (중복 제거)
        handleAccessDenied(resp, isAjax, redirectUrl);
    }

    /** Ajax/일반 요청에 따른 공통 응답 처리 */
    private void handleAccessDenied(HttpServletResponse resp, boolean isAjax, String redirectUrl)
            throws IOException {
        if (isAjax) {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            resp.getWriter().write(redirectUrl);
        } else {
            resp.sendRedirect(redirectUrl);
        }
    }
}
