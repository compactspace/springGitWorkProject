package com.spring.finall.Validator.JdkMimeValidator;

import java.io.File;
import java.nio.file.Files;

public class JdkMimeValidator {
	public boolean isValid(File file) {
        try {
            String mime = Files.probeContentType(file.toPath());
            return mime != null && mime.startsWith("image");
        } catch (Exception e) {
            return false;
        }
    }
}
