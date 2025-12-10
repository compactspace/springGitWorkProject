package com.spring.finall.Validator.UploadSecurityManager;

import java.io.File;

import com.spring.finall.Validator.ImageDecoderValidator.ImageDecoderValidator;
import com.spring.finall.Validator.MagicNumberValidator.MagicNumberValidator;
import com.spring.finall.Validator.MimeValidator.MimeValidator;
import com.spring.finall.Validator.SafeFileNamer.SafeFileNamer;
import com.spring.finall.Validator.UploadValidator.UploadValidator;

public class UploadSecurityManager {

    private UploadValidator uploadValidator = new UploadValidator();
    private MagicNumberValidator magicValidator = new MagicNumberValidator();
    private MimeValidator mimeValidator = new MimeValidator();
    private ImageDecoderValidator decoderValidator = new ImageDecoderValidator();
    private SafeFileNamer fileNamer = new SafeFileNamer();

    public boolean validate(String originalName, File tempFile) {

        // 1) 확장자 유효성 검사
        if (!uploadValidator.isValidExtension(originalName)) return false;

        // 2) 매직 넘버 검사
        if (!magicValidator.isValid(tempFile)) return false;

//        // 3) MIME 검사
      if (!mimeValidator.isValid(tempFile)) return false;

        // 4) ImageIO 디코딩 검사
        if (!decoderValidator.isDecodable(tempFile)) return false;

        return true;
    }

    // 이건 솔직히 필요없다 아직은
    public File getSafeFile(File dir) {
        return fileNamer.getSafeFile(dir);
    }
}