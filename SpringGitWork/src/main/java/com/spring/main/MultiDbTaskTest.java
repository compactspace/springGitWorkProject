package com.spring.main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MultiDbTaskTest {

    static final int CLIENT_COUNT = 80; // 동시 DB 연결 수

    public static void main(String[] args) throws Exception {
        for (int i = 0; i < CLIENT_COUNT; i++) {
            final int id = i;
            new Thread(() -> {
                try {
                    dbTaskClient(id);
                } catch (Exception e) {
                    System.out.println("Client " + id + " failed: " + e.getMessage());
                }
            }).start();
        }
    }

    static void dbTaskClient(int id) throws Exception {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/employees?serverTimezone=UTC",
                    "root", "1111");

            String sql = 
            	    "SELECT d.dept_name, t.title, COUNT(e.emp_no) AS employee_count, " +
            	    "AVG(s.salary) AS avg_salary, MAX(s.salary) AS max_salary, MIN(s.salary) AS min_salary " +
            	    "FROM employees e " +
            	    "JOIN dept_emp de ON e.emp_no = de.emp_no " +
            	    "JOIN departments d ON de.dept_no = d.dept_no " +
            	    "JOIN titles t ON e.emp_no = t.emp_no " +
            	    "JOIN salaries s ON e.emp_no = s.emp_no " +
            	    "WHERE t.to_date > CURDATE() AND s.to_date > CURDATE() " +
            	    "GROUP BY d.dept_name, t.title " +
            	    "ORDER BY avg_salary DESC";


            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

//            while (rs.next()) {
//                System.out.printf(
//                    "Client %d -> Dept: %s, Title: %s, Count: %d, Avg: %.2f, Max: %.2f, Min: %.2f%n",
//                    id,
//                    rs.getString("dept_name"),
//                    rs.getString("title"),
//                    rs.getInt("employee_count"),
//                    rs.getDouble("avg_salary"),
//                    rs.getDouble("max_salary"),
//                    rs.getDouble("min_salary")
//                );
//            }

            rs.close();
            pstmt.close();
        } finally {
            if (conn != null) conn.close();
        }
    }
}
