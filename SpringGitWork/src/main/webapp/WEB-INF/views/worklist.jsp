<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="headerforworklist.jsp"%>


<%@ include file="changebody.jsp"%>

<c:choose>
<c:when test="${worklist eq null }">
<div id="content1">
            <div id="section1">
            
              
            </div>
            <article class="article1">
                <h2 id="header1">원데이 클래스 소개</h2>
                <p>원데이 클래스 소개란?. 학원 등록에 부담감을 덜어드리며 간단하게  평소 간직하고 싶었던 그림이나
                    취미그림반으로 자유롭게 와서 그려보는 클래스입니다.<br>
                      <a href="onedayclass.jsp">원데이클래스확인하러가기</a>
                </p>
              
            </article>
        </div> 
        </c:when>
        <c:otherwise>
        <div id="content1">
            <div id="section1">
            
              
            </div>
            <article class="article1">
                <h2 id="header1">나의 작품 등록하기</h2>
                <p>꼭 저희 원데이 클래스 이용자만이 아닌 본인이 그린 그림을
                  올리는 자리 입니다.
                    <br>
                    <c:if test="${userId eq null }">
                    <a class="gologin" href="login.jsp">그림등록은 회원만 가능해요  회원가입하러가기</a>
                    </c:if>
                    <c:if test="${userId ne null }">
                      <button type="button" class="myimg" href="onedayclass.jsp">나의 그림 올리러가기 클릭!</button>
               
       
               </c:if>


                
                </p>
              
            </article>
    <!--   <script>

window.onload=function(){

	$("#modalContainer.hidden").hide();
	$(".myimg").click(function(){
	$("#modalContainer.hidden").css({
		"position":absolute ,"top":50%
	　"left":50%,
	　"transform": translate(-50%,-50%),
	　"background-color":#666
	}})
		
	})
	
	
}


</script> -->
        </div>
        
        
        
        
        <div id="content2" class="clearfix">
<c:forEach var="w" items="${worklist}" varStatus="i">


       

      <c:if test="${ i.index%2 eq 1}">
 
            <div id="Section2_2">

       
                <img src="./img/${w.worklist_img}" width="500px" height="500px" />

               
                <article class="sameinfo">
                    <h2 id="info2">참여자:${w.id}</h2>
                    <p>간단소개글::${w.worklist_comment}</p>
                </article>
            </div>
          <c:set var="even" value="even"/>
</c:if>
</c:forEach>

 <c:forEach var="w" items="${worklist}" varStatus="i">

<c:if  test="${ i.index%2 eq 0}">
            <div id="Section2_2">

                <img src="./img/${w.worklist_img}" width="500px" height="500px" />

                <article class="sameinfo">
                    <h2 id="info2">참여자:${w.id}</h2>
                    <p>간단소개글::${w.worklist_comment}</p>
                </article>
            </div>
</c:if>

          
</c:forEach> 



     

  </div>
  </c:otherwise>
  </c:choose>
     <footer>
            <h1>미구현footer</h1>
        </footer>
                       <div id="modalContainer" class="hidden">
  <div id="modalContent">
    <div class="alldivwrapper">
    <div class="imgdiv">
        <h1>그림등록
            <img class="imgs" src="img_membership/membership.png">
        </h1>
    
    </div>
    <div id="loginformwrapper">
       
    <form  action="/insertimg.do" method="post" enctype="multipart/form-data">
        <div class="iddiv">
            <input type="hidden" name="id" value="${userId}">
            <h3>그림을등록해주세요</h3>                                                       <!--value="${userVO.id}" 를 지워봄  -->
            <input type="file"  name="worklist_img_upload" required></div>
        <div class="passworddiv">
            <h3>그림소개나 후기를 올려주세요</h3>    																		 <!--value="${userVO.password}" 를 지워봄  -->
            <textarea name="worklist_comment" cols="30" row="5" palceholder="150글자 까지만등록가능합니다."></textarea></div>
        <br>
        <br>
        <div class="login_membershipdivwrapper">
        <!-- 조심해라! form태그 안에 버튼 태그 타입의 디폴트값은 submit으로  현재 로그인 버튼은 서브밋이다. -->
        <h3 style="text-algin:center">주의사항</h3><hr>
        <p>여러분의 작품들은 다양한 연령층이 올리고 공유하는 곳이기에 신체노출과 같은
           수위가 높은 사진은 관리자에의해 삭제될수있습니다.<br>
           다음은 예시입니다.
        </p>
        
        <div id="examplecontainer">
        <div id="noimgitems">
        <img class="yesorno" src="./yseornoimg/noimg.png">
        <h3>나쁜예시</h3>
        <p>
        상반신 기준 쇄골밑 부분은 모자이크 처리를 하여도
        관리자에의해 삭제됩니다
        </p>
        </div>
        <div id="yesimgitems">
        <img class="yesorno" src="./yseornoimg/yesimg.png">
         <h3>옳바른예시</h3>
        <p>
        상반신 기준 쇄골밑 부분은 삭제 처리를하면
        가능합니다.
        </p>
        </div>
        </div>     
        
        <button class="loginbtn" >그림등록하기</button><br><br>
        <button type="button" class="loginbtn cancelimginsert" >그림등록취소</button><br><br>

    </div>
    </form>
</div>
</div>
  </div>
</div>
        
</body>
</html>