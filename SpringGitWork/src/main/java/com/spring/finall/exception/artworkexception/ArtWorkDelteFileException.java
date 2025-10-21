package com.spring.finall.exception.artworkexception;

import com.spring.finall.exception.common.BusinessException;

public class ArtWorkDelteFileException extends BusinessException {
	
	public ArtWorkDelteFileException() {
        super("파일 삭제 실패");
    }

    public ArtWorkDelteFileException(String message) {
        super(message);
    }

    public ArtWorkDelteFileException(String message, Throwable cause) {
        super(message, cause);
    }

}
