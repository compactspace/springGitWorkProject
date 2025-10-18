package com.spring.finall.exception.reserveException;

import com.spring.finall.exception.common.BusinessException;

public class ReserveException extends BusinessException {
    public ReserveException() {
        super("예약 결제중 오류가 발생했습니다.");
    }

    public ReserveException(String message) {
        super(message);
    }

    public ReserveException(String message, Throwable cause) {
        super(message, cause);
    }
}
