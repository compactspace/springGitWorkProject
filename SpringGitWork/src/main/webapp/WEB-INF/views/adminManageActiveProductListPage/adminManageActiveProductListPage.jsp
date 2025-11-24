<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>내 정보 확인</title>

<style>
html, body {
	height: 100%;
	margin: 0;
	font-family: 'Roboto', sans-serif;
}

#pageWrapper {
	display: flex;
	height: 100vh;
}

#sidebar {
	width: 240px;
	border-right: 1px solid #e0e0e0;
	overflow-y: auto;
}

#mainContent {
	flex: 1;
	padding: 24px;
	overflow-y: auto;
}

#contentHeader {
	padding: 20px 24px;
	background-color: #f5f7fa;
	border-left: 6px solid #4a90e2;
	border-radius: 4px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
	margin-bottom: 20px;
}

#contentHeader h1 {
	margin: 0;
	font-size: 1.8em;
	font-weight: 700;
	color: #333;
}

#contentHeader .header-subtitle {
	margin: 6px 0 0 0;
	font-size: 0.95em;
	color: #666;
}

#contentBody {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	min-height: 400px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}


/* 셀렉트 시작  */
/* 셀렉트 박스 wrapper */
.select-box-wrapper {
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 6px;      /* 약간 줄임 */
    padding: 10px 12px;      /* 여백 줄임 */
    max-width: 280px;        /* 조금 좁게 */
    box-shadow: 0 2px 6px rgba(0,0,0,0.06); /* 그림자 살짝 낮춤 */
    margin-bottom: 20px;
}

/* 라벨 */
.select-label {
    display: block;
    margin-bottom: 6px;
    font-weight: 500;
    font-size: 0.9em;
    color: #333;
}

/* 셀렉트 박스 */
.styled-select {
    width: 100%;
    padding: 6px 12px;      /* 높이 줄임 */
    border-radius: 4px;     /* 조금 줄임 */
    border: 1px solid #ccc;
    font-size: 0.95em;      /* 글씨 조금 작게 */
    font-family: 'Roboto', sans-serif;
    background-color: #fff;
    appearance: none;
    cursor: pointer;
    transition: border-color 0.2s, box-shadow 0.2s;
    background-image: url("data:image/svg+xml;utf8,<svg fill='gray' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
    background-repeat: no-repeat;
    background-position: right 10px center;
    background-size: 12px;
}

.styled-select:hover {
    border-color: #4a90e2;
}

.styled-select:focus {
    outline: none;
    border-color: #4a90e2;
    box-shadow: 0 0 4px rgba(74, 144, 226, 0.4);
}
/* 셀렉트 종료  */




/* 테이블 컨테이너 시작*/
.product-table {
    display: flex;
    flex-direction: column;
    border: 1px solid #ccc;
    border-radius: 6px;
    overflow: hidden;
    margin-top: 20px;
}


.product-table-header {
    display: flex;
    background-color: #f5f5f5;
    font-weight: bold;
    border-bottom: 2px solid #333;
    padding: 10px 0;
}


.product-table-row {
    display: flex;
    border-bottom: 1px solid #ccc;
    padding: 8px 0;
}


.product-table-row:last-child {
    border-bottom: none;
}


.product-col {
    padding: 0 10px;
    display: flex;
    align-items: center;
}


.col-id { flex: 1; }
.col-name { flex: 2; }
.col-price { flex: 1; }
.col-status { flex: 1; }
/* 테이블 컨테이너 종료*/



/*모달 시작*/
.modal { position: fixed; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.5); display:flex; justify-content:center; align-items:center; }
.modal-content { background:#fff; padding:20px; border-radius:5px; min-width:300px; }
.modal-footer { text-align:right; margin-top:15px; }
/*모달 종료*/


</style>
<script>
	const contextPath = "${pageContext.request.contextPath}";
	var copyActiveProductList = {};

	window.onload = function() {
		const token = $("meta[name='_csrf']").attr("content");
		const header = $("meta[name='_csrf_header']").attr("content");

		$.ajaxSetup({
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			}
		});
		
		changeProductGroup();
		// select change 이벤트
	    const selectElem = document.getElementById("productGroupSelect");
	    selectElem.addEventListener("change", changeProductGroup);

	}

	
	
	
	
	function changeProductGroup() {
		
		
	    // select 요소 가져오기
	    const selectElem = document.getElementById("productGroupSelect"); 
	    
	    
	    
	    // 선택된 값 (groupId)
	    const selectedGroupId = selectElem.value;
	    const groupIdToSend = selectedGroupId || 1; // 선택값 없으면 1
	    
	    // 동적으로 키 생성
	  
	    let isCashed=JSON.parse(localStorage.getItem("copyActiveProductList") || null);
	    
	    
	    let  cashedTarget=null;
	    if(isCashed!=null){
	    	
	    	cashedTarget= isCashed[groupIdToSend]
	    }
	    
	    console.log(cashedTarget);
	    
	    if(cashedTarget != undefined||cashedTarget != null){
	        console.log(cashedTarget);
	       
	        copyActiveProductList[groupIdToSend] = cashedTarget;
	        
	        
	        // 잠시 주석처리, html태그를 비우고 호출할지 아니면 그냥 이렇게 주석처리할지 고민하자.
	        
	        htmlRender(groupIdToSend)
	        console.log("캐쉬 완료")
	        return;
	    }
	    

	    
	    
	    
	    console.log("선택된 그룹 ID:", selectedGroupId);

	    // AJAX로 서버 전송 예시

	    
	    
	    $.ajax({
	        url: contextPath + "/api/admin/get-active-product-list",
	        type: "POST",
	        data: { groupId: groupIdToSend },
	        success: function(response) {
	       const {data}=response;
	       
	       if(data.length<=0){
	    	   alert("해당 상품그룹의 등록된 제품이 없습니다.");
	    	   return;
	    	   
	    	   
	    	   
	       }
	    
	       copyActiveProductList[groupIdToSend]=data;
	       
	       localStorage.setItem("copyActiveProductList", JSON.stringify(copyActiveProductList));
	       
	       htmlRender(groupIdToSend);
	       
	       
	        },
	        error: function(xhr, status, error) {
	            console.error("그룹 변경 실패:", error);
	        }
	    });
	    
	}
	
	

	
	
	function htmlRender(groupId) {
	    var items = Array.isArray(copyActiveProductList[groupId])
	                ? copyActiveProductList[groupId]
	                : Object.values(copyActiveProductList[groupId] || {});

	    // 문자열로 HTML 생성
	    var htmlTag = '<div class="product-table">';
	    
	    // 헤더
	    htmlTag += '<div class="product-table-header">';
	    htmlTag += '<div class="product-col col-id">상품 ID</div>';
	    htmlTag += '<div class="product-col col-name">상품명</div>';
	    htmlTag += '<div class="product-col col-price">가격</div>';
	    htmlTag += '<div class="product-col col-status">상태</div>';
	    htmlTag += '</div>';

	    // 데이터 행
	    for (var i = 0; i < items.length; i++) {
	        var item = items[i];
	        htmlTag += '<div class="product-table-row" data-idx="' + i + '" data-product_id="' + item.product_id + '">';
	        htmlTag += '<div class="product-col col-id">' + item.product_id + '</div>';
	        htmlTag += '<div class="product-col col-name">' + item.product_name + '</div>';
	        htmlTag += '<div class="product-col col-price">' + item.new_price + '</div>';
	        htmlTag += '<div class="product-col col-status">' + item.product_status + '</div>';
	        htmlTag += '</div>';
	    }

	    htmlTag += '</div>';

	    
	    

	    
	    
	    // 렌더링: 두 번째 직계 자식으로 삽입
	    var contentBody = document.getElementById("contentBody");
	    var firstChild = contentBody.firstElementChild;

	    
	    
	    // ⭐ 기존 product-table 존재하면 제거
	    var oldTable = contentBody.querySelector('.product-table');
	    if (oldTable) {
	        oldTable.remove();
	    }
	    
	    
	    
	    
	    // 기존 첫 번째 자식(셀렉트박스) 뒤에 삽입
	    if (firstChild) {
	        if (firstChild.nextElementSibling) {
	            contentBody.insertBefore(
	                document.createRange().createContextualFragment(htmlTag),
	                firstChild.nextElementSibling
	            );
	        } else {
	            contentBody.appendChild(
	                document.createRange().createContextualFragment(htmlTag)
	            );
	        }
	    } else {
	        contentBody.appendChild(
	            document.createRange().createContextualFragment(htmlTag)
	        );
	    }
	}

	
	// document에 이벤트 위임으로 클릭 이벤트 설정
// 이벤트 위임으로 테이블 클릭
document.addEventListener("click", function(event) {
    const row = event.target.closest(".product-table-row");
    if (!row) return;

    const productId = row.getAttribute("data-product_id");
    const productName = row.querySelector(".col-name").innerText;
    const productPrice = row.querySelector(".col-price").innerText;
    const productStatus = row.querySelector(".col-status").innerText;

    // 모달 열기
    const modal = document.getElementById("productModal");
    modal.style.display = "flex";

    // 모달 내용 세팅
    document.getElementById("modalProductName").innerText = "상품명: " + productName;
    document.getElementById("modalProductPrice").innerText = "가격: " + productPrice;

    // 상태 select 세팅 (현재 상태와 반대 상태만)
    const statusSelect = document.getElementById("modalProductStatus");
    statusSelect.innerHTML = ""; // 초기화
    if (productStatus === "판매") {
        statusSelect.innerHTML = '<option value="중단">중단</option>';
    } else if (productStatus === "판매 중단") {
        statusSelect.innerHTML = '<option value="판매">판매</option>';
    }

    // 확인 버튼 클릭
    document.getElementById("modalConfirm").onclick = function() {
        const newStatus = statusSelect.value;
        console.log("전송할 product_id:", productId, "newStatus:", newStatus);

        // AJAX로 백엔드 전송 예시
        $.ajax({
            url: contextPath + "/api/admin/update-product-status",
            type: "POST",
            data: { productId: productId, status: newStatus },
            success: function(response) {
                alert("상태가 변경되었습니다.");
                modal.style.display = "none";

                // 테이블 상태 업데이트
                row.querySelector(".col-status").innerText = newStatus;
            },
            error: function(err) {
                alert("상태 변경 실패");
            }
        });
    };

    // 닫기 버튼
    document.getElementById("modalCancel").onclick = function() {
        modal.style.display = "none";
    };
});

// 모달 바깥 클릭 시 닫기
window.onclick = function(event) {
    const modal = document.getElementById("productModal");
    if (event.target == modal) {
        modal.style.display = "none";
    }
};



	
	
</script>


</head>
<body>
	<div id="pageWrapper">
		<!-- 좌측 수직 메뉴 -->
		<div id="sidebar">
			<%@ include file="../compoents/adminVerticalBar/adminVerticalBar.jsp"%>
		</div>
		<!-- 우측 메인 콘텐츠 -->
		<div id="mainContent">
			<div id="contentHeader">
				<h1>상품 홈페이지 노출 관리</h1>
				<div class="header-subtitle">등록된 상퓸정보를 홈페이지에서 노출시킬지를 결정합니다.</div>
			</div>
			<div id="contentBody">			
		<div class="select-box-wrapper">
    <label for="productGroupSelect" class="select-label">상품 그룹 선택</label>
    <select id="productGroupSelect" name="productGroup" class="styled-select">
        <c:forEach var="group" items="${productCodeList}">
            <option value="${group.groupId}">${group.groupName}</option>
        </c:forEach>
    </select>
</div>

			
			</div>

		</div>
	</div>
	
	
	<!-- 모달 기본 구조 -->
<div id="productModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="modal-close" style="cursor:pointer;">&times;</span>
        <h2>상품 홈페이지 노출 수정</h2>
        <div class="modal-body">
            <p id="modalProductName"></p>
            <p id="modalProductPrice"></p>
            <label for="modalProductStatus">상태 변경:</label>
            <select id="modalProductStatus"></select>
        </div>
        <div class="modal-footer">
            <button id="modalCancel">닫기</button>
            <button id="modalConfirm">확인</button>
        </div>
    </div>
</div>


	
</body>
</html>