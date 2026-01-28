package com.spring.main;

import com.sun.jna.*;
import com.sun.jna.platform.win32.*;
import com.sun.jna.platform.win32.WinNT.HANDLE;
import com.sun.jna.ptr.IntByReference;
import com.sun.jna.win32.W32APIOptions;

import java.io.File;
import java.io.RandomAccessFile;

public class NativeTailFakeExample {

    public interface MyKernel32 extends Library {
        MyKernel32 INSTANCE = Native.load("Kernel32", MyKernel32.class, W32APIOptions.DEFAULT_OPTIONS);

        boolean ReadDirectoryChangesW(
                HANDLE hDirectory,
                Pointer lpBuffer,
                int nBufferLength,
                boolean bWatchSubtree,
                int dwNotifyFilter,
                IntByReference lpBytesReturned,
                WinBase.OVERLAPPED lpOverlapped,
                WinNT.OVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine
        );

        boolean GetHandleInformation(HANDLE hObject, IntByReference lpdwFlags);
    }

    public static void main(String[] args) throws Exception {
        String dirPath = "C:\\fake";
        String fileName = "hello.txt";
        File logFile = new File(dirPath + "\\" + fileName);
        long lastPos = logFile.length();

        // 1️⃣ 파일 핸들 열기 (읽기 전용, 공유 모드 READ 허용)
        HANDLE hFile = Kernel32.INSTANCE.CreateFile(
                logFile.getAbsolutePath(),
                WinNT.GENERIC_READ,
                WinNT.FILE_SHARE_READ, // 다른 프로세스도 읽기 가능
                null,
                WinNT.OPEN_EXISTING,
                0,
                null
        );

        if (WinBase.INVALID_HANDLE_VALUE.equals(hFile)) {
            System.out.println("파일 핸들 열기 실패");
            return;
        }

        // 2️⃣ 핸들 상속 가능 여부 확인
        IntByReference flags = new IntByReference();
        boolean success = MyKernel32.INSTANCE.GetHandleInformation(hFile, flags);
        if (success) {
            boolean inheritable = (flags.getValue() & WinNT.HANDLE_FLAG_INHERIT) != 0;
            System.out.println("핸들 상속 가능: " + inheritable);
        } else {
            System.out.println("핸들 정보 가져오기 실패, 오류 코드: " + Kernel32.INSTANCE.GetLastError());
        }

        // 3️⃣ 다른 스레드에서 읽기 시도 (파일 접근 가능 여부 테스트)
        new Thread(() -> {
            try {
                Thread.sleep(500); // 메인 스레드 파일 열고 잠시 대기
                try (RandomAccessFile raf = new RandomAccessFile(logFile, "r")) {
                    String testLine = raf.readLine();
                    System.out.println("[다른 스레드] 파일 읽기 성공: " + testLine);
                }
            } catch (Exception e) {
                System.out.println("[다른 스레드] 파일 읽기 실패: " + e.getMessage());
            }
        }).start();

        // 4️⃣ 디렉터리 핸들 생성 (변경 감지용)
        HANDLE hDir = Kernel32.INSTANCE.CreateFile(
                dirPath,
                WinNT.FILE_LIST_DIRECTORY,
                WinNT.FILE_SHARE_READ | WinNT.FILE_SHARE_WRITE | WinNT.FILE_SHARE_DELETE,
                null,
                WinNT.OPEN_EXISTING,
                WinNT.FILE_FLAG_BACKUP_SEMANTICS,
                null
        );

        if (WinBase.INVALID_HANDLE_VALUE.equals(hDir)) {
            System.out.println("디렉터리 핸들 생성 실패");
            return;
        }

        System.out.println(fileName + " 변경 대기...");

        while (true) {
            Memory buffer = new Memory(1024);
            IntByReference bytesReturned = new IntByReference();

            boolean result = MyKernel32.INSTANCE.ReadDirectoryChangesW(
                    hDir,
                    buffer,
                    (int) buffer.size(),
                    false,
                    WinNT.FILE_NOTIFY_CHANGE_LAST_WRITE,
                    bytesReturned,
                    null,
                    null
            );

            if (result) {
                System.out.println(fileName + " 변경 감지!");

                // tail 읽기
                try (RandomAccessFile raf = new RandomAccessFile(logFile, "r")) {
                    raf.seek(lastPos);
                    String line;
                    while ((line = raf.readLine()) != null) {
                        System.out.println("읽음: " + line);
                    }
                    lastPos = raf.getFilePointer();
                }
            } else {
                System.out.println("이벤트 감지 실패");
            }

            Thread.sleep(200); // CPU 부담 완화
        }
    }
}
