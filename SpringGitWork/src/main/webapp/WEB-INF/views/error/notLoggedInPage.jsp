<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 필요</title>
    <style>
        body { font-family: '맑은 고딕', sans-serif; background-color: #fff0f0; text-align: center; padding:50px; color:#333; }
        .container { background-color:#f8d7da; border:1px solid #f5c6cb; border-radius:8px; padding:40px; display:inline-block; }
        h1 { font-size:2em; color:#721c24; }
        p { font-size:1.2em; margin-top:20px; }
        a { display:inline-block; margin-top:30px; padding:10px 20px; background-color:#dc3545; color:#fff; text-decoration:none; border-radius:5px; font-weight:bold; }
        a:hover { background-color:#c82333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>로그인 필요 🔒</h1>
        <p>이 페이지를 이용하려면 로그인이 필요합니다.<br>
           계정이 없으면 회원가입 후 이용해 주세요!</p>
        <a href="${pageContext.request.contextPath}/guest/login">로그인하러 가기</a>
    </div>
</body>
</html>
