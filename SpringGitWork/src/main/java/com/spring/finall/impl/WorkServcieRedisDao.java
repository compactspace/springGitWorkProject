package com.spring.finall.impl;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.writeWorkComment.WorkCommentDTO;

@Repository
public class WorkServcieRedisDao {
	  private static final String ATTEMPT_KEY_PREFIX = "workWrite:attempt:";
	    private static final String GLOBAL_ATTEMPT_KEY_PREFIX = "workWrite:GlobalAttempt:";
	    private static final String DANGEROUS_USER_KEY_PREFIX = "workWriteService:Dangerous:";

	    @Autowired
	    private RedisTemplate<String, String> redisTemplate;

	    public Long incrementCommentWriteAttempt(WorkCommentDTO workCommentDTO, int userCode) {
	        String attemptKey = ATTEMPT_KEY_PREFIX + workCommentDTO.getWorkId() + ":" + userCode;
	        Long count = redisTemplate.opsForValue().increment(attemptKey);

	        String globalAttemptKey = GLOBAL_ATTEMPT_KEY_PREFIX + userCode;
	        Long globalCount = redisTemplate.opsForValue().increment(globalAttemptKey);

	        if (count == 1) {
	            redisTemplate.expire(attemptKey, 5, TimeUnit.SECONDS);
	        }

	        if (globalCount == 1) {
	            redisTemplate.expire(globalAttemptKey, 5, TimeUnit.MINUTES);
	        }

	        if (globalCount != null && globalCount > 10) {
	            insertDangerousUser(userCode);
	        }

	        return count;
	    }

	    public Long getAttemptCntCommentWrite(WorkCommentDTO workCommentDTO, int userId) {
	        String attemptKey = ATTEMPT_KEY_PREFIX + workCommentDTO.getWorkId() + ":" + userId;
	        String countStr = redisTemplate.opsForValue().get(attemptKey);
	        return countStr == null ? 0L : Long.parseLong(countStr);
	    }

	    public void insertDangerousUser(int userId) {
	        String dangerousUserKey = DANGEROUS_USER_KEY_PREFIX + userId;
	        redisTemplate.opsForHash().put(dangerousUserKey, "lockedDate", new Date().toString());
	        redisTemplate.opsForHash().put(dangerousUserKey, "lockedCauz", "악의적인 무차별 댓글삽입시도");
	    }

	    public Map<Object, Object> getAttemptCntDangerousUser(int userId) {
	        String dangerousUserKey = DANGEROUS_USER_KEY_PREFIX + userId;
	        return redisTemplate.opsForHash().entries(dangerousUserKey);
	    }
}
