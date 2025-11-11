<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
  /* Reset & base */
  * {
    box-sizing: border-box;
  }
  body, html {
    margin: 0; padding: 0;
    font-family: 'Noto Sans KR', sans-serif;
    background: #f9fafc;
    color: #333;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .container {
    background: #fff;
  min-width: 360px;
    
    padding: 2.5rem 2rem 3rem;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
  }

  .title {
    font-size: 2rem;
    font-weight: 700;
    color: #1a70dc;
    text-align: center;
    margin-bottom: 2rem;
  }

  form {
    display: flex;
    flex-direction: column;
  }

  label {
    font-weight: 600;
    margin-bottom: 0.4rem;
    color: #555;
  }

  input[type="text"],
  input[type="password"] {
    padding: 12px 15px;
    border: 1.5px solid #ccc;
    border-radius: 6px;
    margin-bottom: 1.5rem;
    font-size: 1rem;
    transition: border-color 0.3s;
    outline: none;
  }

  input[type="text"]:focus,
  input[type="password"]:focus {
    border-color: #1a70dc;
    box-shadow: 0 0 5px rgba(26,112,220,0.4);
  }

  button.loginbtn {
    background-color: #1a70dc;
    border: none;
    color: #fff;
    padding: 14px 0;
    font-size: 1.1rem;
    font-weight: 700;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  button.loginbtn:hover {
    background-color: #155bb5;
  }

  .membership-btn {
    margin-top: 1.5rem;
    background-color: transparent;
    border: 2px solid #1a70dc;
    color: #1a70dc;
    padding: 12px 0;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    text-align: center;
    transition: background-color 0.3s, color 0.3s;
  }

  .membership-btn:hover {
    background-color: #1a70dc;
    color: white;
  }

  /* Responsive */
  @media (max-width: 420px) {
    .container {
      padding: 2rem 1.5rem 2.5rem;
      max-width: 100%;
      margin: 0 10px;
    }
  }
</style>

<script>
  $(function() {
    $("#naver").click(function() {
      location.href = "naverloginform.do";
    });
  });
</script>

<title>로그인</title>
</head>
<body>
<div class="container">
  <div class="title">선생님 Login</div>


  <!-- 로그인 유형 선택 버튼 추가 -->
  <div style="display: flex; gap: 10px; margin-bottom: 1.5rem;">
    <button type="button" class="membership-btn" id="studentLoginBtn" style="flex:1;">학생 로그인</button>
    <button type="button" class="membership-btn" id="teacherLoginBtn" style="flex:1;">선생 로그인</button>
  </div>


  <c:if test="${not empty param.error}">
    <div style="color:red; margin-bottom: 1rem;">
      아이디 또는 비밀번호가 올바르지 않습니다.
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/teacher/logingo.do" method="post" class="login-form">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    
    <label for="id">아이디</label>
    <input type="text" id="id" name="loginId" placeholder="아이디 입력" required />

    <label for="password">비밀번호</label>
    <input type="password" id="password" name="loginPwd" placeholder="비밀번호 입력" required />

    <button type="submit" class="loginbtn">로그인</button>
  </form>
   <div role="button" tabindex="0" class="membership-btn" onclick="location.href='${pageContext.request.contextPath}/teacher/signup-page'">모두의 화방 선생님되기</div>
</div>


</body>

<script>  
  document.getElementById('studentLoginBtn').addEventListener('click', function() {
    // 선생님 로그인 페이지로 이동
    location.href = '${pageContext.request.contextPath}/guest/login';
  });
  </script>

</html>
