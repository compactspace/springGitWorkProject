package com.spring.finall.RabitWorker;

import org.springframework.retry.annotation.EnableRetry;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Component;

@Component
@EnableRetry
public class OrderWorker {

    private int failCount = 0; // 실패 횟수 카운트용

    @Retryable(
        value = { RuntimeException.class },
        maxAttempts = 1 // 컨트롤러에서 반복 실패 시뮬레이션
    )
    public void processOrder(OrderEvent order) {
        failCount++;

        System.out.println("주문 처리 시도: " + order.getOrderId() + ", 실패 횟수: " + failCount);

        
      
    }
}
