package com.spring.finall.Validator.MimeValidator;

import java.io.File;
import java.nio.file.Files;

import org.apache.tika.Tika;

public class MimeValidator {

    private Tika tika = new Tika();

    public boolean isValid(File file) {
        try {
            String mime = tika.detect(file);
            return mime != null && mime.startsWith("image");
        } catch (Exception e) {
            return false;
        }
    }
}
