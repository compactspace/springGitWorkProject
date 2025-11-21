package com.spring.finall.apiResponseController;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class HelloBatch {

	//AdminConfig 자바 파일에 있는거 public void addInterceptors(InterceptorRegistry registry) 주석처리함 아직 사용할대가 없음
    @Scheduled(fixedRate = 5000) 
    public void sayHello() {
        System.out.println("Hello World! - " + System.currentTimeMillis());
    }
}