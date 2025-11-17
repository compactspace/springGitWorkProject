<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.security.SecureRandom"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
</head>
<body>



<h2>Admin Login</h2>
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
