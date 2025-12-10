package com.spring.finall.Validator.SafeFileNamer;

import java.io.File;
import java.util.UUID;

public class SafeFileNamer {

    private String forcedExtension = "jpg"; // 기본 이미지 확장자

    public String getSafeFileName() {
        return UUID.randomUUID().toString() + "." + forcedExtension;
    }

    public File getSafeFile(File dir) {
        return new File(dir, getSafeFileName());
    }

    // 필요하면 강제 확장자 변경 가능
    public void setForcedExtension(String ext) {
        this.forcedExtension = ext;
    }
}
