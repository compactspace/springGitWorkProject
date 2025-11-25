<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<meta charset="UTF-8">
<title>상품 등록</title>

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
	margin-bottom: 20px;
}

#contentBody {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	min-height: 400px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

.select-box-wrapper {
	margin-bottom: 15px;
	display: flex;
	flex-direction: column;
}

.select-label {
	font-weight: 600;
	margin-bottom: 6px;
}

.styled-select, .styled-input {
	padding: 8px 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 14px;
}

.btn-blue {
	background-color: #4a90e2;
	color: #fff;
	border: none;
	padding: 7px 12px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 13px;
}

#groupAddModal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.45);
	align-items: center;
	justify-content: center;
	z-index: 999;
}

#groupAddModalContent {
	background: white;
	padding: 20px;
	width: 350px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.25);
}
</style>

<script>
const contextPath = "${pageContext.request.contextPath}";

window.onload = function () {
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        }
    });
};

// ----------------------
// 상품 그룹 추가 버튼 클릭
// ----------------------
$(document).ready(function () {
	
	$("#openGroupAddBtn").click(function () {
	    $("#groupAddModal").css("display", "flex").hide().fadeIn(200);
	});


    $("#groupAddClose").click(function () {
        $("#groupAddModal").fadeOut(200);
    });

    
    $("input[name='warehouse_id']").on("change", function() {
        const warehouseId = $(this).val();
        const qtyDiv = $("#warehouseQty_" + warehouseId);

        if ($(this).is(":checked")) {
            qtyDiv.show();
        } else {
            qtyDiv.hide();
            qtyDiv.find("input").val(""); // 입력값 초기화
        }
    });

    
    
    
    
    
    // ----------------------
    // 그룹 추가 AJAX
    // ----------------------
    $("#saveGroupBtn").click(function () {
        const groupName = $("#newGroupName").val();

        if (groupName.trim() === "") {
            alert("그룹명을 입력하세요.");
            return;
        }

        $.ajax({
            url: contextPath + "/api/admin/add-product-group",
            type: "POST",
            data: { group_name: groupName },
            success: function (response) {
                if (response.success) {
                	
                	const {data}=response;  	 
                	
                    const id = data.insertedPk;
                    const name = data.groupName;

                    // 선택박스에 추가
                    // 선택박스에 마지막 자식으로 추가
        $("#productGroupSelect").append(
            "<option value='" + id + "'>" + name + "</option>"
        );

                    // 방금 생성한 것 자동 선택
                    $("#productGroupSelect").val(id);

                    alert("그룹이 성공적으로 추가되었습니다.");

                    // 모달 닫기
                    $("#groupAddModal").fadeOut(200);
                    $("#newGroupName").val("");
                } else {
                    alert("그룹 추가 실패");
                }
            },
            error: function () {
                alert("서버 오류 발생");
            }
        });
    });
    
    
    

  //----------------------
  //상품 등록 Ajax
  //----------------------
  $("#productForm").on("submit", function (e) {
   e.preventDefault(); // 기본 제출 막기
   
   
   // 상품 그룹 선택 여부 확인
   const selectedGroup = $("#productGroupSelect").val();
   
   
   
// 선택된 option 요소
   const selectedOption = $("#productGroupSelect option:selected");
   
   
// data-productgroup 가져오기
   const product_group = selectedOption.data("productgroup");

   // group_id(value) 가져오기
   const groupId = selectedOption.val();

   console.log(groupId);     // group.groupId
   console.log(product_group);  
   
   
   
   if (!selectedGroup) {
       alert("상품 그룹을 선택하세요.");
       $("#productGroupSelect").focus();
       return;
   }
   
// 체크된 창고 선택
   const checkedWarehouses = $("input[name='warehouse_id']:checked").map(function() {
       return $(this).val();
   }).get();

   if (checkedWarehouses.length === 0) {
       alert("창고를 최소 한 개 이상 선택하세요.");
       return;
   }

   

   const formData = new FormData();
   // 상품 데이터 수집
   formData.append("group_id", $("#productGroupSelect").val());
   formData.append("product_group",product_group);
   formData.append("product_name", $("#productName").val());
   formData.append("product_price", $("#productPrice").val());
   formData.append("online_product_quantity", $("#productQuantity").val());
   formData.append("product_info", $("#productInfo").val());
   
   
// 체크된 창고와 재고 수량
checkedWarehouses.forEach(function(warehouseId) {
    var qty = $("input[name='product_quantity_" + warehouseId + "']").val() || 0;

    formData.append("warehouse_id[]", warehouseId);
    formData.append("product_quantity[" + warehouseId + "]", qty);

    console.log("창고 " + warehouseId + " 재고 = " + qty);
});

   
   
   


   // FormData 전체 내용 확인
   console.log("FormData 전체 확인:");
   for (let pair of formData.entries()) {
       console.log(pair[0], "=", pair[1]);
   }
   
   
   // 파일 추가
   const fileInput = $("#productImg")[0].files[0];
   if (fileInput) {
       formData.append("product_img", fileInput);
   }
   
     $.ajax({
       url: contextPath + "/api/admin/add-product",
       type: "POST",
       data: formData,
       contentType: false,
       processData: false,
       success: function (response) {
    	   
    	   console.log(response);
           if (response.success) {
               alert("상품이 성공적으로 등록되었습니다.");
               
             // 상품관리 JSP를 위한 캐쉬 초기화 즉 지워준다.
               
               let cashed=JSON.parse(localStorage.getItem("copyActiveProductList"));
               localStorage.removeItem("copyActiveProductList");
               
               
               
               
               location.reload();
           } else {
               alert("등록 실패: " + response.message);
           }
       },
       error: function () {
           alert("서버 오류 발생");
       }
   });  
     
   
   
   
  });
});






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
				<h1>상품 등록</h1>
				<div class="header-subtitle">신규 상품을 창고에 최초로 추가합니다</div>
			</div>

			<div id="contentBody">
				<h2>상품 등록</h2>

				<form id="productForm" enctype="multipart/form-data">


					<!-- 상품 그룹 선택 -->
					<div class="select-box-wrapper">
						<label for="productGroupSelect" class="select-label">상품 그룹
							선택</label>

						<div style="display: flex; gap: 10px; align-items: center;">
							<select id="productGroupSelect" name="group_id"
								class="styled-select">
								<option value="">그룹 선택</option>
								<c:forEach var="group" items="${productCodeList}">
									<option value="${group.groupId}"
										data-productgroup="${group.groupName}">${group.groupName}</option>
								</c:forEach>
							</select>

							<button type="button" id="openGroupAddBtn" class="btn-blue">
								그룹 추가</button>
						</div>
					</div>





					<!-- 창고 선택 (체크박스 버전) -->
<div class="select-box-wrapper">
    <label class="select-label">창고 선택</label>
    <div style="display: flex; flex-wrap: wrap; gap: 10px;">
        <c:forEach var="warehouse" items="${wareHouseList}">
            <!-- 체크박스 -->
            <label>
                <input type="checkbox" name="warehouse_id" value="${warehouse.warehouseId}" />
                ${warehouse.name}-${warehouse.warehouseId}
            </label>

            <!-- 재고 입력 필드, 처음에는 숨김 -->
            <div class="select-box-wrapper warehouse-qty-wrapper" 
                 id="warehouseQty_${warehouse.warehouseId}" 
                 style="display:none; margin-bottom:10px;">
                <label class="select-label">${warehouse.name} 재고 수량</label>
                <input type="number" 
                       name="product_quantity_${warehouse.warehouseId}" 
                       class="styled-select" 
                       placeholder="${warehouse.name} 재고 수량 입력" />
            </div>
        </c:forEach>
    </div>
</div>












					<!-- 상품명 -->
					<div class="select-box-wrapper">
						<label for="productName" class="select-label">상품명</label> <input
							type="text" id="productName" name="product_name"
							class="styled-select" placeholder="상품명을 입력하세요" required />
					</div>

					<!-- 상품 가격 -->
					<div class="select-box-wrapper">
						<label for="productPrice" class="select-label">상품 가격</label> <input
							type="number" id="productPrice" name="product_price"
							class="styled-select" placeholder="가격을 입력하세요" required />
					</div>

					<!-- 재고 수량 -->
					<div class="select-box-wrapper">
						<label for="productQuantity" class="select-label">재고 수량</label> <input
							type="number" id="productQuantity" name="product_quantity"
							class="styled-select" placeholder="재고 수량 입력" />
					</div>

					<!-- 상품 이미지 -->
					<div class="select-box-wrapper">
						<label for="productImg" class="select-label">상품 이미지</label> <input
							type="file" id="productImg" name="product_img"
							class="styled-select" />
					</div>

					<!-- 상품 정보 -->
					<div class="select-box-wrapper">
						<label for="productInfo" class="select-label">상품 정보</label>
						<textarea id="productInfo" name="product_info"
							class="styled-select" rows="4" placeholder="상품 설명을 입력하세요"></textarea>
					</div>


					<!-- 등록 버튼 -->
					<div class="select-box-wrapper" style="text-align: right;">
						<button type="submit" class="styled-select"
							style="background: #4CAF50; color: white; cursor: pointer;">
							상품 등록</button>
					</div>

				</form>
			</div>
		</div>
	</div>




	<!-- ------------------------ -->
	<!-- 🔥 그룹 추가 모달 -->
	<!-- ------------------------ -->
	<div id="groupAddModal">
		<div id="groupAddModalContent">
			<h3>상품 그룹 추가</h3>

			<div class="select-box-wrapper" style="margin-top: 10px;">
				<label class="select-label">그룹명</label> <input type="text"
					id="newGroupName" class="styled-select" placeholder="새 그룹명을 입력하세요">
			</div>

			<div style="text-align: right; margin-top: 15px;">
				<button id="saveGroupBtn" class="btn-blue">추가</button>
				<button id="groupAddClose" class="btn-blue"
					style="background: #777;">닫기</button>
			</div>
		</div>
	</div>


</body>
</html>

