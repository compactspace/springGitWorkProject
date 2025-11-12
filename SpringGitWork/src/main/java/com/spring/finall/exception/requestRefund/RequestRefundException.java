package com.spring.finall.exception.requestRefund;

import com.spring.finall.exception.common.BusinessException;

public class RequestRefundException extends BusinessException {

	public int bussinessCode;

	public String bussinessExceptionMessage;

	public String getBussinessExceptionMessage() {
		return bussinessExceptionMessage;
	}

	public void setBussinessExceptionMessage(String bussinessExceptionMessage) {
		this.bussinessExceptionMessage = bussinessExceptionMessage;
	}

	public int getBussinessCode() {
		return bussinessCode;
	}

	public void setBussinessCode(int bussinessCode) {
		this.bussinessCode = bussinessCode;
	}

	public RequestRefundException() {
		super("게시글 작성완료 실패");
	}

	public RequestRefundException(String message, int bussinessCode) {
		super(message);
		this.bussinessCode = bussinessCode;
		this.bussinessExceptionMessage = message;
	}

	public RequestRefundException(String message, Throwable cause) {
		super(message, cause);

	}

}
