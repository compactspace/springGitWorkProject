<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<!-- 제이쿼리 달력  -->
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<!-- 달력 이벤트가 강제된게 많아 다운받운후 js폴더에 DatPickker-jquery-ui.js 파일을 집어 넣었다  -->
<!--DatPickker-jquery-ui.js 파일의 8113 라인 코드를 주석처리함 다른곳 클릭하면 달력 종료되는 스크립트를!!  -->
<script src="./js/DatPickker-jquery-ui.js"></script>
<!-- 제이쿼리 달력  종료-->
</head>
<script>
$(function() {

	$("#onedayclass_name").change(function() {
		
		console.log("값이 변하면 떠야하는디???")
		console.log($(this).val());

		$.ajax({
			url : "selectOneDayClass.do",
			data : {
				onedayclass_name : $(this).val()
			},
			method : "POST",
			success : function(val) {
				console.log(val);

				$.each(val, function(index, obj) {
					console.log("클래스정보 "+obj.onedayclass_info);
					console.log("클래스 이름"+obj.onedayclass_name);
					console.log("클래스 비용 " +obj.onedayclass_price);
					console.log("클래스 대표이미지 "+obj.reserve_img);
					console.log("클래스 번호"+obj.onedayclass_num);
					let names = obj.onedayclass_name
					$(".reserve_img").attr("src", obj.reserve_img)
					$(".onedayclass_name").text(names);
					$(".onedayclass_info").text(obj.onedayclass_info);
					$(".onedayclass_num").val(obj.onedayclass_num)			
				

				});

			}

		})

		/* if($(this).val()=="취미만화반"){
			console.log("ddd");
		$(".reserve_img").attr("src",'./img_onedayclass/manhwa.jpg');
		}                    	 */

	})	 
					 
					
				$(".reservebtn2").on( "click",
					function() {
				
				let count=$(".restcount").text().split("자리남음");
				/* console.log(count[0])
				console.log(count[0]=="0")
				console.log(count[0]==0) */					
				user_code = $("#user_code").val(),
			    openday=$("#opendayinsert").val(),
				onedayclass_num=$("#onedayclass_num").val()
									
				console.log("유저코드: "+user_code+"개설강의 날짜: "+openday+"클래스번호: "+onedayclass_num);					
				if(	count[0]==0){
					alert("마감된 날짜입니다. 날짜를 다시 선택해주세요")
				}else{
			 		$.ajax({
						url : "checkreserveinfo.do",
						data : {
							//백단
							user_code : $("#user_code").val(),
						    openday:$("#opendayinsert").val(),
							onedayclass_num: $("#onedayclass_num").val()
							
						},
						method : "POST",
						success : function(val) {
							
							console.log("중복확인후 값");
							console.log(val);
					
							if (val == "true") {
								
								reserve_img=$("#reserve_img").val();
								onedayclass_name=$("#onedayclass_name").val();
								onedayclass_info=$("#onedayclass_info").val();
								onedayclass_price=$("#onedayclass_price").val();
								rest=count[0];									
		console.log("예약이미지: "+reserve_img+"클래스이름: "+onedayclass_name+"클래스정보소개: "+onedayclass_info+"가격: "+onedayclass_price+"남은자리수: "+rest);

		
window.location.replace("/finall/onedayclasspay.jsp?onedayclass_num="+onedayclass_num+"&openday="+openday
	+"&reserve_img="+reserve_img
	+"&onedayclass_name="+onedayclass_name
	+"&onedayclass_info="+onedayclass_info
	+"&onedayclass_price="+onedayclass_price
	+"&rest="+rest
	)							
	
							} else if(val == "false") {
								alert("죄송합니다. 저희 원데이 클래스는 소규모로, 같은시간에 모든 수업이 일괄적으로 진행되기에 동일한 날짜에 다른 수업을 예약할 수 없습니다.");
							} else if(val == "needjoin"){
								alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
								window.location.href="/finall2/login.jsp";
								
							}

						}

					}) 
				}
				})//클릭함수종료			
					

				//<input id="datepicker">을 datepicker로 선언해야 달련 버튼이 자동으로 생긴다.
				//클릭시 그냥 자동으로 달력이 뜸
	$.datepicker
			.setDefaults({
				dateFormat : 'yy-mm-dd' //Input Display Format 변경= 달력선택시 인풋창에 뜬느 값 형식을 지정
				,
				showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
				,
				showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
				,
				changeYear : true //콤보박스에서 년 선택 가능
				,
				changeMonth : true //콤보박스에서 월 선택 가능                
				,
				showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
				,
			/* buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로 
				, */
			/* 	buttonImageOnly : true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
				, */
				buttonText : "날짜선택하기" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
				,
				yearSuffix : "년" //달력의 년도 부분 뒤에 붙는 텍스트
				,
				monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
						'9', '10', '11', '12' ] //달력의 월 부분 텍스트
				,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
						'8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip 텍스트
				,
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 부분 텍스트
				,
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일',
						'토요일' ] //달력의 요일 부분 Tooltip 텍스트
				,
				minDate : "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
				,
				maxDate : "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
			});

	

	
	
	
	//선택자명.datepicker 해야 달력 버튼이 생기는듯??
	$("#openday").datepicker({
		// beforeShowDay 는 datepicker 제공기능이자 키워드 인듯
		// before 는 사용자가 만드는 함수이고, 대충 원하는 요일 또는 일자 등 함수인듯
		beforeShowDay : before
		});

	//주말만 예약받자.
	function before(date) {
		var day = date.getDay();
		// 달력에 출력해줄 것을 배열로 리턴하는듯
		return [ (day != 1 && day != 2 && day != 3 && day != 4 && day != 5) ];
	}

	//From의 초기값을 오늘 날짜로 설정
	$('#reserve').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)



	$(".ui-datepicker-trigger").on("click",(e)=>{
		//제거해야 달력 날짜 선택시 새로고침안됨
		
		$(".ui-state-default").removeAttr("href");			
		$(".ui-datepicker-week-end").removeAttr("href");
		$(".ui-datepicker-week-end").removeAttr("data-event");
		$(".ui-datepicker-calendar")
		
		
		console.log($(".ui-widget-content"))			
		//ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all
		
		
		//제이쿼리 자체로 after 형식으로 들어가 태그형태로 재삽입하자.
		let uiDatepickerDiv=$("#ui-datepicker-div");
		 $("#ui-datepicker-div").removeClass("ui-widget-content")
			$("#ui-datepicker-div").removeClass("ui-helper-clearfix")		
			$("#ui-datepicker-div").removeClass("ui-corner-all")
			
			
			
		/*$("#ui-datepicker-div").remove(); */
		
		
		
		//제이쿼리 자체로 after 형식으로 들어가 태그형태로 재삽입하자.
		$("#insertDatePicker").html(uiDatepickerDiv);
		
		
		
		    
	})
	
	

	
	
});


	$(".ui-datepicker-trigger").trigger("click");
	
	 $(".ui-datepicker-trigger").hide(); 
	
$(".ui-datepicker-trigger").on("click",(e)=>{
	//제거해야 달력 날짜 선택시 새로고침안됨
	
	alert("왓??")
	
	$(".ui-state-default").removeAttr("href");			
	$(".ui-datepicker-week-end").removeAttr("href");
	$(".ui-datepicker-week-end").removeAttr("data-event");
	$(".ui-datepicker-calendar")
	
	
	console.log($(".ui-widget-content"))			
	//ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all
	
	
	//제이쿼리 자체로 after 형식으로 들어가 태그형태로 재삽입하자.
	let uiDatepickerDiv=$("#ui-datepicker-div");
	 $("#ui-datepicker-div").removeClass("ui-widget-content")
		$("#ui-datepicker-div").removeClass("ui-helper-clearfix")		
		$("#ui-datepicker-div").removeClass("ui-corner-all")
		
		
		
	/*$("#ui-datepicker-div").remove(); */
	
	
	
	//제이쿼리 자체로 after 형식으로 들어가 태그형태로 재삽입하자.
	$("#insertDatePicker").html(uiDatepickerDiv);
	
	
	
	    
})
</script>



<div class="contentimgwrapper">
	<!-- ./img_onedayclass/manhwa.jpg -->
	<ul>
		<li class="contentimgtitlewrapper">
			<div class="contentimgtitlearea"
				style="<c:choose>
			<c:when test="${onedayclass.onedayclass_name eq '취미만화반'}">
		background-image:url('./img_onedayclass/manhwa.jpg')
			</c:when>
			<c:when test="${onedayclass.onedayclass_name eq '취미실사반'}">
		background-image:url('./img_onedayclass/drawing.jpg')
			</c:when>	
			<c:when test="${onedayclass.onedayclass_name eq '취미풍경화반'}">
		background-image:url('./img_onedayclass/nature.jpg')
			</c:when>						
			</c:choose>">
			</div>

		</li>
		
${candidateimg.review_img}

		<li class="candidateimgwrapper"><c:forEach
				items="${joinToReview}" var="candidateimg" begin="0" end="2">
				<div class="candidateimgarea"
					style="background-image: url('./img_review/${candidateimg.review_img}')">
				</div>
			</c:forEach></li>
	</ul>

</div>


<!-- 달력 끼워 넣기 시작 -->
<div id="calendarwrapper">
	<div class="infowraper">
		<div id="iconrow" class="row ">
			<div class="detail">
				<img id="infoicon1" class="infoicon" src="./img_infoicon/check.png" />
				<span>서울시</span>
			</div>

			<div class="detail">
				<img class="infoicon" src='./img_infoicon/time.png' /> <span>이용시간
					2시간</span>
			</div>


			<div class="detail">
				<img class="infoicon" src='./img_infoicon/warnning.png'> <span>주차불가</span>
			</div>

			<div class="detail">
				<img class="infoicon" src='./img_infoicon/headcount.png'> <span>최대이용인원
					4명</span>
			</div>

			<input type="hidden" id="check" name="check">
			<!-- user_code 로 다 작동하면 userId는 지워라. -->
			<input type="hidden" id="id" name="id" value="${userId}"> <input
				type="hidden" id="user_code" " name="user_code" value="${user_code}">


		</div>
		<div id="insertDatePicker"></div>

		<div class="dayandrest">
			<div class="showrest">
				<span class="restcount">달력날짜를클릭해주세요</span> <input type="text"
					id="openday" class="reserve_day" name="openday"
					style="display: none;">
			</div>
		</div>

		<div class="blackhole">
			<input type="hidden" id="onedayclass_num" name="onedayclass_num"
				value="${onedayclass.onedayclass_num}"> <input type="hidden"
				id="opendayinsert" class="opendayinsert" name="openday" value>
			<input type="hidden" id="user_code" name="user_code"
				value="${user_code}"> <input type="hidden" id="reserve_img"
				name="reserve_img" value="${onedayclass.reserve_img}"> <input
				type="hidden" id="onedayclass_name" name="onedayclass_name"
				value="${onedayclass.onedayclass_name}"> <input
				type="hidden" id="onedayclass_info" name="onedayclass_info"
				value="${onedayclass.onedayclass_info}"> <input
				type="hidden" id="onedayclass_price" name="onedayclass_price"
				value="${onedayclass.onedayclass_price}"> <input
				type="hidden" id="rest" name="rest"
				value="${onedayclass.onedayclass_price}">
		</div>
	</div>





</div>
<!-- 달력 끼워 넣기 종료 -->
<div class="linecut1">

	참여자들이<span style="color: #ff5862;">직접 체험하고</span>작성하는 후기입니다.
</div>

<div class="commentwrapper">
	<h3 class="reviewsize">
		후기:<span>${joinToReview.size()}건</span>
	</h3>

	<c:choose>

		<c:when test="${isEmpty eq 'isEmpty' }">
			<h1>작성된 후기 가 없습니다.</h1>
		</c:when>
		<c:otherwise>


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
		</c:otherwise>

	</c:choose>
	<div class="update"></div>

	<div class="nextpage">
		<button class="nextpagebtn">더보기</button>
	</div>
</div>

<script>
	var endPageFlag = "${onedayclass.endPageFlag}"
	var isEmpty = "${isEmpty}";
	console.log(endPageFlag == "true")
	console.log(isEmpty)
	if (endPageFlag == "true" || isEmpty == "isEmpty") {
		$(".nextpagebtn").hide();
	}

	var nextpage = "${onedayclass.nextpage}";
	var onedayclass_name = "${onedayclass.onedayclass_name}"
</script>




