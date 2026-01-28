package com.spring.main;

import java.io.File;
import java.io.IOException;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

public class FileContentBodyCheck {

    public static void main(String[] args) {

        // 확장자와 상관없이 실제 내용물로 검사
        File file = new File("C:\\fake\\test2.pdf"); // 내용물은 PDF

        try (PDDocument doc = PDDocument.load(file)) {

            // 구조 검증 성공 시
            System.out.println("✅ PDF 구조 정상 (헤더+바디 파싱 성공)");

            // ====================================================
            // 🔥 전체 파싱: 모든 페이지와 스트림 접근 (Lazy 로딩 강제)
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(doc); // 모든 페이지와 content stream 읽음
            System.out.println("✅ PDF 전체 파싱 완료, 텍스트 길이: " + text.length());

            // 필요 시 페이지 순회 예시
            doc.getPages().forEach(page -> {
                try {
                    page.getResources(); // 이미지, 폰트 스트림 강제 접근
                } catch (Exception e) {
                    System.out.println("⚠️ 페이지 리소스 접근 실패: " + e.getMessage());
                }
            });

        } catch (IOException e) {
            // PDF 구조가 아니거나
            // 헤더/바디/xref/스트림 중 하나라도 깨져 있으면 여기로 옴
            System.out.println("❌ PDF 아님 (내용물 파싱 실패)");
            e.printStackTrace();
        }
    }
}
