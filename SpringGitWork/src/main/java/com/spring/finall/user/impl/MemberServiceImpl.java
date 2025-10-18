package com.spring.finall.user.impl;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.spring.finall.service.MemberService;
import com.spring.finall.user.UserVO;

@Service("memberserviceimpl")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAOMybatis mdao;
	
	@Autowired
	private RedisTemplate<String, String> redisTemplate;
	

	@Override
	public void insertMembership(UserVO vo) {
		mdao.insertMembership(vo);

	}

	@Override
	public Integer selectusercode(UserVO vo) {

		return mdao.selectusercode(vo);

	};
	@Override
	public  Integer selectmainhomeuser_code(UserVO vo) {
		
		return mdao.selectmainhomeuser_code(vo);
	}
	

	@Override
	public boolean checkidMembership(UserVO vo) {
		boolean check = mdao.checkidMembership(vo);

		return check;

	}

	@Override
	public boolean checkidMembershiptwo(UserVO vo) {
		boolean check = mdao.checkidMembershiptwo(vo);

		System.out.println("마이베티스 트루문이면 check는 트루여야함" + check);
		return check;

	}

	@Override
	public String getHashedPassword(UserVO vo) {
		String hashedPwd = mdao.loginpasswordMembership(vo);
		
		
		return hashedPwd;

	}

	@Override
	public int changepasswordcomplete(UserVO vo) {
		int check = mdao.changepasswordcomplete(vo);
		System.out.println("업데이트 check 뭘받으려나" + check);

		return check;

	}

	// 핸드폰가입자용
	@Override
	public void insertPhone(UserVO vo) {

		mdao.insertMembership(vo);
	}

	@Override
	public boolean checkPhoneMembership(UserVO vo) {
		boolean check = mdao.checkPhoneMembership(vo);

		System.out.println("check가 트루이면->" + check + "-> 새로운가입자로 가입시키고 로그인시키면되고" + " ,펠스이면 기가입자로 바로 로그인시키고");
		return check;

	}
	@Override
	public UserVO mypersonalinfo(UserVO vo){
		
		return mdao.mypersonalinfo(vo);
	}


	@Override
	public Long incrementPasswordFailCount(String userId) {
	    String key = "currentPwdCheck:" + userId;
	    String today = LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE);

	    // 1. attemptCount를 증가시킴
	    Long attemptCount = redisTemplate.opsForHash().increment(key, "attemptCount", 1);

	    // 2. attemptN 필드에 오늘 날짜 기록 (e.g. attempt1, attempt2, ...)
	    String attemptField = "attempt" + attemptCount;
	    redisTemplate.opsForHash().put(key, attemptField, today);

	    // 3. TTL 설정: 키에만 설정 (이미 설정되어 있지 않을 경우만)
	    Long expire = redisTemplate.getExpire(key);
	    if (expire == null || expire == -1) {
	        redisTemplate.expire(key, 24, TimeUnit.HOURS);
	    }

	    return attemptCount;
	}


	@Override
	public Long isPasswordFailLimitExceeded(String userId) {
		 String key = "currentPwdCheck:" + userId;
		    Object count = redisTemplate.opsForHash().get(key, "attemptCount");
		    return count == null ? 0L : Long.parseLong(count.toString());
	}
	
	
	

	
	

}
