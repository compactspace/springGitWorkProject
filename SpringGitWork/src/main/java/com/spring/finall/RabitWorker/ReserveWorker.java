package com.spring.finall.RabitWorker;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.finall.RabitEvent.ReserveEvent;
import com.spring.finall.config.AdminConfig;
import com.spring.finall.service.ReserveService;

@Component
public class ReserveWorker {

    @Autowired
    private ReserveService reserveService;

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @RabbitListener(queues = AdminConfig.RESERVE_QUEUE)
    public void processOrder(ReserveEvent reserveEvent) {
        try {
            // DB 또는 비즈니스 로직 처리
        	System.out.println("Reserve processed: " + reserveEvent);
        	   throw new RuntimeException("DB insert error!");

        } catch (Exception e) {
            // 실패 시 수동으로 DLQ로 이동
            rabbitTemplate.convertAndSend(AdminConfig.RESERVE_FAILURE_QUEUE, reserveEvent);
            System.out.println("Reserve failed. Sent to failure queue: " + reserveEvent);
        }
    }
}
