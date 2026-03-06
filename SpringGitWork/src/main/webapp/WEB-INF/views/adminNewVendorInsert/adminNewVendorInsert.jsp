<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 거래처 등록</title>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.8/jquery.inputmask.min.js"></script>

<style>
html, body {height:100%; margin:0; font-family:'Roboto', sans-serif;}
#pageWrapper{display:flex; height:100vh;}
#sidebar{width:240px; border-right:1px solid #e0e0e0; overflow-y:auto;}
#mainContent{flex:1; padding:24px; overflow-y:auto;}
#contentHeader{padding:20px 24px; background-color:#f5f7fa; border-left:6px solid #4a90e2; border-radius:4px; box-shadow:0 2px 4px rgba(0,0,0,0.08); margin-bottom:20px;}
#contentHeader h1{margin:0; font-size:1.8em; font-weight:700; color:#333;}
#contentHeader .header-subtitle{margin:6px 0 0 0; font-size:0.95em; color:#666;}
#contentBody{background:#fff; padding:20px; border-radius:8px; min-height:400px; box-shadow:0 2px 6px rgba(0,0,0,0.05);}
.select-box-wrapper{margin-bottom:15px; display:flex; flex-direction:column;}
.select-label{font-weight:600; margin-bottom:6px;}
.styled-input, .styled-select{padding:8px 10px; border:1px solid #ccc; border-radius:6px; font-size:14px;}
.btn-blue{background-color:#4a90e2; color:#fff; border:none; padding:8px 14px; border-radius:6px; cursor:pointer; font-size:14px;}
</style>

<script>
const contextPath="${pageContext.request.contextPath}";

$(document).ready(function(){
	const token = $("meta[name='_csrf']").attr("content");
	const header = $("meta[name='_csrf_header']").attr("content");
	$.ajaxSetup({beforeSend: function(xhr){xhr.setRequestHeader(header, token);}});

	// 사업자 번호 마스크
	$("#business_number").inputmask("999-99-99999");

	// 폼 제출
	$("#vendorForm").on("submit", function(e){
		let useAJAX = true; // AJAX 사용 여부
		if(typeof $ !== "undefined"){ // jQuery 정상 로드 확인
			e.preventDefault(); // JS로 제어 가능한 경우 AJAX 사용
		} else {
			useAJAX = false; // JS 에러나 비활성화면 기본 폼 제출
		}

		if(useAJAX){
			// 유효성 체크
			let name = $("#name").val().trim();
			let busNo = $("#business_number").val().trim();
			let settlement = $("#settlement_type").val();
			let delivery = $("#delivery_type").val();

			if(!name){ alert("거래처명을 입력하세요."); $("#name").focus(); return; }
			if(!busNo || !/^\d{3}-\d{2}-\d{5}$/.test(busNo)){ 
				alert("사업자 번호를 올바르게 입력하세요."); 
				$("#business_number").focus(); 
				return; 
			}
			if(!settlement){ alert("정산 유형을 선택하세요."); return; }
			if(!delivery){ alert("배송 유형을 선택하세요."); return; }

			// VO 형태 JSON 만들기
		    let formDataJSON = {
		        name: name,
		        businessNumber: busNo.replace(/-/g, ""),  // 하이픈 제거
		        settlementType: settlement,
		        deliveryType: delivery,
		        status: "ACTIVE"   // 기본값
		    };
			

		    console.log(formDataJSON);
		$.ajax({
				url: contextPath + "/api/admin/new-vendor-insert",
				type: "POST",
				 contentType: "application/json",  // <-- 중요!
				    data: JSON.stringify(formDataJSON),  // <-- 객체 → JSON 문자열
				success: function(response){
					if(response.success){
						alert("거래처 등록 완료!");
						$("#vendorForm")[0].reset();
					}else{
						alert("등록 실패: " + response.message);
					}
				},
				 error: function(xhr, textStatus, errorThrown) {
				        console.error("AJAX 에러 발생!");
				        console.error("HTTP 상태:", xhr.status);                     // 상태 코드
				        console.error("status 텍스트:", textStatus);                // 예: "error"
				        console.error("에러 메시지:", errorThrown);                  // 예: "Bad Request"
				        console.error("서버 응답 내용:", xhr.responseText);         // 서버가 보낸 에러 본문(있으면)
				        alert("서버 오류 발생 — 콘솔 로그를 확인하세요.");
				    }
			});
		}
	});
});
</script>

</head>
<body>
<div id="pageWrapper">
	<div id="sidebar">
		<%@ include file="../compoents/adminVerticalBar/adminVerticalBar.jsp"%>
	</div>
	<div id="mainContent">
		<div id="contentHeader">
			<h1>신규 거래처 등록</h1>
			<div class="header-subtitle">물건을 대주는 공급업체의 정보를 입력합니다.</div>
		</div>
		<div id="contentBody">
			<form id="vendorForm" method="POST" action="${contextPath}/admin/add-vendor">
				<div class="select-box-wrapper">
					<label class="select-label" for="name">거래처명</label>
					<input type="text" id="name" name="name" class="styled-input" placeholder="거래처명을 입력하세요" required>
				</div>
				<div class="select-box-wrapper">
					<label class="select-label" for="business_number">사업자 번호</label>
					<input type="text" id="business_number" name="business_number" class="styled-input" placeholder="123-45-67890" required>
				</div>
				<div class="select-box-wrapper">
					<label class="select-label" for="settlement_type">정산 유형</label>
					<select id="settlement_type" name="settlement_type" class="styled-select" required>
						<option value="">선택</option>
						<option value="MONTHLY">월별</option>
						<option value="IMMEDIATE">즉시</option>
					</select>
				</div>
				<div class="select-box-wrapper">
					<label class="select-label" for="delivery_type">배송 유형</label>
					<select id="delivery_type" name="delivery_type" class="styled-select" required>
						<option value="">선택</option>
						<option value="SAIPH">SAIPH</option>
						<option value="DROPSHIP">드롭쉽</option>
					</select>
				</div>
				<div class="select-box-wrapper">
					<label class="select-label" for="status">상태</label>
					<select id="status" name="status" class="styled-select">
						<option value="ACTIVE" selected>활성</option>
						<option value="INACTIVE">비활성</option>
					</select>
				</div>
				<div class="select-box-wrapper" style="text-align:right;">
					<button type="submit" class="btn-blue">거래처 등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>
