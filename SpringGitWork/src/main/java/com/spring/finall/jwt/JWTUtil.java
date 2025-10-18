package com.spring.finall.jwt;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;



import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;

public class JWTUtil {

	private SecretKey secretKey;

	// 나중이 시크릿 같은거 propertiese 에서 설정하고 가져오는걸로 바꾸자
	private String secret = "hsdfjksdfhjksdfdsfdsfhjkdsfddsfsdf";

	// 대충 바이트와 어떤 암호화 방식인지 알려주는 객체 초기화이다.

//	 public JWTUtil() {
//	    	
//	       this.secret=secret;
//	     new JWTUtil(secret);
//	    }

	public JWTUtil(String secret) {

		secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8),
				Jwts.SIG.HS256.key().build().getAlgorithm());

	}

	public String getUsername(String token) {

		return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("username",
				String.class);
	}

	public String getRole(String token) {

		return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("role",
				String.class);
	}

	// 이름에 낙이지 마라 date자료형.before(new Date())
	// 좌변이 우변보다 작거나 같으면 투르 크면 펠스이다.
	//https://argente29.tistory.com/146 반드시 읽어라
	public Boolean isExpired(String token) {

		// 따라서 내가 jwt 발급이 만료기한 이 현재 시간보다 커야 함으로 투루= 펠스 여야 유효한거고
		// 작거나 같으면 만료가 지났다는 뜻으로 투루

		Boolean isExpired = false;
		try {
//			Authentication x = SecurityContextHolder.getContext().getAuthentication();
//			System.out.println("인증객체 : " + x);
//			System.out.println("프린씨팔 : " + x.getPrincipal());
			// parser() 가 throws ExpiredJwtException, MalformedJwtException, SignatureException 하고 있음
			isExpired = Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload()
					.getExpiration().before(new Date());
		} catch (ExpiredJwtException epjwte) {
			isExpired = true;
			System.out.println(epjwte.getClaims());
			
			
		}

		return isExpired;
	}

	public String createJwt(String username, String role, Long expiredMs) {

//	    	System.out.println("secretKey----->"+secretKey);
//	    	System.out.println("expiredMs->"+expiredMs);
//	    	System.out.println("new Date(System.currentTimeMillis()"+new Date(System.currentTimeMillis()));
//	    	System.out.println("new Date(System.currentTimeMillis() + expiredMs"+new Date(System.currentTimeMillis() + expiredMs));
//	    	System.out.println("new Date(System.currentTimeMillis() - expiredMs"+new Date(System.currentTimeMillis() - expiredMs));
		return Jwts.builder().claim("username", username).claim("role", role)
				.issuedAt(new Date(System.currentTimeMillis()))
				.expiration(new Date(System.currentTimeMillis() + expiredMs)).signWith(secretKey).compact();
	}

}
