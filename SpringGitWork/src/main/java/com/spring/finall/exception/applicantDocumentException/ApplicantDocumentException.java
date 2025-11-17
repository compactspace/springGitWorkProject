package com.spring.finall.exception.applicantDocumentException;

import com.spring.finall.exception.common.BusinessException;

public class ApplicantDocumentException  extends BusinessException {

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

	public ApplicantDocumentException() {
		super("제출 서류 상태 변경 실패");
	}

	public ApplicantDocumentException(String message, int bussinessCode) {
		super(message);
		this.bussinessCode = bussinessCode;
		this.bussinessExceptionMessage = message;
	}

	public ApplicantDocumentException(String message, Throwable cause) {
		super(message, cause);

	}

}
