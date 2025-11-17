package com.spring.finall.exception.ManageProductException;

import com.spring.finall.exception.common.BusinessException;

public class ManageProductException extends BusinessException {

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

	public ManageProductException() {
		super("상품 등록 실패");
	}

	public ManageProductException(String message, int bussinessCode) {
		super(message);
		this.bussinessCode = bussinessCode;
		this.bussinessExceptionMessage = message;
	}

	public ManageProductException(String message, Throwable cause) {
		super(message, cause);

	}

}
