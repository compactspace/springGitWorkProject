package com.spring.finall.exception.orderexception;

import com.spring.finall.exception.common.BusinessException;

public class OrderException extends BusinessException {
    public OrderException() {
        super("주문 처리 중 오류가 발생했습니다.");
    }

    public OrderException(String message) {
        super(message);
    }

    public OrderException(String message, Throwable cause) {
        super(message, cause);
    }
}