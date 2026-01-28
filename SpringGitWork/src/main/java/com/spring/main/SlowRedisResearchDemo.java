package com.spring.main;

import java.io.OutputStream;
import java.net.Socket;

public class SlowRedisResearchDemo {

    public static void main(String[] args) throws Exception {
        // 반드시 로컬 Redis만 사용
        Socket socket = new Socket("127.0.0.1", 6379);
        OutputStream out = socket.getOutputStream();

        
        // 1️⃣ AUTH 먼저
        String auth =
                "*2\r\n" +
                "$4\r\nAUTH\r\n" +
                "$4\r\n1111\r\n";

        send(out, auth);
        
        
        String command =
                "*3\r\n" +
                "$3\r\nSET\r\n" +
                "$3\r\nkey\r\n" +
                "$5\r\nvalue\r\n";

        byte[] bytes = command.getBytes();

        for (byte b : bytes) {
            out.write(b);
            out.flush();

            // ⬅ 핵심: 일부러 매우 느리게
            Thread.sleep(300000);
        }

        // 명령 종료
        System.out.println("Command sent slowly.");

        Thread.sleep(3000);
        socket.close();
    }
    
    
    static void send(OutputStream out, String cmd) throws Exception {
        for (byte b : cmd.getBytes()) {
            out.write(b);
            out.flush();
            // 일부러 delay 안 둠 (지금은 인증 확인용)
        }
    }
    
    
}
