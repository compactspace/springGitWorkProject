package com.spring.finall.impl;

import java.time.Duration;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.spring.finall.AuthVO;
import com.spring.finall.businessresult.SmsSendResult;
import com.spring.finall.service.SendMessageApiService;
import com.spring.finall.service.SmsService;

@Service
public class SmsServiceImpl implements SmsService {

	@Autowired
	private RedisTemplate<String, String> redisTemplate;

	@Autowired
	private SendMessageApiService sendMessageService; // 문자 발송 담당 서비스

	@Autowired
	private SmsServiceRedisDao smsServiceDao;
	
	

	@Override
	public SmsSendResult requestSmsCode(String userId, String phone, HttpSession session, Model model) {
		String cooldownKey = "sms:cooldown:" + userId + ":" + phone;
		String attemptKey = "sms:attempt:" + userId + ":" + phone;

		long cooldownStartTime = 0;
		long cooldownDuration = 0;

		Long count = smsServiceDao.incrementAttempt(attemptKey);
		// 첫 시도일 경우 만료시간 설정

		if (count == 1) {
			// Redis에 사용 횟수 제한 (10분 동안 5회)
			redisTemplate.expire(attemptKey, 10, TimeUnit.MINUTES); // 버전 호환
			// Redis에 쿨다운 키 1분 저장
			redisTemplate.expire(cooldownKey, 1, TimeUnit.MINUTES);
			cooldownStartTime = System.currentTimeMillis();
			cooldownDuration = 3000;

			session.setAttribute("cooldownStartTime", cooldownStartTime);
			session.setAttribute("cooldownDuration", cooldownDuration);
		}
		// 두번째 시도이상 경우 만료시간 설정
		// 많은 요청 거절 메시지 리턴
		if (count != null && count > 5) {
			return SmsSendResult.tooManyRequests();
		}

		// 2) 쿨다운 제한 (3분)
		if (Boolean.TRUE.equals(redisTemplate.hasKey(cooldownKey))) {
			return SmsSendResult.tooSoon();
		}

		// 3) 인증번호 및 토큰 생성
		//int randomCode = (int) (Math.random() * 899999) + 100000;
		int randomCode = 1111;
		String token = UUID.randomUUID().toString();
		long now = System.currentTimeMillis();

		// 4) 세션에 저장
		session.setAttribute("AuthNumber", randomCode);
		session.setAttribute("authToken", token);
		session.setAttribute("authTokenTime", now);
		session.setAttribute("authPhone", phone);

		// 6) Redis에 발송 로그 저장
		String logKey = "sms:log:" + userId + ":" + phone + ":" + now;
		smsServiceDao.setLog(logKey);

		// 7) 문자 발송
		AuthVO vo = new AuthVO();
		vo.setPhone(phone);
		vo.setAuthNumber(randomCode);
//		boolean failed = sendMessageService.sendMessage(String.valueOf(randomCode), vo);
//
//		if (failed) {
//			return SmsSendResult.fail();
//		}

		// 8) 성공 결과 반환
		return SmsSendResult.success(token, cooldownStartTime, cooldownDuration);
	}

	@Override
	public void removeSmsCooldown(HttpSession session) {
		session.removeAttribute("cooldownStartTime");
		session.removeAttribute("cooldownDuration");
	}

	@Override
	public SmsSendResult verifySmsCode(String userId,HttpSession session, String inputCode, String token) {

		Integer savedCode = (Integer) session.getAttribute("AuthNumber");
		String savedToken = (String) session.getAttribute("authToken");
		Long savedTime = (Long) session.getAttribute("authTokenTime");

		
		String verifyKey = "sms:verify:" + userId ;
		
		
		if (savedCode == null || savedToken == null || savedTime == null) {
			return SmsSendResult.expired();
		}

		if (!savedToken.equals(token)) {
			return SmsSendResult.invalidTOKEN();
		}

		long now = System.currentTimeMillis();
		if (now - savedTime > 2 * 60 * 1000) { // 2분 초과
			session.invalidate(); // 전체 인증 상태 삭제
			return SmsSendResult.expired();
		}

		if (!String.valueOf(savedCode).equals(inputCode)) {
			return SmsSendResult.invalidCODE();
		}

		session.removeAttribute("cooldownStartTime");
		session.removeAttribute("cooldownDuration");
		session.removeAttribute("AuthNumber");
		session.removeAttribute("authToken");
		session.removeAttribute("authTokenTime");
		session.removeAttribute("authPhone");
		
		 // 인증 성공 시 Redis에 인증 완료 상태 저장
	
		smsServiceDao.setVerified(userId);
		Long ttl = 	smsServiceDao.getVerifiedTTL(userId);
		Long ttlStartTime=System.currentTimeMillis();   
			
		
		return SmsSendResult.setVerified(ttl,ttlStartTime);
	
	}
}
