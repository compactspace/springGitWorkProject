//package com.spring.finall.jwt;
//
//import java.nio.charset.StandardCharsets;
//
//import javax.crypto.SecretKey;
//import javax.crypto.spec.SecretKeySpec;
//
//import io.jsonwebtoken.Jwts;
//
//public class JWTUtilForSecurity {
//	
//	private SecretKey secretKey;
//	
//	private String secret="hadsfsdndsfusdjjsdfhkjsdfljhsdflsdf";
//
//    public JWTUtilForSecurity(String secret) {
//
//
//        secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
//    }
//
//    public String getUsername(String token) {
//
//        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("username", String.class);
//    }
//
//    public String getRole(String token) {
//
//        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("role", String.class);
//    }
//
//    public Boolean isExpired(String token) {
//
//        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().getExpiration().before(new Date());
//    }
//
//    
//    public String createJwt(String username, String role, Long expiredMs) {
//
//        return Jwts.builder()
//                .claim("username", username)
//                .claim("role", role)
//                .issuedAt(new Date(System.currentTimeMillis()))
//                .expiration(new Date(System.currentTimeMillis() + expiredMs))
//                .signWith(secretKey)
//                .compact();
//    }
//
//}
