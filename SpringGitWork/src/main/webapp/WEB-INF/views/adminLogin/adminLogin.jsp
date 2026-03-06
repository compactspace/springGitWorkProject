<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.security.SecureRandom"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>

<style>
    .error-msg {
        color: red;
        font-weight: bold;
    }
</style>
</head>
<body>

<h2>Admin Login</h2>

<% 
    // 로그인 실패 시 빨간색 메시지 표시
    String error = request.getParameter("error");
    if ("true".equals(error)) {
        String errorMsg = (String) session.getAttribute("LOGIN_ERROR");
        if (errorMsg != null) {
%>
    <p class="error-msg"><%= errorMsg %></p>
<%
            session.removeAttribute("LOGIN_ERROR"); // 메시지 한 번만 표시
        }
    }
%>
<form action="${pageContext.request.contextPath}/admin/logingo.do" method="post">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <label for="username">Username:</label>
    <input type="text" id="username" name="loginId" required />
    <br/><br/>
    
    <label for="password">Password:</label>
    <input type="password" id="password" name="loginPwd" required />
    <br/><br/>
    
    <button type="submit">Login</button>
</form>

</body>
</html>
