package com.spring.finall.exception.teacherMemberShip;

import com.spring.finall.exception.common.BusinessException;

public class TeacherDocumentException extends BusinessException {
    public TeacherDocumentException() {
        super("제출 문서 저장시에러남");
    }

    public TeacherDocumentException(String message) {
        super(message);
    }

    public TeacherDocumentException(String message, Throwable cause) {
        super(message, cause);
    }
}