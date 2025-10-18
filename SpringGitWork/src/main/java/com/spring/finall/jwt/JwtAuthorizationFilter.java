//package com.spring.finall.jwt;
//
//import java.io.IOException;
//
//import javax.servlet.FilterChain;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.web.filter.OncePerRequestFilter;
//
//
//
//
//
//
//
//
///**
// * 
// * 
// * 
// * jwt 가 섞여있다 이게 원본파일이고
// * 제목을 JwtAuthorizationFilter2 로 수정하고
// * 
// * 복사본 JwtAuthorizationFilter 으로 갈것임
// * 
// * 
// * 
// * 
// * 
// * */
//
//
//
//public class JwtAuthorizationFilter extends OncePerRequestFilter {
//	private String secret = "hsdfjksdfhjksdfdsfdsfhjkdsfddsfsdf";
//	@Autowired
//	JWTUtil jwtutile;
//
//	@Override
//	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
//			throws ServletException, IOException {
//
//		String excludeURI[] = { "adminmode.do" };
//
//		String excludeJSP = request.getRequestURI();
//
//		String[] requestURI = request.getRequestURI().split("/");
//
//		// 목적성이 틀린 코드 이지만 토큰을 파라미터에 받을 수 있도록 함
//		String uri = requestURI[requestURI.length - 1];
//
//		
//
//	
//		// request에서 Authorization 헤더를 찾음
//		String authorization = request.getHeader("Authorization");
//		System.out.println("헤더에 담긴 토큰 Authorization  "+authorization);			
//		
//		Authentication x = SecurityContextHolder.getContext().getAuthentication();
//		System.out.println("인증객체 : " + x);
//		if(x!=null) {
//			System.out.println("principal : " + x.getPrincipal());			
//		}
//	
//			
//
//		//jwt 를 삭제한다. 이제 또 지옥이다. 씨불...
//		
//		
//		
//			if (authorization == null || authorization.startsWith("logout")) {
//
//				System.out.println("로그아웃 또는 토큰 없음");
//				filterChain.doFilter(request, response);
//				// 조건이 해당되면 메소드 종료 (필수)
//				return;
//			}
//
//			
//			
//			
//			
//			// 토큰은 헤더에 심어야 하는데 지금 Authorization,,authorization 가 짬뽕되어있어 주석처리 헤더 속데 토큰이 있는지를
//			// 본다.
//			
//			System.out.println("authorization == nul? :  "+(authorization == null)+"  authorization.startsWith(\"Bearer \"): "+authorization.startsWith("Bearer "));
//			
//			if (authorization == null || !authorization.startsWith("Bearer ")) {
//				System.out.println("token null");
//				filterChain.doFilter(request, response);
//				// 조건이 해당되면 메소드 종료 (필수)
//				return;
//			}
//
//	
//
//			String token = authorization.split(" ")[1];
//		
//
//			// jwtutile.isExpired(token) 가 만료된걸 읽으면 에러남
//			if (jwtutile.isExpired(token) ) {
//				
//				System.out.println("isExpired(token)?-->>" + jwtutile.isExpired(token));
//				
//				filterChain.doFilter(request, response);
//				return;
//			}
//
//			if (!jwtutile.isExpired(token)) {
//				System.out.println("유효기간 만료?-->>" + jwtutile.isExpired(token));
//				System.out.println("토큰이 유효하면 또 시큐리티 객체 생성 할 필요 없을듯???");
//				// 자꾸 주의 해라. jwt 토큰의 발급 자체는 successHandler 에서 했다. 모르겠으면 successHandler.java로 가라
//			
//				String userid = jwtutile.getUsername(token);
//				String userRole = jwtutile.getRole(token);
//				System.out.println("토큰으로 추출한 userDetails 정보->" + userid + "  " + "  " + userRole);
//
//				// 토큰에서 추출한 사용자 정보를 담은 Authentication 객체 생성
//				// 여기서 개발자 입맛에 따라 UserDetails의 정보를 넣던지 그냥 아무거나 넣던지 하면된다 즉 개발 의도가 중요하다.
//				Authentication authentication = new UsernamePasswordAuthenticationToken(jwtutile.getUsername(token),
//						jwtutile.getRole(token));
//
//				// SecurityContextHolder 는 이제 대충 session 객체 정도 느낌으로 비슷하게 생각하고
//				// spring-security-taglibs 라이브러로 jstl처럼 페이지 마다 분기점을 주면 된다..!
//
//				SecurityContextHolder.getContext().setAuthentication(authentication);
//				filterChain.doFilter(request, response);
//				return;
//			}
//
//
//		
//	}
//
//}
