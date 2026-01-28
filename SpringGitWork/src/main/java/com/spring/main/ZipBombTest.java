package com.spring.main;

import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class ZipBombTest {

    public static void main(String[] args) throws Exception {

        File file = new File("C:\\fake\\big.zip");

        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(file))) {

            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {

                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];

                int len;
                while ((len = zis.read(buffer)) > 0) {
                    baos.write(buffer, 0, len); // 🔥 메모리 계속 쌓임
                }

                System.out.println("압축 해제 완료: " + baos.size());
            }

        } catch (OutOfMemoryError e) {
            System.out.println("💥 OutOfMemoryError 발생!");
            e.printStackTrace();
        }
    }
}
