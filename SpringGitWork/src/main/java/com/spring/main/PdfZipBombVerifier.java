package com.spring.main;

import java.io.File;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

public class PdfZipBombVerifier {

    public static void main(String[] args) {

        File file = new File("C:\\fake\\pdf_zip_bomb.pdf");
        // OS 파일 시스템의 실제 디스크 파일과 JVM File 객체 연결

        try (PDDocument doc = PDDocument.load(file)) {
            // ① PDF 구조 파싱
            // FileInputStream → OS 파일 핸들 통해 디스크 파일 읽음
            // PDFBox 내부에서 PDF Body, Page Tree, Page Object 생성

            System.out.println("① PDF 구조 파싱 성공");

            PDFTextStripper stripper = new PDFTextStripper();

            System.out.println("② 내용(stream) 파싱 시작...");
            // ② 내용(stream) 파싱
            // Page Object → /Contents → Stream Object 접근
            // Stream Object 내 /Filter /FlateDecode 확인
            // 압축된 스트림 데이터를 JVM 메모리에서 FlateDecode 수행
            // 압축 해제된 실제 텍스트가 InputStream / 내부 버퍼로 제공

            String text = stripper.getText(doc);

            System.out.println("③ 파싱 완료 (길이 = " + text.length() + ")");
            // ③ 압축 해제된 데이터를 기반으로 텍스트 추출 완료

        } catch (OutOfMemoryError e) {
            System.out.println("💥 PDF ZIP-BOMB 발동!");
            e.printStackTrace();

        } catch (Exception e) {
            System.out.println("❌ PDF 파싱 실패");
            e.printStackTrace();
        }
    }
}
