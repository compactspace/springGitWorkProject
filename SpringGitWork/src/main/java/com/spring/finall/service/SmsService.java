package com.spring.finall.service;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.spring.finall.businessresult.SmsSendResult;

public interface SmsService {
    SmsSendResult requestSmsCode(String userId, String phone, HttpSession session,Model model);
    
    SmsSendResult verifySmsCode(String userId,HttpSession session,String inputCode,String token);
    
    
    void removeSmsCooldown(HttpSession session);
    
}
