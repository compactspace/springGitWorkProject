package com.spring.finall.impl;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SignUpSmsSendServiceRedisDAO {
	
	@Autowired
    private RedisTemplate<String, String> redisTemplate;

    public Long incrementAttempt(String attemptKey) {
        Long count = redisTemplate.opsForValue().increment(attemptKey);
        if (count == 1) {
        	   redisTemplate.expire(attemptKey, 10, TimeUnit.MINUTES); // 버전 호환
        }
        return count;
    }

    public boolean hasCooldownKey(String cooldownKey) {
        return Boolean.TRUE.equals(redisTemplate.hasKey(cooldownKey));
    }

    public void setCooldownKey(String cooldownKey) {
        redisTemplate.opsForValue().set(cooldownKey, "1", Duration.ofMinutes(3));
    }

    public void setLog(String logKey) {
        redisTemplate.opsForValue().set(logKey, "SMS_SENT", Duration.ofHours(1));
    }   
    
    // 인증 상태 저장 (5분 TTL)
    public void setVerified(String sessionId) {
        String verifyKey = "signup:sms:verify:" + sessionId;
        String verifyDateKey = verifyKey + ":verifiedDate";

        // 인증 상태 저장 (5분)
        redisTemplate.opsForValue().set(verifyKey, "true", Duration.ofMinutes(5));

        // 인증 완료 시간 저장 (TTL 없이, 필요하면 TTL 추가 가능)
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd_HH_mm"));
        redisTemplate.opsForValue().set(verifyDateKey, now);
    }

    
    

    
    
    
    
    public void removeVerified(String userId) {
        String verifyKey = "sms:verify:" + userId;
        String verifyDateKey = verifyKey + ":verifiedDate";

        // Redis에서 두 키 삭제
        redisTemplate.delete(verifyKey);
        redisTemplate.delete(verifyDateKey);
    }

    
    
    
    // 인증 상태 TTL 조회 (초 단위)
    public Long getVerifiedTTL(String sessionId) {
    	 String verifiedKey = "signup:verified:session:" + sessionId;
        return redisTemplate.getExpire(verifiedKey, TimeUnit.SECONDS);
    }

    // 인증 완료 시간 조회
    public String getVerifiedDate(String userId) {
        String verifyDateKey = "sms:verify:" + userId + ":verifiedDate";
        return redisTemplate.opsForValue().get(verifyDateKey);
    }
    

}
