package com.spring.finall.Validator.ImageDecoderValidator;

import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class ImageDecoderValidator {

    public boolean isDecodable(File file) {
        try {
            BufferedImage img = ImageIO.read(file);
            return img != null;
        } catch (Exception e) {
            return false;
        }
    }
}
