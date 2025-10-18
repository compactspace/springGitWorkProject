 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body>
<div class="allwarpper">
     <div id="wrappers"> 

        <header>
            <nav>
                <ul>            
                  <li><a href="onedayclass.jsp">원데이클래스</a></li>
                    <li><a href="getworklist.do">참여자분들의 작품</a></li>               
                    
                     <li><a href="firstgetboad.do?page=0">여러분의게시판</a></li>
                    <c:choose>                  
           
                    <c:when test="${userId ne null && user_where=='finalluser'}">
                  
                     <li>${userId}님<a href="myinfo.jsp"> 정보수정</li>
                       <li><a href="cartlist.do?id=${userId}">장바구니</a></li>
                       <li><a href="logout.do">로그아웃</a></li>
                         </c:when>
                            <c:when test="${user_where ne'finalluser' && userId ne null }">              
                
                       <li><a href="cartlist.do?id=${userId}">장바구니</a></li>
                       <li><a href="logout.do">로그아웃</a></li>
                         </c:when>
                         
                          <c:otherwise>
                       
          
                   <li><a href="login.jsp">로그인</a></li>
                    </c:otherwise>
                        </c:choose>
                    <li><a href="productlist.do">팬시상품</a></li>              
                </ul>
            </nav> <!-- nav -->
        </header> <!-- header -->
        
</div>
 