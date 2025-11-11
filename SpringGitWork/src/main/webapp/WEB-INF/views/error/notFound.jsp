<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>앗! 권한 초과</title>
    <style>
        body { font-family: '맑은 고딕', sans-serif; background-color: #f9f9f9; text-align: center; padding: 50px; color:#333; }
        .container { background-color:#fff3cd; border:1px solid #ffeeba; border-radius:8px; padding:40px; display:inline-block; }
        h1 { font-size:2em; color:#856404; }
        p { font-size:1.2em; margin-top:20px; }
        a { display:inline-block; margin-top:30px; padding:10px 20px; background-color:#ffc107; color:#fff; text-decoration:none; border-radius:5px; font-weight:bold; }
        a:hover { background-color:#e0a800; }
    </style>
</head>
<body>
    <div class="container">
        <h1>앗! 없는 페이지</h1>
        <p>죄송합니다.  <strong>없는 페이지입니다.</strong><br>
           </p>
        <a href="${pageContext.request.contextPath}/">홈으로 가기</a>
    </div>
</body>
</html>
