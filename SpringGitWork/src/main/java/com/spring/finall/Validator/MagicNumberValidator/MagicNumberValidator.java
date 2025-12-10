package com.spring.finall.Validator.MagicNumberValidator;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;

public class MagicNumberValidator {

    // 허용 매직 넘버 (hex string)
    private static final List<String> ALLOWED_MAGIC_NUMBERS = Arrays.asList(
        "FFD8",      // JPG
        "89504E47",  // PNG
        "47494638"   // GIF
    );

    public boolean isValid(File file) {
        try (InputStream is = new FileInputStream(file)) {
            byte[] header = new byte[8];  // 최대 8바이트 검사
            int readBytes = is.read(header);
            if (readBytes <= 0) return false;

            String hex = bytesToHex(header).toUpperCase();
            for (String magic : ALLOWED_MAGIC_NUMBERS) {
            	System.out.println("magic: "+magic+" hex"+hex);
                if (hex.startsWith(magic)) return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    private String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02X", b));
        }
        return sb.toString();
    }
}
