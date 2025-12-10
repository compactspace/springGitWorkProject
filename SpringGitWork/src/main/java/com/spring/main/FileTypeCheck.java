package com.spring.main;

import java.io.File;

import org.apache.tika.Tika;

public class FileTypeCheck {
    public static void main(String[] args) {
        try {
            // 검사할 파일 경로
            File file = new File("C:\\fake\\fake.jpg");

            // Apache Tika 객체 생성
            Tika tika = new Tika();

            // 실제 MIME 타입 검사
            String mimeType = tika.detect(file);

            // 결과 출력
            System.out.println("Detected MIME type: " + mimeType);

            // 간단히 이미지인지 확인
            if (mimeType.startsWith("image")) {
                System.out.println("이미지 파일입니다.");
            } else {
                System.out.println("이미지가 아닙니다!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}