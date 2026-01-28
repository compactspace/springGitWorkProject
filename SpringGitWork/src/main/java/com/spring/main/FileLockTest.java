package com.spring.main;

import java.io.File;
import java.io.RandomAccessFile;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;

public class FileLockTest {

	public static void main(String[] args) throws Exception {

        // C:\fake 폴더
        File dir = new File("C:\\fake");
        if (!dir.exists()) {
            dir.mkdirs(); // 폴더 없으면 생성
        }

        // C:\fake\locktest.txt 파일
        RandomAccessFile raf =
                new RandomAccessFile("C:\\fake\\locktest.txt", "rw");

        FileChannel channel = raf.getChannel();

        // 파일 잠금 (다른 프로세스 접근 불가)
        FileLock lock = channel.lock();

        System.out.println("파일 잠금됨: C:\\fake\\locktest.txt");
        System.out.println("이 창을 닫지 말고 테스트하세요");
        System.out.println("Enter 누르면 종료 + 잠금 해제");

        // 프로그램 살아있게 유지
        System.in.read();

        // 정리
        lock.release();
        channel.close();
        raf.close();
    }
	

}
