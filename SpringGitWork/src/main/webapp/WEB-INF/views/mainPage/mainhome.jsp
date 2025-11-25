<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/commonAjax.js"></script>
<!-- <script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cec9a6b4bed5ff14412ea02035eb0e4a"></script> -->
<style>
.mobileallwrapper {
/* 	max-width: 344px; */
	display: none;
}


.firstgetboad {
	border-radius: 10px;
	color: white;
	border: 1px solid;
	background-color: rgb(255, 88, 98);
}

.allwrapper {
	height: 100%;
	position: relative;
}


.headerarea {
	background-image: url('./img_mainhome/banner1.jpeg');
	background-color: aqua;
	background-position: center;
	background-repeat: no-repeat;
	background-attachment: scroll;
	background-size: cover;
	height: 100%;
}


.spacingcenter {
	margin-top: 60px;
	margin-bottom: 60px;
	text-align: center;
}

.spacingcenter>h3 {
	display: inline-block;
}

.logimg>img {
	width: 100%;
	height: 100%;
}

.menuil>.subinfoone img {
	width: 100%;
	height: 100%;
	padding-right: 10px;
	padding-left: 10px;
}

.subinfoone>img {
	width: 100%;
	height: 90%;
	padding-right: 10px;
	padding-left: 10px;
}

.subinfoone>h2 {
	color: #454545;
	font-size: 24px;
	margin-bottom: 18px;
}

.menuflex {
	display: flex;
	flex-direction: row;
}

.menuil {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.menuewrapper {
	padding-top: 10px;
	border-bottom: 1px solid #eee;
}

.centermenu {
	padding: 140px 0 130px 0;
}

.centercontainder {
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

.centermenutitlearea {
	text-align: center;
	margin-bottom: 100px;
}

.centermenuimgarea {
	display: flex;
	justify-content: center;
	gap: 30px;
	text-align: center;
}

.imgcolumns {
	
}

.centerimg {
	margin-bottom: 40px;
}

.centerimg img {
	width: 250px;
	height: 200px;
}

}
.centerimginfo {
	
}

.centerimginfo h3 {
	color: #454545;
	font-size: 24px !important;
	margin-bottom: 18px;
}

.centerimginfo a {
	border: 1px solid;
	padding: 5px 10px;
	line-height: 1.5;
	border-radius: 3px;
	font-size: 15px;
	line-height: 1.5;
	border-radius: 3px;
	color: #333;
	background-color: #fff;
	border-color: #ccc;
}

/* .menuediv {
	line-height: 4;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
	display: flex;
	flex-direction: row;
} */
.menueul {
	display: flex;
	justify-content: space-between;
}

.menueul>li {
	margin-right: 14px;
	display: inline-block;
}

.logimg>img {
	width: 130px;
	height: 65px;
}

.bannerarea {
	padding-left: 20px;
	font-weight: 700;
	color: white;
	font-size: 40px !important;
}

.bannerarea h3 {
	font-size: 40px !important;
	font-weight: 700;
}

.centerartimg img {
	width: 269px;
	height: 345px;
}

#introarea {
	padding: 30px 0;
	max-width: 1220px;
	margin: 0 auto;
}

.infotitel {
	font-size: 25px;
	padding-bottom: 10px;
}

.infocontent {
	font-size: 20px;
}

.mainbanner {
	padding-bottom: 30px;
	grid-gap: 10px;
	display: grid;
	grid-template-columns: 50% 50%;
	max-width: 1220px;
	margin: 0 auto;
}

.bannerinfoarea {
	border-radius: 20px 20px 0 0;
	color: white;
	font-weight: 700;
	position: relative;
	background-color: rgb(255, 88, 98);
}

.bannerinfo {
	margin-top: -36px;
	top: 50%;
	position: absolute;
}

.bannerimg {
	width: 100%;
	border-radius: 20px 20px 0 0;
}

.bannerinfobtn {
	position: absolute;
	bottom: 0px;
	right: 0px;
	padding-right: 10px;
	padding-bottom: 15px;
}

.bannerinfobtn a {
	font-size: 20px;
	color: white;
	font-weight: 600;
}

.bannerinfoarea2 {
	border-radius: 20px 20px 0 0;
	color: white;
	font-weight: 700;
	position: relative;
	background: #1e81f8;
}

.cutlinearea {
	height: 130px;
	background-color: rgb(255, 88, 98);
}

.cutline {
	font-size: 25px;
	font-weight: 600;
	color: white;
	padding-top: 35px;
	text-align: center;
	width: 50%;
	margin: 0 auto;
}

.studentarea {
	padding-top: 30px;
	max-width: 1220px;
	margin: 0 auto;
}

.studentarea h3 {
	color: #333333;
	padding-bottom: 30px;
	font-size: 30px;
}

.studentbanner {
	padding-bottom: 30px;
	grid-gap: 10px;
	display: grid;
	grid-template-columns: 30% 30% 30%;
	grid-template-rows: 40% 40%;
	max-width: 1220px;
	margin: 0 auto;
}

.studentimg {
	height: 100%;
	width: 100%;
	border-radius: 20px 20px 0 0;
}

.qnaarea {
	max-width: 1220px;
	margin: 0 auto;
}

.qna {
	padding: 10px 0px;
}

.qnatitle {
	background: #FFF0F1;
	border-radius: 12px 12px 12px 12px;
	padding: 40px 35px;
	font-weight: 700;
	font-size: 26px;
	line-height: 30px;
	color: #252525;
}

.qnaifo {
	display: none;
	font-weight: 400;
	font-size: 20px;
	line-height: 23px;
	color: #252525;
}

.footer {
	background: #272727;
}

.footercontainer {
	color: white;
	margin-right: auto;
	margin-left: auto;
	padding: 30px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}


.footercontainer .rowwrapper {
/* 	width: 80%; */
	margin: 10px auto;
	display: flex;
}

.rowwrapper {
	justify-content: center;
	gap: 20px;
}

.rowwrapper .rows {
	display: flex;
	text-align: center;
	flex-direction: column;
}






/*반응형 시작  */
@media screen and (max-width: 701px) {
	html, body {
	
		padding: 0px 10px !important;
	}
.centermenutitlearea {
	text-align: left;
	margin-bottom: 15px;
}

.centermenu {
    padding: 80px 0 130px 0;
}



	.allwrapper {
		display: none;
	}
	.mobileallwrapper {
		display: block;
	}


	a {
		color: #0275d8;
		text-decoration: none !important;
	}
	a:visited {
		text-decoration: none;
	}

	.center {
		display: flex;
		flex-direction: column;
	}
	
	.centertitle {
		padding:10px 10px;
		text-align: center;
		font-family: 'NanumPen';
	}
	.contents {
	padding: 20px 0 20px 0;
	display: flex;
    flex-direction: row;
    justify-content: space-around;    
	}
	
	.classcontent {
		background-image:	url('${pageContext.request.contextPath}/resources/img_icon/classicon.png');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		width: 60px;
		height: 60px;
		margin: 0px auto;
		height: 60px;
	}
	.contentsitems {
		display: flex;
		flex-direction: column;
	}
	.contentsitems h4 {
		margin: 0px 0px;
		font-size: 10px;
		text-align: center;
	}


	.productcontent {
		background-image: url('${pageContext.request.contextPath}/resources/img_icon/producticon.png');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		width: 60px;
		height: 60px;
		margin: 0px auto;
		height: 60px;
	}
	.workcontent {
		background-image: url('${pageContext.request.contextPath}/resources/img_icon/worklisticon.jpg');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		width: 60px;
		height: 60px;
		margin: 0px auto;
		height: 60px;
	}
	
	.boardcontent {
		background-image: url('${pageContext.request.contextPath}/resources/img_icon/gasipanicon.png');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		width: 60px;
		height: 60px;
		margin: 0px auto;
		height: 60px;
	}
	#introarea {
		padding: 30px 0;
		max-width: 344px;
		margin: 0 auto;
	}
	.infotitel  h2 {
		font-family: 'NanumPen';
		font-size: 25px;
		padding-bottom: 10px;
	}
	.infotitel  p {
		font-family: 'NanumPen';
		font-size: 15px;
		padding-bottom: 10px;
	}
	.mainbanner {
		padding-bottom: 30px;
		grid-gap: 0px !important;
		display: grid;
		grid-template-columns: 50% 50%;
		max-width: 344px;
		margin: 0 auto;
	}
	.bannerinfo {
		margin-top: 0px !important;
		top: 0px !important;
		position: absolute;
	}
	.infotitle {
		padding-top: 2px;
		text-align: center;
		font-size: 13px;
		font-family: 'NanumPen';
	}
	.infocontent {
		font-size: 10px !important;
	}
	.bannerinfobtn a {
		font-size: 6px !important;
	}
	.bannerarea {
		padding: 0px 0px !important;
		color: white;
	}
	.cutlinearea {
		height: auto !important;
		background-color: rgb(255, 88, 98);
	}
	.cutline {
		font-size: 15px !important;
		font-weight: 600;
		color: white;
		padding-top: 5px !important;
		text-align: center;
		width: 60% !important;
		margin: 0 auto;
	}
	.cutline h3 {
		display: none;
	}
	.studentarea h3 {
		font-size: 13px !important;
		font-family: 'NanumPen' !important;
	}
	
	
	.footercontainer {
		padding: 0px 0px !important;
	}
	.footercontainer .rowwrapper {
		margin: 0px 0px !important;
		gap: 0px !important;
	}
	.rowwrapper {
		flex-direction: column;
	}
	.rows {
		gap:10px;
		flex-direction: row !important;
		padding: 10px 5px !important;
	}
	
	.logoarea{
	display: flex
;
    flex-direction: column;
    justify-content: center;
	}
	
	
	.logoarea img{
		display: inline-block;
	}
	
	
	.footertext{
	font-size: 12px;
	
	}
	
}
 /* 반응형 종료 */






</style>



<!-- 걍 이걸 로 나중에 뒤로/앞으로/새로가기 막자  -->
<c:choose>
    <c:when test="${empty sessionScope.visited}">
        <!-- 첫 방문 -->
        <c:set var="visitStatus" value="first" />
        <c:set var="visited" value="true" scope="session" />
    </c:when>
    <c:otherwise>
        <!-- 새로고침 또는 재방문 -->
        <c:set var="visitStatus" value="return" />
    </c:otherwise>
</c:choose>











<script>



var check;
var key;
	window.onload = function() {			
		
		$("#testBtn").on("click", function() {
		    ajaxRequest({
		        url: "${pageContext.request.contextPath}/api/guest/test",
		        type: "POST",
		        dataType: "json",
		        success: function(res) {
		            console.log("✅ 성공 응답:", res);
		            alert("성공: " + res.message);
		        }
		    }, {
		        client: function(res) {
		            console.log("⚠️ 클라이언트 오류:", res);
		            alert("클라이언트 오류: " + res.message + " (code: " + res.code + ")");
		        },
		        server: function(res) {
		            console.log("🔥 서버 오류:", res);
		            alert("서버 오류: " + res.message + " (code: " + res.code + ")");
		        }
		    });
		});
		
		
		
		
		
		
		
		
		
		
		
		let qna = document.querySelectorAll('.qnatitle');

		function openCloseAnswer() {
		    
		    console.log($(this).next().css('display'))
		console.log(document.getElementsByClassName("qnaifo"))
		    if($(this).next().css('display') === 'none') {
		        $(this).next().css('display','flex')
		         $(this).next().css('justify-content','space-evenly');
		        $(this).next().css('padding','40px 0');
		         $(this).next().css('background','#FFFFFF');
		        $(this).next().css('border-radius','0px 0px 12px 12px');
		        $(this).next().css('border-right','1px solid #D7D7D7');
		        $(this).next().css('border-bottom','1px solid #D7D7D7');
		        $(this).next().css(' border-left','1px solid #D7D7D7');      

		    
		    } else {
		        $(this).next().css('display','none')
		    }
		  }

		  qna.forEach(qna  => qna.addEventListener('click', openCloseAnswer));

		
		
	
		

		function scrollpositon() {
			let $centermenu = $('.menuewrapper')//그져 객체에 담기
			let $allwrapper = $('.allwrapper')//그져 객체에 담기
			let topmenu = $centermenu.offset().top;
			console.log("센터메뉴의 좌표는->>" + topmenu);

			let topmenuheight = $centermenu.outerHeight(true);
			let allwrapperheight = $allwrapper.outerHeight(true);
			console.log("센터메뉴의 컨텐츠영역+페딩+보더영역 높이는->>" + topmenuheight);
			//스크롤 이 계속 바뀜에 따라 속성을 주는 함수를 내부적으로 호출
			function updatescroll() {
				let scrollTop = $(window).scrollTop();
				console.log("scrollTop->>" + scrollTop);
				// console.log(".menuewrapper 빼기 scrollTop ->>"+(scrollTop-topmenu));
				if ((scrollTop - topmenu) >= 0) {
					//482.188
					console.log("scrollTop-topmenu->>" + (scrollTop - topmenu));
					console.log("센터메뉴의 컨텐츠영역+페딩+보더영역 높이는->>" + topmenuheight);
					/* 스크롤 상관없이 올레퍼헤이트의 객체 높이는 변함없음  */
					console.log("올레퍼의 길이는->>" + allwrapperheight);
					console.log("올레퍼의 빼기길이->>" + (allwrapperheight - topmenu));
					let minuheight = allwrapperheight - topmenu;
					$centermenu.css({
						'background-color' : '#fff',
						'z-index' : '100',
						'width' : '100%',
						'position' : 'absolute',
						'top' : scrollTop
					});
					/*  $(".allwrapper").css({'height':minuheight,'background-color':'red'});  */
				} else {
					$centermenu.css({
						'background-color' : ' ',
						'z-index' : '100',
						'width' : '100%',
						'position' : '',
						'top' : ''
					});
					$(".allwrapper").css({
						'height' : '100%'
					});
				}
			}

			$(window).on('scroll', updatescroll);
 
		}

		
	$(".managermode").on("click",()=>{		
		key=localStorage.getItem("key");
		console.log("로컬스토리지 토큰값"+key)	
		$.ajax({				
			url:"adminmode.do",
			 beforeSend: function (xhr) {
		            xhr.setRequestHeader("Content-type","application/json");
		            xhr.setRequestHeader("Authorization","Bearer "+localStorage.getItem("key"));
		            xhr.setRequestHeader("걍아무키","걍아무값");
		            },
			success:(data,status,request)=>{
				console.log(data)
				console.log(status)
				console.log(request)
			//location.replace("/finall/"+data);				
			}	
			
		})	
		
	})		
	
	
	
	
	$(".headertest").on("click",()=>{		
		
		$.ajax({				
			url:"http://localhost:8000",
			 beforeSend: function (xhr) {
		            xhr.setRequestHeader("Content-type","application/json");
		            xhr.setRequestHeader("Authorization","Bearer "+"ssssssssssssssssssssssssssssssssssssssss");
		            xhr.setRequestHeader("걍아무키","걍아무값");
		            },
			success:(data,status,request)=>{
				console.log(data)
				console.log(status)
				console.log(request)
			location.replace("/finall/"+data); 
			}	
			
		})	
		
	})
	
		
	$(document).on('click',".nextbtn" ,function() {			
		
		let page = parseInt($(this).prev().text());

		console.log("next버튼클릭->>"+page);
		
		if(page%10==0){
			location.href="getboadnext.do?page="+page					
		} 
}) 	




const topTenOnedayclassComponentLoad = () => {

	
	  $.ajax({
	    url: "${pageContext.request.contextPath}/guest/get-onedayclass-list",
	    method: "GET",
	    success: (res) => {
	      $(".toptenOnedayclass").html(res); // 렌더링된 JSP 조각 삽입
	    },
	    error: (err) => {
	      console.error("JSP 조각 불러오기 실패:", err);
	    }
	  });
	};

	const introduceOnedayclassComponentLoad = () => {	
		
		  $.ajax({
		    url: "${pageContext.request.contextPath}/guest/get-introduce-onedayclass",
		    method: "GET",
		    success: (res) => {
		      $(".introduce-onedayclass-frgment").html(res); // 렌더링된 JSP 조각 삽입
		    },
		    error: (err) => {
		      console.error("JSP 조각 불러오기 실패:", err);
		    }
		  });
		};	
	
	topTenOnedayclassComponentLoad();
	introduceOnedayclassComponentLoad();
	
	

	}//윈도우 온로드 함수 종료
</script>
</head>
<body style="height: 100vh;">
	<div class="allwrapper">
	
	<!-- <button id="testBtn" >서버 오류 테스트</button> -->
<%-- 	 <img src="${pageContext.request.contextPath}/resources/cmd/dot.bmp">
<script src="${pageContext.request.contextPath}/resources/cmd/dot.bmp"></script> --%>



		<%@ include file="../pcNave.jsp"%>



		<div class="centermenu">
			<div class="centercontainder">
				<div class="centermenutitlearea">
					<h3>도심속 모두의 화방</h3>
					<p>도심속에서 취미와 힐링을 찾아보세요</p>
				</div>
				<div class="centermenuimgarea">
					<div class="imgcolumns">
						<div class="centerimg">
							<img
								src="${pageContext.request.contextPath}/resources/img_mainhome/onedaybanner1.jpeg">
						</div>
						<div class="centerimginfo">
							<h3>원데이클래스 안내</h3>


							<!-- 다시 이것으로 바꾸어라 /guest/onedayclass-intro  -->
							<a
								href="${pageContext.request.contextPath}/guest/onedayclass-intro">detail</a>
						</div>

					</div>
					<div class="imgcolumns">
						<div class="centerimg">
							<img
								src="${pageContext.request.contextPath}/resources/img_mainhome/main_work_banner.jpeg">
						</div>

						<div class="centerimginfo">
							<h3>참여자 작품</h3>
							<a href="${pageContext.request.contextPath}/guest/workpage">detail</a>
						</div>
					</div>
					<div class="imgcolumns">
						<div class="centerimg">
							<img
								src="${pageContext.request.contextPath}/resources/img_mainhome/main2.jpg">
						</div>


						<div class="centerimginfo">
							<h3>미술용품</h3>
							<a href="${pageContext.request.contextPath}/guest/productlist">detail</a>
						</div>
					</div>
				</div>
			</div>
		</div>



		<div class="centermenu">
			<div class="centercontainder">
				<div class="centermenutitlearea">
					<h3>참여자들이 검증한</h3>
					<p>인기 원데이 클래스</p>
				</div>
				<!-- 여기 안에 JSP fragment가 AJAX로 삽입됨 -->
				<div class="toptenOnedayclass"></div>

			</div>

		</div>


		<div class="centermenu">
			<div class="centercontainder">
				<div class="centermenutitlearea">
					<h3>참여자들이 검증안 원데이 클래스</h3>
					<p class="headertest">원데이 클래스에서 당일로 작품을 만듭니다.</p>
				</div>
				<div class="centermenuimgarea">
					<div class="imgcolumns">
						<div class="centerartimg">
							<img
								src="${pageContext.request.contextPath}/resources/img_mainhome/art1.jpg">
						</div>
					</div>

					<%-- 	<div class="imgcolumns">
						<div class="centerartimg">
							<img src="${pageContext.request.contextPath}/resources/img_mainhome/art2.jpg">
						</div>
					</div> --%>
					<div class="imgcolumns">
						<div class="centerartimg">
							<img
								src="${pageContext.request.contextPath}/resources/img_mainhome/art3.jpg">
						</div>
					</div>
					<div class="imgcolumns">
						<div class="centerartimg">
							<img
								src="${pageContext.request.contextPath}/resources/img_mainhome/art4.jpg">
						</div>
					</div>
				</div>
			</div>
		</div>



		<div class="introduce-onedayclass-frgment"></div>



		<footer class="footer">

			<div class="footercontainer">

				<div class="rowwrapper">
					<div class="rows">
						<div class="logoarea">
							<img src="${pageContext.request.contextPath}/resources/img_mainhome/logo1.png">
						</div>
						<div class="infoarea">상호 : 아트토리 대표 : 이곤 주소 : 서울시 노원구 상계로 74
							4F 사업자번호 : 105-17-78854</div>
					</div>

					<div class="rows">
						<div class="logoarea">
							<img src="${pageContext.request.contextPath}/resources/img_mainhome/logo2.png">
						</div>
						<div class="infoarea">male : ###@naver.com</div>
					</div>

					<div class="rows">
						<div class="logoarea">
							<img src="${pageContext.request.contextPath}/resources/img_mainhome/logo3.png">
						</div>
						<div class="infoarea">tell : 027-###-###</div>
					</div>
				</div>

			</div>
		</footer>

	</div>



	<!-- 모바일디자인 시작 -->
	<div class="mobileallwrapper">
		<%@ include file="../mobileNave.jsp"%>
		<div class="center">
			<div class="centertitle">
				<h3>모두의 화방</h3>
			</div>



			<div class="contents">
			
				<div class="contentsitems">
					<a href="${pageContext.request.contextPath}/guest/onedayclass-intro">
						<div class="classcontent"></div>
						<h4>원데이클래스 소개</h4>
					</a>
				</div>

				<div class="contentsitems">
					<a href="${pageContext.request.contextPath}/guest/productlist">
						<div class="productcontent"></div>
						<h4>상품구경</h4>
					</a>
				</div>

				<div class="contentsitems">
					<a href="${pageContext.request.contextPath}/guest/get-onedayclass-detail-one-page">
						<div class="workcontent"></div>
						<h4>원데이클래스 수업확인</h4>
					</a>
				</div>

				<div class="contentsitems">
					<a href="${pageContext.request.contextPath}/guest/communityPage">
						<div class="boardcontent"></div>
						<h4>작업물자랑</h4>
					</a>
				</div>

			</div>




		<div class="centermenu">
			<div class="centercontainder">
				<div class="centermenutitlearea">
					<h3>참여자들이 검증한</h3>
					<p>인기 원데이 클래스</p>
				</div>
				<!-- 여기 안에 JSP fragment가 AJAX로 삽입됨 -->
				<div class="toptenOnedayclass"></div>

			</div>

		</div>



	<!-- 		<div class="mainbanner">

			

			</div>



			<div class="mainbanner">
				


			</div>

			<div class="cutlinearea">
				
			</div>


			<div class="studentarea">
			
			</div> -->
		</div>
		
		

		<footer class="footer">
			<div class="footercontainer">

				<div class="rowwrapper">
					<div class="rows">
						<div class="logoarea">
							<img src="${pageContext.request.contextPath}/resources/img_mainhome/logo1.png">
						</div>
						<div class="footertext infoarea">상호 : 아트토리 대표 : 이곤 주소 : 서울시 노원구 상계로 74
							4F 사업자번호 : 105-17-78854</div>
					</div>

					<div class="rows">
						<div class="logoarea">
							<img src="${pageContext.request.contextPath}/resources/img_mainhome/logo2.png">
						</div>
						<div class="footertext infoarea">male : ###@naver.com</div>
					</div>

					<div class="rows">
						<div class="logoarea">
							<img src="${pageContext.request.contextPath}/resources/img_mainhome/logo3.png">
						</div>
						<div class="footertext infoarea">tell : 027-###-###</div>
					</div>
				</div>

			</div>
		</footer>
		
	</div>
	<!-- 모바일디자인 종료 -->
</body>
</html>