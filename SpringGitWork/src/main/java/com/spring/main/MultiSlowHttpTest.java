package com.spring.main;

import java.io.OutputStream;
import java.io.InputStream;
import java.net.Socket;

public class MultiSlowHttpTest {

    static final int CLIENT_COUNT = 1000; // 연결 수, 너무 크게 잡으면 JVM/OS가 죽을 수 있음

    public static void main(String[] args) throws Exception {
        for (int i = 0; i < CLIENT_COUNT; i++) {
            final int id = i;
            new Thread(() -> {
                try {
                    slowClient(id);
                } catch (Exception e) {
                    System.out.println("Client " + id + " failed: " + e.getMessage());
                }
            }).start();
        }
    }

    static void slowClient(int id) throws Exception {
        Socket socket = new Socket("127.0.0.1", 8090);
        OutputStream out = socket.getOutputStream();
        InputStream in = socket.getInputStream();

        // 느린 HTTP GET 요청
        String path = "/finall/guest/communityPage";
        String request = "GET " + path + " HTTP/1.1\r\n" +
                         "Host: localhost:8090\r\n" +
                         "Connection: close\r\n" +
                         "\r\n";

        byte[] bytes = request.getBytes();

        // 바이트 단위로 느리게 보내기
        for (byte b : bytes) {
            out.write(b);
            out.flush();
          //  Thread.sleep(50); // 50ms 간격으로 보내서 느린 요청 시뮬레이션
        }

        System.out.println("Client " + id + " sent request slowly.");

        // 서버 응답 읽기 (선택)
        byte[] buffer = new byte[1024];
        int read = in.read(buffer);
        while (read != -1) {
            read = in.read(buffer);
        }

        socket.close();
    }
}
