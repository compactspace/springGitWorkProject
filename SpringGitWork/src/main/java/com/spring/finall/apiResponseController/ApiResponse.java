package com.spring.finall.apiResponseController;

public class ApiResponse<T> {
    private int code;
    private boolean success;  // 추가
    private String message;
    private T data;

    // 생성자에 success 추가
    public ApiResponse(int code, boolean success, String message, T data) {
        this.code = code;
        this.success = success;  // 누락된 부분 추가
        this.message = message;
        this.data = data;
    }

    // Builder 시작
    public static <T> Builder<T> builder() {
        return new Builder<>();
    }

    public static class Builder<T> {
        private int code;
        private boolean success;  // 추가
        private String message;
        private T data;

        public Builder<T> code(int code) {
            this.code = code;
            return this;
        }

        public Builder<T> success(boolean success) {  // 추가
            this.success = success;
            return this;
        }

        public Builder<T> message(String message) {
            this.message = message;
            return this;
        }

        public Builder<T> data(T data) {
            this.data = data;
            return this;
        }

        public ApiResponse<T> build() {
            return new ApiResponse<>(code, success, message, data);
        }
    }

 
    public int getCode() {
        return code;
    }

    public boolean getSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }

    public T getData() {
        return data;
    }
}
