<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<style>


#onedayclass_name_btn {
justify-content: space-between;
width: 138.67px;
	border-radius: 5px 5px 5px 5px;
	border: 2px solid #ff5862;
}

.open {
	background: #ff5862;
	color: white;
	width: 100px;
	border-bottom: 1px solid black;
	border-right: 1px solid black;
	border-left: 1px solid black;
	boder: 10px 10px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
}

.open li {
	padding: 10px 0px;
}

.onedayclass_name_btn {
	background: transparent;
	border: none;
}

h3, p {
	padding: 0px 0px;
	margin: 0px 0px;
}

ul {
	list-style: none;
	padding: 0px 0px;
	margin: 0px 0px;
}

.allwrapper {
	max-width: 480px;
	margin: 0 auto;
}

.mobilewrapper {
	display: none;
}

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
.pcboxwrapper {
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
}

#onedayclass_name_btn {
	height: 25px;
	overflow: hidden;
	display: flex;
}

.onedayclass_name_list {
	
}

.choicename {
	
}

.contenttilewrapper {
	color: #343a40;
	font-size: 20px;
	font-weight: 700; //
	letter-spacing: -.4px;
	line-height: 1.25;
	margin: 0;
}

.contenttilewrapper h3 {
	margin: 0px 0px;
}

.contentimgtitlewrapper {
	margin: 10px 0px;
}

.contentimgtitlearea {
	width: 100%;
	height: 480px;
	background-size: 100% 100%;
	background-image: url('./img_onedayclass/manhwa.jpg');
}

.candidateimgwrapper {
	display: grid;
	grid-template-columns: 160px 160px 160px;
}

.candidateimgarea {
	width: 140px;
	height: 140px;
	background-size: 100% 100%;
	height: 140px;
}

.linecut1 {
	padding: 10px 0;
	margin: 10px 15px 0;
	display: flex;
	align-items: center;
	justify-content: center;
	/* border: 1px solid #ff5862; */
	background: #FFF0F1;
	border-radius: 5px;
	font-size: 13px;
	line-height: 15px;
	font-weight: 700;
}

.commentwrapper {
	
}

.reviewsize {
	
}

.reviewsize span {
	color: #ff5862;
}

.recentreviewwrapper {
	/* 	background-color: #F8F8F8; */
	border-top: 2px solid #F8F8F8;
	border-bottom: 2px solid #F8F8F8;
	margin: 10px 0px;
}

.recentreviewwrapper p {
	color: #343a40;
	font-size: 15px;
	letter-spacing: -.3px;
	line-height: 1.6;
}

.recentreview {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	flex-direction: column;
	justify-content: space-between;
}

.recentreview p, .recentreview .reviewimg {
	padding: 10px 10px;
}

.reviewimg {
	border-radius: 20px 20px 20px 20px;
	width: 250px;
	height: 180px;
	background-size: 100% 100%;
}

.reviewcreate {
	display: flex;
	justify-content: space-between;
}

/* 나중에 몇글자 이상은 삽입 불가입니다. 기능도 넣자 그걸 감안한 500px이니깐... */
.commentcontent {
	width: 500px;
}

.createcontent {
	align-content: end;
}

.nextpage {
	display: flex;
	justify-content: center;
}

.nextpagebtn {
	font-size: 15px;
	background: #FFF0F1;
	color: #ff5862;
	width: 100px;
	border: none;
	height: 50px;
	border-radius: 20px 20px 20px 20px;
}

img {
	width: 100%;
	height: 230px;
}

.allwrapper {
	height: 100%;
	position: relative;
}

.menuediv {
	line-height: 4;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
	display: flex;
	flex-direction: row;
}

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

.shortinfo {
	border: 1px solid #dddddd;
	border-radius: 4px;
}

.show {
	position: relative;
	height: 70px;
	background-color: #fdf7f7;
}

.show>h2 {
	position: absolute;
	top: 26%;
	width: 100%;
	color: #ccc;
	text-align: center;
}

#containerinfo {
	border: 1px solid #dddddd;
	border-radius: 4px;
}

#nth2row>div {
	margin-top: 10px;
}

.buttonwrapper {
	text-align: center;
}

.buttonwrapper>button {
	border: none;
	background-color: transparent;
	color: #888 !important;
}

@media screen and (max-width: 701px) {
	.allwrapper {
		max-width: 344px;
	}
	.reviewcreate {
		flex-direction: column;
	}
	.commentcontent {
		width: auto;
	}
	.candidateimgwrapper {
		grid-template-columns: 113px 113px 113px !important;
	}
	.candidateimgarea {
		width: 113px;
		height: 140px;
		background-size: 100% 100%;
		height: 113px;
	}
	.contentimgtitlearea {
		width: 344px !important;
		height: 300px !important;
	}
	.mobilewrapper {
		display: block;
	}
	.mobileheader {
		display: block;
	}
	#navebarwrapper {
		display: none;
	}
}
</style>




<script>

var nextpage="${onedayclass.nextpage}";
var endPageFlag;
var onedayclass_name="${onedayclass.onedayclass_name}"

	window.onload = function() {	
		
	
	console.log("페이지 최초 진입후 nextpage값 : "+nextpage);	
	console.log("페이지 최초 진입후 onedayclass_name값 :"+onedayclass_name);	
	console.log("페이지 최초 진입후 endPageFlag: "+endPageFlag);		
		
		
		$(document).on("click",".nextpagebtn",()=>{	
		
			console.log("다른페이지 들려다왔을시 nextpage: "+nextpage);	
			console.log("다른페이지 들려다왔을시 onedayclass_anme: "+onedayclass_name);	
			console.log("다른페이지 들렸다왔을시 endPageFlag: "+endPageFlag);
			
			
			$.ajax({
				url:"dynamicdrawinglist.do",
				type:"POST",
				data:{"nextpage":nextpage,"onedayclass_name":onedayclass_name},
				success:(data)=>{
					
					nextpage=Number(nextpage)+Number(4);
					//console.log("초기화후 nextpage-> "+test);
					$('.update').before(data);	
					console.log("초기화후 nextpage-> "+nextpage)
					
				}
				
			})
			
			
			return false;
		})
		
		
		
	
		

		$("button[class=testbtn]").on("click", function() {
			location.href = "getpagingworkimg.do?pagebtn=2";
		})

		$("button[class=pagebtn]")
				.on(
						"click",
						function() {
							console.log($(this).text());
							$
									.ajax({
										/* contentType : "Application/json " , */
										url : "getpagingworkimg.do",
										data : {
											"pagebtn" : $(this).text()
										},
										type : "POST", //type=우리가보내는 타입,
										success : function(val) {
											console.log(val);

											let str = '';
											$
													.each(
															val,
															function(index, obj) {

																console
																		.log(val[index].worklist_img);

																str += ' <div class="col-md-3">';
																str += ' <div class="shortinfo">';
																str += " <img src='./img/"+val[index].worklist_img+"'"+">";
																str += '<p><span>작성일:'
																		+ val[index].worklist_regidate
																		+ '</span></p>';
																str += '<p><span>작성자:'
																		+ val[index].id
																		+ '</span></p>';
																str += '<p><span>소개글:'
																		+ val[index].worklist_comment
																		+ '</span></p>';
																str += '</div>';
																str += '</div>';

															});
											$("div#nth2row").html(str);

										}

									});

						})

		var mql3 = window.matchMedia("screen and (min-width: 768px)");
		var mql = window
				.matchMedia("screen and (min-width: 441px) and (max-width: 768px)");
		var mql2 = window.matchMedia("screen and (max-width: 440px)");

		mql.addListener(function(e) {
			if (e.matches) {

				$('div[class="col-md-3"]').attr('class', 'col-md-6'); //
				$('div[class="col-md-6"]').css({
					"width" : "50%"
				})

			} else {

			}
		});

		mql2.addListener(function(e) {
			if (e.matches) {

				$('div[class="col-md-6"]').css({
					"width" : "100%"
				});

			} else {
				/* 	$('div[class="col-md-6"]').css({"width":"100%"}); */
			}
		});

		mql3.addListener(function(e) {
			if (e.matches) {

				$('div[class="col-md-6"]').attr('class', 'col-md-3'); //

			} else {

			}
		});

	}
</script>
</head>
<body>
	<div class="allwrapper">

		<!-- pc 디자인 시작 -->

		<!-- 박스 음영추가 하려고 한번 더 감싸자. -->
		<div class="pcboxwrapper">
			<%@ include file="pcNave.jsp"%>
			<%@ include file="mobileNave.jsp"%>
			<div class="pcwrapper">
				<div class="contenttilewrapper">
					<h3>${onedayclass.onedayclass_name}후기</h3>
					<%-- 	<h3>${onedayclass.onedayclass_info}</h3> --%>
					<h3>더많은 후기:</h3>

					<ul id="onedayclass_name_btn">
										
						<div class="onedayclass_name_list">
							<li class="onedayclass_name" value="취미만화반">취미만화반</li>
							<li class="onedayclass_name" value="취미실사반">취미실사반</li>
							<li class="onedayclass_name" value="취미풍경화반">취미풍경화반</li>
							
						</div>
						

						<button class="onedayclass_name_btn" value="open">열기</button>
					</ul>

					<!-- <select id="onedayclass_name" name="onedayclass_name">
						<option value="취미만화반">취미만화반</option>
						<option value="취미실사반">취미실사반</option>
						<option value="취미풍경화반">취미풍경화반</option>
					</select> -->

					<script>					
					$(".onedayclass_name_btn").on("click",(e)=>{
						let clopen=$(e.target).val();
						let list=$(e.target).prev().children();					
						
						if(clopen=="open"){
							
							
							
							$(e.target).val("close")
							
							let str="";
							str+="<div class=open>"
								str+="<ul >"
							
							//list[k] 로 반복문 돌리며 추가 하려했는데 HTMLLIElement 을 문자열로 변환을 못하겟음...
							for(let k=0; k<list.length; k++){
								
								//HTMLLIElement 이다. 즉 출력시 html 태그형태로 표현됨
								console.log(list[k]);
								//str+=list[k].toString();								
							}
								
							str+='<li class="onedayclass_name" value="취미실사반">취미실사반</li>'
							str+='<li class="onedayclass_name" value="취미풍경화반">취미풍경화반</li>'							
							str+='<li class="onedayclass_name" value="취미만화반">취미만화반</li>'
							str+="</ul>"		
							str+="</div>"	
							
							$("#onedayclass_name_btn").after(str);							
							$(".onedayclass_name_btn").text("접기")
						}else{
							$(e.target).val("open")
							$(".open").remove();
							$(".onedayclass_name_btn").text("열기")
			
						}
						
					
						
					return false;	
					})
					
					$(document).on("click",".onedayclass_name",(e)=>{
						
						let choicetitle=$(e.target).text();
						$(".onedayclass_name_list").children().text(choicetitle);
						
						let onedayclass_name=choicetitle;
						   
						let nextpage=0;
						console.log("아작스 호출 직전");
						
						$(".newpageinsert").empty();
						//다른리뷰						
						$.ajax({
							url:"getOtherReview.do",
							type:"POST",
							data:{"onedayclass_name":onedayclass_name,"nextpage":nextpage},
							
							success:(data)=>{
								$(".newpageinsert").append(data);							
							}							
							
						})
						
						
						
						
						return false;
						
					})
					
					
					
					
					</script>

				</div>
<div class="newpageinsert">
				<div class="contentimgwrapper">
					<!-- ./img_onedayclass/manhwa.jpg -->
					<ul>
						<li class="contentimgtitlewrapper">
							<div class="contentimgtitlearea"></div>
						</li>

						<li class="candidateimgwrapper"><c:forEach
								items="${joinToReview}" var="candidateimg" begin="0" end="2">
								<div class="candidateimgarea"
									style="background-image: url('./img_review/${candidateimg.review_img}')">
								</div>
							</c:forEach></li>
					</ul>

				</div>

				<div class="linecut1">

					참여자들이<span style="color: #ff5862;">직접 체험하고</span>작성하는 후기입니다.
				</div>

				<div class="commentwrapper">
					<h3 class="reviewsize">
						후기:<span>${joinToReview.size()}건</span>
					</h3>

<!--버튼에서 다른 클래스 후기 보기 할시 jsp돌림 당하고 올꺼라  class="onedayclasslist" 로 한번 감쌈. -->
<div class="onedayclasslist">
					<c:forEach items="${joinToReview}" var="review">
						<div class="recentreviewwrapper"
							style="
						<c:if test="${review.review_img eq 'noimg'}">height: 150px;</c:if>">
							<!-- heigth 값을 주고 오버플로 친다음 자바스크립트로 계속 헤이트를 늘려주는 이벤트를 만들어보자. -->
							<div class="recentreview"
								style="						
					<c:if test="${review.review_img eq 'noimg'}">height: 100%;</c:if>">
								<p>${review.review_name}</p>
								<p>수업:${onedayclass.onedayclass_name}</p>
								<c:if test="${review.review_img ne 'noimg'}">
									<div class="reviewimg"
										style="background-image: url('./img_review/${review.review_img}');"></div>
								</c:if>
								<p class="reviewcreate">
									<span class="commentcontent">${review.review_comment}</span> <span
										class="createcontent" style="color: #ff5862;">작성일:
										${review.review_create_at}</span>
								</p>
							</div>
						</div>
					</c:forEach>
</div>


					<div class="update"></div>


					<div class="nextpage">
						<button class="nextpagebtn">더보기</button>
					</div>



				</div>
</div>


			</div>
		</div>
		<!-- pc 디자인 종료 -->

		<!-- 모바일 디자인 시작 -->
		<%-- 	<%@ include file="/mobileNave.jsp"%>
		<div class="mobilewrapper">
			<div class="show">
				<h2>참여자들의 갤러리</h2>
			</div>

			<c:choose>
				<c:when test="${worklist ne null}">
					<c:set var="total" value="0" />
					<div id="containerinfo" class="container ">
						<div class="row">
							<h2>갤러리</h2>
						</div>
						<div id="nth2row" class="row ">
							<c:forEach var="w" items="${worklist}" varStatus="i">

								<div class="col-md-3">
									<div class="shortinfo">
										<img src='./img/${w.worklist_img}'>
										<p>
											<span>작성일:${w.worklist_regidate}</span>
										</p>
										<p>
											<span>작성자:${w.id}</span>
										</p>
										<p>
											<span>소개글:${w.worklist_comment}</span>
										</p>
									</div>

								</div>
							</c:forEach>
						</div>
						<div class="buttonwrapper">
							<c:forEach var="i" begin="1" end="${fn:length(buttonnum)}"
								step="1" varStatus="status">

								<button class="pagebtn">${status.index}</button>
							</c:forEach>
						</div>
					</div>

				</c:when>
			</c:choose>


			<button class="testbtn">2</button>
		</div> --%>
	</div>

</body>
</html>