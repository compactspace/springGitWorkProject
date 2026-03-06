<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<sec:csrfMetaTags />
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Orbit&family=Sunflower:wght@300&display=swap"
	rel="stylesheet" />

<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" />

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- jQuery UI -->
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>


<!-- 제이쿼리 달력  종료-->
<script>
    var contextPath = '<%=request.getContextPath()%>';
</script>

<style>
/*뒤로가기 */
.back {
	width: 100%;
	position: absolute;
	display: flex;
	justify-content: space-between;
}

.backarea {
	background-image:
		url('${pageContext.request.contextPath}/resources/img_icon/backicon.png');
	width: 50px;
	height: 50px;
	background-size: 100% 100%;
}

.otherclassarea {
	
}

#onedayclass_name_btn {
	margin-right: 5px;
	margin-top: 12px;
}

#onedayclass_name_btn {
	justify-content: space-between;
	width: 200px;
	border-radius: 5px 5px 5px 5px;
	/* border: 2px solid #ff5862; */
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
	width: 100px;
	text-align: right;
	background: transparent;
	border: none;
	color: #6A82EC;
	font-size: 15px;
	font-weight: 900;
	line-height: 5px;
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
/*pcNave의 속성을 재정의 페이지 마다 색깔이나 배경이다르니 pcNave.jsp 의 태그 css를 종료  */
.pcboxwrapper {
	position: relative;
	box-shadow: 0 0 17px 3px rgb(171 171 171/ 50%);
}

#onedayclass_name_btn {
	height: 22px;
	overflow: hidden;
	display: flex;
	color: #6A82EC;
	font-size: 15px;
	font-weight: 900;
}

.contentimgtitlewrapper {
	margin: 10px 0px;
}

.contentimgtitlearea {
	width: 100%;
	height: 480px;
	background-size: 100% 100%;
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

#calendarwrapper {
	
}

.reservebtn-wrapper {
	padding: 10px 0;
	margin: 10px 15px 0; /* 좌우 여백 포함 */
	display: flex;
	align-items: center;
	justify-content: center;
	background: #FFF0F1; /* 연한 붉은 배경 */
	border-radius: 5px;
	font-size: 13px;
	line-height: 15px;
	font-weight: 700;
	color: #ff5862; /* 강조색 - 기존 border 색 참고 */
	cursor: pointer;
	user-select: none;
	transition: background 0.2s eas
}

#iconrow {
	height: 150px;
	display: grid;
	grid-template-rows: 30px 30px 30px 30px;
}

.detail {
	margin: 5px 0px;
}

.detail img {
	width: 20px;
	height: 20px;
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

.showrest span {
	background: #ff5862;
	color: white;
	font-weight: 600;
	border-radius: 5px;
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
</style>

<script>

$(document).ready(function() {
	  const token = $("meta[name='_csrf']").attr("content");
	  const header = $("meta[name='_csrf_header']").attr("content");

	  $.ajaxSetup({
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader(header, token);
	    }
	  });
});

    var nextpage = "${nextpage}";
    var isEmpty="${isEmpty}"
    var onedayclass_name = "${onedayclass.onedayclass_name}";
    var selectedDate=null; 
    var choiceOpenDay = null;
    var reserveRest_id=null
    var onedayclass_num = "${onedayclass.onedayclass_num}";
    var onedayclass_price = "${onedayclass.onedayclass_price}";
    
    
    /* 하위페이지 전용 변수 시작  */
    var isEnd=null;
    var todaySoldOut=null;
	var endPageFlag = null
     /* 하위페이지 전용 변수 종료 */
    
    // 페이지 로드 시 가능한 날짜 조각을 불러오는 AJAX 호출
    window.onload = function () {	
		
		
		console.log("isEmpty: "+isEmpty)
		if(isEmpty==="true"){
			$(".commentwrapper").hide();
			$(".first-story-wraaper").show();
		}
		
		
        $.ajax({
            url: contextPath + "/guest/getpossibleDateFragment",
            type: "GET",
            data: {
                // 필요한 파라미터가 있다면 여기에 작성
            	onedayclass_num:onedayclass_num,
            	onedayclass_name:onedayclass_name
            },
            success: function (response) {
                $('#possibleDate').html(response);
                
                // ② 여기서부터 안전하게 접근 가능
               // 삽입된 조각에서 soldOut 여부 읽기
    const soldOutHeader = document.querySelector('h3[data-soldout="true"]');
    todaySoldOut = !!soldOutHeader;

   

    // 이후 로직에서 해당 값 기반으로 분기 처리
    if (todaySoldOut) {
        $('.reservebtn-wrapper').hide();
    } else {
        $('.reservebtn-wrapper').show();
    }
            },
            error: function (xhr, status, error) {
                console.error("AJAX 오류:", status, error);
            }
        });
    };

    $(function () {
        // 클래스 이름 변경 시 상세 정보 불러오기
        $("#onedayclass_name").change(function () {
            var selectedName = $(this).val();
           // console.log("선택된 클래스 이름:", selectedName);

            $.ajax({
                url: "selectOneDayClass.do",
                method: "POST",
                data: {
                    onedayclass_name: selectedName
                },
                success: function (val) {
                    console.log("클래스 정보 응답:", val);

                    $.each(val, function (index, obj) {
                      /*   console.log("클래스정보:", obj.onedayclass_info);
                        console.log("클래스 이름:", obj.onedayclass_name);
                        console.log("클래스 비용:", obj.onedayclass_price);
                        console.log("클래스 대표이미지:", obj.reserve_img);
                        console.log("클래스 번호:", obj.onedayclass_num); */

                        $(".reserve_img").attr("src", obj.reserve_img);
                        $(".onedayclass_name").text(obj.onedayclass_name);
                        $(".onedayclass_info").text(obj.onedayclass_info);
                        $(".onedayclass_num").val(obj.onedayclass_num);
                    });
                },
                error: function (xhr, status, error) {
                    console.error("클래스 정보 요청 실패:", error);
                }
            });
        });

        
        
        
  
   
        
        // 리뷰 더 불러오기 (페이지네이션)
        $(document).on("click", ".nextpagebtn", function (e) {
            e.preventDefault();

            $.ajax({
                url: contextPath + "/api/guest/get-motre-reviews",
                type: "POST",
                data: {
                    nextpage: nextpage,
                    onedayclass_name: onedayclass_name
                },
                success: function (data) {
                   

                    nextpage = Number(nextpage) + 4;
                    $('.update').before(data);                    
                    const endPageEl = $('div[data-endpageflag]');
                    endPageFlag=endPageEl.data('endpageflag'); 
                    
                    
                    
                    
                    const isEndEl= $('#check-end');
                    
                   // console.log(isEndEl)
                    
                    
                    isEnd=isEndEl.data('isEnd'); 
                    //console.log("isEnd: "+isEnd);          
                    
                    
                
                    
                    if(isEnd){
                    	
                    	$("#getmorebtn").hide();
                    }
                    
                    
                    
                    if (endPageFlag === true) {
                        $(".nextpagebtn").hide();
                    }        

                    
            
                },
                error: function (xhr, status, error) {
                    console.error("리뷰 더보기 오류:", error);
                }
            });
        });

        // 예약 버튼 클릭 시 로그인 및 날짜 선택 확인
       

        // 날짜 선택 시 값 저장
        $(document).on("click", ".date-item", function () {        	
        //	console.log('이미 예약한 날짜이니: '+$(this).data("reserved"));
        	
        	if ($(this).data("reserved") === true) {
        	   // console.log("예약된 항목이므로 클릭 처리 안 함.");
        	    return;
        	}
        	
        	
        	
        	const selected_Date=$(this).find("input[name='selectedDate']").val();
            const 한글용데이트 = $(this).find("input[name='reservationDate']").val();
            const selectedId = $(this).find("input[name='id']").val();
            selectedDate=selected_Date;
            choiceOpenDay = 한글용데이트;
            reserveRest_id = selectedId;
            
           /*  console.log("선택한 백엔드파라미터용 개강 날짜:", selectedDate);
            console.log("선택한 프론트 유아이용  개강 날짜:", choiceOpenDay);
            console.log("선택한 날짜 ID:", reserveRest_id); */
        });

    });     
  
    const loadPaymentPage = () => {
        const form = $('<form>', {
            method: 'POST',
            action: contextPath + '/users/onedayclass-payment'
        });

        const params = {
            onedayclass_num: onedayclass_num,
            choiceOpenDay: choiceOpenDay,
            onedayclass_name: onedayclass_name,
            reserveRest_id: reserveRest_id,
            onedayclass_price: onedayclass_price,
            selectedDate: selectedDate
        };

        // hidden input으로 폼에 추가
        $.each(params, (key, value) => {
            form.append($('<input>', { type: 'hidden', name: key, value: value }));
        });

        
        // ✅ CSRF 토큰 hidden input으로 추가 (form submit용)
        const token = $("meta[name='_csrf']").attr("content");
        form.append($('<input>', { type: 'hidden', name: '_csrf', value: token }));
        // 폼을 body에 추가 후 submit
        $('body').append(form);
        form.submit();
    };
    
    
    
    
    
    
   /*  const loadPaymentPage = () => {
        $.ajax({
            url: contextPath + "/users/onedayclass-payment",
            type: "POST",
            data: { onedayclass_num: onedayclass_num ,choiceOpenDay:choiceOpenDay,onedayclass_name:onedayclass_name,reserveRest_id:reserveRest_id,selectedDate:selectedDate},
            success: function(responseHtml) {
            	
                $(".payment-wrapper").html(responseHtml);
                // 현재 상태가 payment가 아니면 pushState 실행
                console.log(' history.state.page: '+ history.state.page)
                if (!history.state || history.state.page !== "payment") {
                    history.pushState({ page: "payment" }, "", contextPath + "/users/onedayclass-payment");
                }
            },
            error: function(err) {
            	console.log(err);
            }
        });
    } */
    
    
    
 // 페이지 로딩 시 이벤트 바인딩
    $(document).ready(function() {
    	 history.replaceState({ page: "initial" }, "", window.location.href);
        // 예: 버튼 클릭 시 결제 페이지 로드
        $(".reservebtn-wrapper").click(function() {
        	
        	if(todaySoldOut){
        		return;
        	}
        	
        	
            if (!isAuthenticated) {
                alert('로그인이 필요한 서비스입니다.');
                return;
            }

            if (!choiceOpenDay) {
                alert('날짜를 선택해주세요.');
                return;
            }
            
     
            //스섹
           let reserveCart = [
        	   {
        		    productName: onedayclass_name,
        		    productPrice: onedayclass_price,
        		    quantity: 1,
        		    selected: true
        		}
           ];
            
            
            
            
            localStorage.setItem("reserveCart", JSON.stringify(reserveCart));

            // pcbox 숨기고 결제창 보이기
            $(".pcboxwrapper").hide();
            $(".payment-wrapper").show();
            loadPaymentPage();
        });
        const defaultUrl = window.location.href;         
    
        // popstate 이벤트 처리 (뒤로가기, 앞으로가기 시)
        window.onpopstate = function(event) {
        	/*    console.log("onpopstate:", event.state); */
            if (event.state && event.state.page === "payment") {
                // 결제 페이지 복원
           /*       console.log("결제페이지:", event.state); */  
          		 alert("정보 보호를 위해 기존 입렵 하셨던 \n 카드 정보는 다시 입력하셔야합니다.")
           		 $(".payment-wrapper").html("");
           		loadPaymentPage();    
           	  $(".pcboxwrapper").hide();
              $(".payment-wrapper").show();
            } else if(event.state.page === "initial") {
                // 초기 화면 복원
           /*      console.log("달력페이지:", event.state); */
           		 $(".payment-wrapper").html("");
                $(".pcboxwrapper").show();
                $(".payment-wrapper").hide();
            }
        };
    }); 
</script>

</head>
<body>


	<div class="allwrapper">
		<!-- pc 디자인 시작 -->

		<div class="payment-wrapper" style='display: none'></div>


		<div class="pcboxwrapper">

			<div class="back">

				<a href="${pageContext.request.contextPath}/"><div
						class="backarea"></div></a>

			</div>

			<div class="pcwrapper">
				<div class="newpageinsert">
					<div class="contentimgwrapper">

						<ul>
							<li class="contentimgtitlewrapper">
								<div class="contentimgtitlearea"
									style="background-image:
		url('${pageContext.request.contextPath}/resources/${onedayclass.reserve_img}');"></div>
							</li>
							<li class="candidateimgwrapper"><c:forEach
									items="${candiImageList}" var="candidateimg" begin="0" end="2">
									<div class="candidateimgarea"
										style="background-image: url('${pageContext.request.contextPath}/resources/${candidateimg}')">
									</div>
								</c:forEach></li>
						</ul>
					</div>

					<!-- Section2_3 시작 -->
					<div id="calendarwrapper">
						<div class="infowraper">
							<div id="iconrow" class="row ">
								<div class="detail">
									<img id="infoicon1" class="infoicon"
										src="${pageContext.request.contextPath}/resources/img_infoicon/check.png" />
									<span>주소 ${onedayclass.address}</span>
								</div>
								<div class="detail">
									<img class="infoicon"
										src='${pageContext.request.contextPath}/resources/img_infoicon/time.png' />
									<span>이용시간 ${onedayclass.playtime}</span>
								</div>

								<div class="detail">
									<img class="infoicon"
										src='${pageContext.request.contextPath}/resources/img_infoicon/warnning.png'>
									<span>주차 ${onedayclass.park}</span>
								</div>

								<div class="detail">
									<img class="infoicon"
										src='${pageContext.request.contextPath}/resources/img_infoicon/headcount.png'>
									<span>최대이용인원 ${onedayclass.maximum_guests}</span>
								</div>

								<input type="hidden" id="check" name="check">
								<!-- user_code 로 다 작동하면 userId는 지워라. -->
								<input type="hidden" id="id" name="id" value="${userId}">
								<input type="hidden" id="user_code" name="user_code"
									value="${user_code}">


							</div>




							<!-- 예약날짜  -->
							<div id="possibleDate"></div>

						</div>
					</div>
					<!-- Section2_3 종료 -->

					<!-- 인증 여부를 JS로 안전하게 넘기기 -->
					<script>
      var isAuthenticated = false;
    </script>

					<sec:authorize access="isAuthenticated()">
						<script>
        isAuthenticated = true;
      </script>
					</sec:authorize>
					<div class="reservebtn-wrapper" style='display: none;'>예약하기</div>
					<div class="linecut1">

						참여자들이<span style="color: #ff5862;">직접 체험하고</span>작성하는 후기입니다.
					</div>
					<div class="first-story-wraaper"
						style="display: none; text-align: center; padding: 30px 20px; color: #555; font-size: 1rem; margin-top: 20px;">

						<strong
							style="display: block; font-size: 1.1rem; color: #333; margin-bottom: 8px;">
							아직 등록된 후기가 없어요. </strong> 가장 먼저 소중한 후기를 남겨주세요 ✨
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
												style="background-image: url('${pageContext.request.contextPath}/resources/img_review/${review.review_img}');"></div>
										</c:if>
										<p class="reviewcreate">
											<span class="commentcontent">${review.review_comment}</span>
											<span class="createcontent" style="color: #ff5862;">작성일:
												${review.review_create_at}</span>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>

						<div class="update"></div>


						<div class="nextpage" id="getmorebtn">
							<button class="nextpagebtn">더보기</button>
						</div>



					</div>
				</div>


			</div>
		</div>

	</div>

</body>
</html>