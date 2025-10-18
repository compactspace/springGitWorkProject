<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.mobileheader {
	display: none;
}

/*pcNave의 속성을 재정의 페이지 마다 색깔이나 배경이다르니 pcNave.jsp 의 태그 css를 수정한다.   */
.naveulwrapper ul {
	color: #000 !important;
}

.naveulwrapper li {
	color: #000 !important;
}

.naveulwrapper a {
	color: #000 !important;
}

/*pcNave의 속성을 재정의 페이지 마다 색깔이나 배경이다르니 pcNave.jsp 의 태그 css를 종료  */
p {
	background-color: rgb(119, 193, 61) font-family: 'Sunflower', sans-serif;
}

#carousel {
	margin: 0 auto;
	/* 메인사진 주석처리 해가며 어느게 가장 이쁜지 비교해보자*/
	/* 	background-image: url(./img/main.jpg); */
	background-image: url(./img/onedayclass.jpg);
	background-repeat: no-repeat;
	background-size: 1200px 500px;
	height: 500px;
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

#header1 {
	padding-bottom: 10px;
	color: #333333;
}

.infotitel p {
	font-size: 18px;
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

.bannerarea {
	
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

.cutlinearea2 {
	padding-top: 220px;
	font-weight: 800;
	font-size: 50px;
	line-height: 57px;
	color: #252525;
	margin-bottom: 58px;
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

@media screen and (max-width: 701px) {
	.mobileheader {
		display: block;
	}
	#navebarwrapper {
		display: none;
	}
	html, body {
		max-width: 340px !important;
		margin: 0px auto !important;
		padding: 0px 0px !important;
	}
	.allwrapper {
		display: none;
	}
	.mobileallwrapper {
		display: block;
	}
	.center {
		display: flex;
		flex-direction: column;
	}
	.centertitle {
		text-align: center;
		font-family: 'NanumPen';
	}
	.contents {
		display: grid;
		grid-template-columns: 50% 50%;
		grid-gap: 5px;
		grid-template-rows: 50% 50%;
	}
	.classcontent {
		background-image:
			url('${pageContext.request.contextPath}/resources/img_icon/classicon.png');
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

	/* .classcontent:after {
		content: "원데이클래스";
		position: absolute;
		left: 0px;
		bottom: -2px;
		height: 3px;
		width: 100px;
		background: red;
	} */
	.productcontent {
		background-image:
			url('${pageContext.request.contextPath}/resources/img_icon/producticon.png');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		width: 60px;
		height: 60px;
		margin: 0px auto;
		height: 60px;
	}
	.workcontent {
		background-image:
			url('${pageContext.request.contextPath}/resources/img_icon/worklisticon.jpg');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		width: 60px;
		height: 60px;
		margin: 0px auto;
		height: 60px;
	}
	.boardcontent {
		background-image:
			url('${pageContext.request.contextPath}/resources/img_icon/gasipanicon.png');
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
		max-width: 340px;
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
		max-width: 340px;
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
	.footer {
		max-width: 340px;
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
		flex-direction: row !important;
		padding: 10px 5px !important;
	}
	.infoarea {
		font-size: 12px;
	}
}
</style>

<script>          
var check;

window.onload=()=>{


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
  }

</script>

	<div class="allwarpper">

		<div id="introarea">

			<label for="needlogin">
				<div class="infotitel">
					<h2 id="header1">모두의 화방 소개</h2>
					<p>
						학원 등록에 부담감을 덜어드리며 간단하게 평소 간직하고 싶었던 그림이나 취미그림반으로 자유롭게 와서 그려보는 모두의
						화방입니다.<br>
				</div>
			</label>

		</div>

		<div class="mainbanner">

			<div class="bannerarea">
				<img class="bannerimg"
					src='${pageContext.request.contextPath}/resources/img_onedayclass/onedaymain2.png'>
			</div>

			<div class="bannerinfoarea">

				<div class="bannerinfo">
					<h2 class="infotitle">어려운전공 수없이아닌</h2>
					<p class="infocontent">자신이 원하는 그림을 선생님과 같이 이야기를나눈후 선생님과 함께 밑그림
						작업과 채색 작업을 같이하면 어려운 그림이 아닌 쉬운 그림이 됩니다.</p>
				</div>
			</div>

		</div>

		<div class="mainbanner">
			<div class="bannerinfoarea2">

				<div class="bannerinfo">
					<h2 class="infotitle">비용이 많이 드는 미술용품</h2>
					<p class="infocontent">비용 부담없이 모두의화방에서 무료로 제공해드리고 있습니다. 비용부담
						걱정을 덜어드립니다.</p>


				</div>
			</div>

			<div class="bannerarea">
				<img class="bannerimg"
					src='${pageContext.request.contextPath}/resources/img_onedayclass/onedaymain3.jpg'>
			</div>


		</div>

		<div class="cutlinearea">
			<div class="cutline">
				<h3>자유로운 주제의 그림</h3>
				<p>참여자들이 선정하는 그림</p>
			</div>
		</div>

		<div class="studentarea">
			<h3>참여자들의 작품을 소개 합니다.</h3>

			<div class="studentbanner">
				<div class="bannerarea">
					<img class="studentimg"
						src='${pageContext.request.contextPath}/resources/img/work_img3.jpg'>
				</div>

				<div class="bannerarea">
					<img class="studentimg"
						src='${pageContext.request.contextPath}/resources/img/work_img6.jpg'>
				</div>

				<div class="bannerarea">
					<img class="studentimg"
						src='${pageContext.request.contextPath}/resources/img/work_img4.jpg'>
				</div>

				<div class="bannerarea">
					<img class="studentimg"
						src='${pageContext.request.contextPath}/resources/img/work_img9.jpg'>
				</div>

				<div class="bannerarea">
					<img class="studentimg"
						src='${pageContext.request.contextPath}/resources/img/work_img8.jpg'>
				</div>

				<div class="bannerarea">
					<img class="studentimg"
						src='${pageContext.request.contextPath}/resources/img/work_img4.jpg'>
				</div>

			</div>
		</div>

		<div class="cutlinearea2">자주찾는질문을 모아봤어요</div>


		<div class="qnaarea">

			<div class="qna">
				<div class="qnatitle">Q1:그림을 배워본적이 없는데 원데이 클래스가 가능한가요?</div>
				<div class="qnaifo">A1:네 가능합니다. 선생님과 직접 그리고 싶은 그림을 상의한후 선생님이
					기본 도안을 그려드립니다.</div>
			</div>

			<div class="qna">
				<div class="qnatitle">Q2:일반 학원처럼 기간제 등록이 가능한가요?</div>
				<div class="qnaifo">A2:아니오 저희 모두의 화방은 모든 수업이 원데이 클래스로 진행중입니다.</div>

			</div>


			<div class="qna">
				<div class="qnatitle">Q3:미술용품을 지참 해야 하나요?</div>
				<div class="qnaifo">A3:아니오 저의 모두의 화방에서 수업시 필요한 미술용품을 무료로 제공
					해드리고 있습니다.</div>

			</div>

			<div class="qna">
				<div class="qnatitle">Q4:만약 해당 그림을 해당 수업시간내로 그리지 못하면 어떻게 되나요?</div>
				<div class="qnaifo">A4:괜찮습니다. 선생님이 시간에 맞게 진행하며 만약 그리지 못할시
					수업시간이 초과 되어도 같이 그려드립니다.</div>

			</div>


			<div class="qna">
				<div class="qnatitle">Q5:나이에 이용 제한이 있나요?</div>
				<div class="qnaifo">A5:없습니다만, 일반 학원이 아니기에 미취학 아동은 제한이 됩니다.</div>

			</div>

		</div>
	</div>
