package com.spring.finall.Validator.UploadValidator;

import java.util.ArrayList;
import java.util.List;

public class UploadValidator {

    private List<String> allowedExtensions;

    public UploadValidator() {
        // 기본값 설정
        this.allowedExtensions = new ArrayList<String>();
        this.allowedExtensions.add("jpg");
        this.allowedExtensions.add("jpeg");
        this.allowedExtensions.add("png");
        this.allowedExtensions.add("gif");
    }

    // XML에서 override 가능
    public void setAllowedExtensions(List<String> allowedExtensions) {
        this.allowedExtensions = allowedExtensions;
    }

    // 확장자 유효성 검사
    public boolean isValidExtension(String originalName) {

        if (originalName == null) return false;

        // 1) 위험 문자 필터링 (multi-extension 대비)
        if (originalName.matches(".*[;\\\\/:*?\"<>|%00&].*")) {
            return false;
        }

        // 2) 마지막 '.' 기준으로 확장자 추출
        int idx = originalName.lastIndexOf(".");
        if (idx == -1) return false;

        String ext = originalName.substring(idx + 1).toLowerCase();

        // 3) 허용 확장자 목록 검사
        return allowedExtensions.contains(ext);
    }
}

