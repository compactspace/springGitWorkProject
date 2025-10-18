package com.spring.finall.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * SecurityUtil
 * 
 * Spring Security의 SecurityContextHolder에서 현재 인증된 사용자 정보를 가져오는 유틸 클래스입니다.
 * 주로 컨트롤러나 서비스 계층에서 현재 로그인한 사용자의 정보를 쉽게 조회할 수 있도록 도와줍니다.
 */
public class SecurityUtil {

    /**
     * 현재 인증된 사용자(UserDetailsVO2)를 반환합니다.
     *
     * @return 인증된 사용자 객체(UserDetailsVO2), 인증되지 않은 경우 null
     */
    public static UserDetailsVO2 getCurrentUser() {
        // SecurityContextHolder에서 현재 보안 컨텍스트의 Authentication 객체를 가져옴
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 인증 객체가 없거나, 인증되지 않은 경우 null 반환
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        // Authentication 객체에서 Principal(사용자 정보 객체)을 가져옴
        Object principal = authentication.getPrincipal();

        // Principal이 우리가 정의한 사용자 클래스(UserDetailsVO2)인 경우 캐스팅하여 반환
        if (principal instanceof UserDetailsVO2) {
            return (UserDetailsVO2) principal;
        }

        // 예상한 타입이 아닌 경우 null 반환
        return null;
    }

    /**
     * 현재 인증된 사용자의 ID(username)를 반환합니다.
     *
     * @return 사용자 ID(String), 인증되지 않은 경우 null
     */
    public static String getCurrentUserId() {
        // 현재 사용자 객체 가져오기
        UserDetailsVO2 user = getCurrentUser();

        // 사용자 객체가 null이 아니면 username 반환, 아니면 null
        return (user != null) ? user.getUsername() : null;
    }
}

