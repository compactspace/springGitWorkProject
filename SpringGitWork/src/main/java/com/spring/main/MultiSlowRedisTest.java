package com.spring.main;

import java.io.OutputStream;
import java.net.Socket;

public class MultiSlowRedisTest {

    static final int CLIENT_COUNT = 100000; // 연결 수

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
        Socket socket = new Socket("127.0.0.1", 6379);
        OutputStream out = socket.getOutputStream();

        // AUTH
        String auth = "*2\r\n$4\r\nAUTH\r\n$4\r\n1111\r\n";
        send(out, auth);

        // 느린 SET 명령
        String command = "*3\r\n$3\r\nSET\r\n$4\r\nkey" + id + "\r\n$5\r\nvalue\r\n";
        byte[] bytes = command.getBytes();

        for (byte b : bytes) {
            out.write(b);
            out.flush();
            Thread.sleep(300000); // 테스트용: 3초씩 느리게
        }

        System.out.println("Client " + id + " sent command slowly.");
        Thread.sleep(3000);
        socket.close();
    }

    static void send(OutputStream out, String cmd) throws Exception {
        for (byte b : cmd.getBytes()) {
            out.write(b);
            out.flush();
        }
    }
}
