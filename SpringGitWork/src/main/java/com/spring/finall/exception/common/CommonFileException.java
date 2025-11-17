package com.spring.finall.exception.common;

public class CommonFileException extends BusinessException {

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

	public CommonFileException() {
		super("상품 등록 실패");
	}

	public CommonFileException(String message, int bussinessCode) {
		super(message);
		this.bussinessCode = bussinessCode;
		this.bussinessExceptionMessage = message;
	}

	public CommonFileException(String message, Throwable cause) {
		super(message, cause);

	}

}