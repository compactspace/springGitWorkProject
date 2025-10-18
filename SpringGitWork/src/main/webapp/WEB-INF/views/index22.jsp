<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>


<head>
    <meta charset="UTF-8">
    <title>index페이지</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap" rel="stylesheet">

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <style>
      
        p{
          background-color:rgb(119,193,61)
font-family: 'Sunflower', sans-serif;

        }
        #carousel{
            margin: 0 auto;
   /*          background-image: url(img/main.jpg); */
   background-image: url(img/main2.jpg);
            background-repeat: no-repeat;
            background-size: 1200px 500px;
            height: 800px;
        }

        * {
            margin: 0;
            padding: 0;
        }

        body {

            margin: 0 0 0 0px;
        }

        /* 배치도 생각으로 전체 wrapper 감싼후 마진 오토 */
        #wrapper {
            max-width: 1020px;
            margin: 0 auto;
            padding: 0px;
        }

        header {
            position: relative;
            height: 70px;
            background: #fff;
            margin: 0;
        }

        #carousel {
            height: 450px;
            background-color: #BABABA;
            vertical-align: middle;
        }

        #carouselimg {
            text-align: center;

        }

        h2 {
            font-weight: 500;

            color: #333333;
            font-style: normal;

        }


        nav {
            position: absolute;
            top: 20px;
            width: 100%;
        }

        ul {
            display: flex;
            list-style-type: none;
        }

        li {
            display: inline-block;
            width: 30%;
            text-align: center;
            color: #333333;
            letter-spacing: .01em;
            font-style: normal;
            font-weight: 300;

        }

        a {
            text-decoration: none;
            color: #333333;
        }




        .article1 {
            background: #fff;
            height: 100%;
            margin: 0 auto;
            padding: 40px 0 40px;
        }

        #header1 {
            width: 100%;
            float: left;
            margin: 0px 0px 30px 50px;
            color: #333333;
        }

        p {
            display: block;
            width: 80%;
            margin: 0px 0px 0px 50px;


            font-weight: 300;

        }



        /* Section 2 */

        img {
            display: block;
        }

        #content2 {
            margin: 20px auto;
        }

        .sameinfo {
            background: #fff;
            height: 100%;
            margin: 0px auto 0;
            padding: 20px 0 40px;
        }

        #Section2_2 {
            float: left;
            margin: 0;
            width: 500px;
            overflow: hidden;
        }

        #info2 {
            width: 90%;
            float: left;
            margin: 0px 0px 30px 50px;
            color: #333333;
        }

        #Section2_3 {
            float: right;
            margin: 0;
            width: 500px;
            overflow: hidden;
        }



        #info3 {
            width: 90%;
            float: left;
            margin: 0px 0px 30px 50px;
        }

      

      
        .clearfix:after {
            content: ".";
            display: block;
            height: 0;
            clear: both;
            
        }

        /* 미구현 footer영역 */

        footer {
            text-align: center;
            display: block;

            height: 40px;
            background: #424141;
            margin: 20px 0 0 0;
        }

     
      

      
    </style>
</head>
<script type="text/javascript">
  var naver_id_login = new naver_id_login('oIB_pADeJKcErdJaXoqA', 'http://localhost:8090/index.jsp');
  
  // 접근 토큰 값 출력
  alert("왓????????:->>>"+naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
  /*   alert(naver_id_login.getProfileData('email'));
    alert(naver_id_login.getProfileData('nickname'));
    alert(naver_id_login.getProfileData('age')); */
  }
</script>
<body>
    <div id="wrapper">

        <header>
            <nav>
                <ul>
                    <li><a href="#">로고</a></li>
                    <li><a href="getworklist.do">참여자분들의작품</a></li>                   
                    <li><a href="#">원데이클래스</a></li>
                    <li><a href="productlist.do">팬시상품</a></li>
                     
                    <c:choose>
                    <c:when test="${userId ne null}">
                     <li>${userId}님 환영합니다.</li>    
                      <li><a href="cartlist.do?id=${userId}">장바구니-추후 로그인자만 보이도록 제이에스티엘로처리</a></li>
               </c:when>
                    <c:otherwise><li><a href="login.jsp">로그인</a></li>
                    </c:otherwise>
                        </c:choose>
                                      
                </ul>
            </nav> <!-- nav -->
        </header> <!-- header -->

        <div id="carousel">
            <div id="carouselimg">
               
            </div>

        </div>  


        <div id="content1">
            <div id="section1">
              
            </div>
            <article class="article1">
                <h2 id="header1">우유짜기 체험 소개</h2>
                <p>젖소들은 보통 생후 2년이 지나야 초산 분만을 하게 되고 우유를 짜게 됩니다. 젖소 한 마리는 하루평균 30L정도의 우유를 생산하는데 송아지가 하루에 4L의 우유를 먹고 나머지
                    우유는 우리가 먹을 수 있는 것입니다. 갓 짠 우유에서 따뜻한 어미젖소의 체온을 느낄 수 있을 것 입니다. <img src="미구현예약하러가기링크" width="20px"
                        height="20px" alt="planet_icon"></p>
            </article>
        </div> 

        <div id="content2" class="clearfix">

            <!---Section2_2 시작 --->
            <div id="Section2_2">

              <!-- 2번째 체험상품사진 -->
                <img src="images/reserve1.jpg" width="500px" height="500px" />

               
                <article class="sameinfo">
                    <h2 id="info2">치즈만들기체 프로그램</h2>
                    <p>치즈만들기 아침에 갓 짜낸 신선한 원유를 치즈벳에 넣고 살균과 발효를 하는 과정을 거치면 맛있는 스트링 치즈나 모짜렐라치즈 그리고 훼이치즈 등을 만들 수 있습니다. 와인과
                        함께하는 신선한 치즈의 맛, 평생 잊지 못할 체험이 되실 것입니다.</p>
                </article>
            </div> <!-- Section2_2 종료 -->

<!-- Section2_3 시작 -->
            <div id="Section2_3">


                <img src="images/reserve1.jpg" width="500px" height="500px" />



                <article class="sameinfo">
                    <h2 id="info3">쿠킹클래스</h2>
                    <p>얼음과 소금을 이용하여 우유만으로 맛있는 아이스크림을 만든다는 사실을 이번 체험을 통해 더 자세히 알게 될 것입니다. 또한 노동의 댓가로 얻는다는것도 느끼게 될 것입니다.
                        직접 만들어 보는 달콤한 수제 아이스크림의 맛처럼 달콤한 시간이 되셨으면 좋겠습니다.</p>
                </article>
            </div><!-- Section2_3 종료 -->

        </div> <!-- content 종료 -->




        <!-- Footer -->

        <footer>
            <h1>미구현footer</h1>
        </footer>

    </div> <!-- wrapper -->

</body>

</html>