package com.spring.main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
public class DbConnectionExample1 {

	  public static void main(String[] args) {
	        String url = "jdbc:mariadb://localhost:3306/employees?socketTimeout=2000"; // 2초
	        String user = "root";
	        String password = "1111";

	        try (Connection conn = DriverManager.getConnection(url, user, password);
	             Statement stmt = conn.createStatement()) {

	            // 일부러 오래 걸리는 쿼리
	            ResultSet rs = stmt.executeQuery("SELECT SLEEP(50)"); // 5초 대기
	            while (rs.next()) {
	                System.out.println(rs.getString(1));
	            }

	        } catch (Exception e) {
	            System.out.println(e.getMessage());
	        }
	    }
}
