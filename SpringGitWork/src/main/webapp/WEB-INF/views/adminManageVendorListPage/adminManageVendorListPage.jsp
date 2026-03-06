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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
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
/* 카테고리 추가 모달 시작 */
#add-category-modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	flex-direction: column;
}

#add-category-modal form {
	background: #fff;
	padding: 25px 30px;
	border-radius: 12px;
	width: 400px;
	max-width: 90%;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
	position: relative;
	animation: fadeIn 0.3s ease;
}

#add-category-modal h3 {
	margin-top: 0;
	color: #4a90e2;
	font-weight: 600;
	margin-bottom: 15px;
}

#add-category-modal .btn-blue {
	background-color: #4a90e2;
	color: #fff;
	border-radius: 6px;
	padding: 8px 14px;
	cursor: pointer;
	font-size: 14px;
	border: none;
	transition: 0.2s;
}

#add-category-modal .btn-blue:hover {
	background-color: #357ab8;
}

#add-category-modal input, #add-category-modal select {
	width: 100%;
	padding: 8px 10px;
	margin-top: 4px;
	border-radius: 6px;
	border: 1px solid #ccc;
}

#add-category-modal hr {
	border: 0;
	border-top: 1px solid #eee;
	margin: 20px 0;
}

@
keyframes fadeIn {
	from {opacity: 0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}

/* 카테고리 추가 모달 종료 */
</style>



<script>
const contextPath = "${pageContext.request.contextPath}";

$(function(){	

    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        }
    });  

    // JSP에서 전달된 데이터가 존재하면 JSON 문자열로 출력, 없으면 '[]'
    let categoryList = ${categoryList};
    let vendorList = ${vendorList};

    
    
 /*    try {
        categoryList = '${categoryList}';
       
    } catch(e) {
        console.warn("categoryList parsing failed, using empty array", e);
        categoryList = [];
    }

    try {
        vendorList = '${vendorList}'
   
        
        
    } catch(e) {
        console.warn("vendorList parsing failed, using empty array", e);
        vendorList = [];
    }

    // 로컬스토리지에 저장
    try {
        localStorage.setItem("categoryList", JSON.stringify(categoryList));
        localStorage.setItem("vendorList", JSON.stringify(vendorList));
        console.log("Category & Vendor List cached in localStorage");
    } catch (e) {
        console.error("localStorage 저장 실패", e);
    }
 */
   /*  console.log("Categories:", categoryList);
    console.log("Vendors:", vendorList);
 */
    
 
    // isCashed 쿠키에 저장
  /*   function setCookie(name, value, days) {
        let expires = "";
        if (days) {
            const date = new Date();
            date.setTime(date.getTime() + (days*24*60*60*1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/; SameSite=Lax";
    }

    try {
        setCookie("isCashed", true, 1); // 1일 유지
        console.log("isCashed cached in cookie:", true);
    } catch(e) {
        console.error("쿠키 저장 실패", e);
    }  */
    
    createSelectorMenu(vendorList);

    function createSelectorMenu(vendorList){

        var $wrapper = $("#selectMenuwrapper");
        var $wrapper = $("#selectMenuwrapper");
        $wrapper.empty();   // 기존 내용 초기화

        // select 생성
        var $select = $("<select>", {
            id: "vendorSelect",
            class: "form-select styled-select"
        });
     
        // 기본 옵션
        $select.append(
            $("<option>", {
                value: "none-vendor",
                text: "거래처 선택"
            })
        );
      
        
        // vendorList 반복
        if (Array.isArray(vendorList)) {
            vendorList.forEach(function(item){  	

             
                    $select.append(
                        $("<option>", {
                            value: item.vendorId,
                            text: item.name
                        })
                    );

                

            });
        }

        $wrapper.append($select);
        
    }
    
    
    
    createCategorySelectMenuwrapper(categoryList);    
    function createCategorySelectMenuwrapper(categoryList) {
    	
    	console.log(categoryList);
    	
    	
        var $wrapper = $("#categorySelectMenuwrapper");
        $wrapper.empty(); // 기존 내용 초기화

        // label 생성
        var $label = $("<label>", {
            for: "categorySelect",
            class: "select-label",
            text: "카테고리 선택"
        });

        // select + 버튼을 담을 div
        var $innerDiv = $("<div>", {
            css: {
                display: "flex",
                gap: "10px",
                alignItems: "center"
            }
        });

        // select 생성
        var $select = $("<select>", {
            id: "categorySelect",
            name: "category_id",
            class: "styled-select"
        });

        // 기본 옵션
        $select.append(
            $("<option>", {
                value: "",
                text: "카테고리 선택"
            })
        );

       
        // categoryList 반복
        if (Array.isArray(categoryList)) {
            categoryList.forEach(function(item) {
                // parentId가 null인 최상위 카테고리만 표시 (필요 없으면 제거 가능)
       
                    $select.append(
                        $("<option>", {
                            value: item.categoryId,
                            text: item.name,
                            "data-product_group": item.name,   // 🔥 여기 추가
                            "data-parent-id": item.parentId   // 🔥 여기 추가
                        })
                     
                    );
               
            });
        }
        
        
        // 버튼 생성
        var $btn = $("<button>", {
            type: "button",
            id: "openCategoryAddBtn",
            class: "btn-blue",
            text: "카테고리 추가"
        });

        // select + 버튼 div에 넣기
        $innerDiv.append($select).append($btn);

        // 전체 wrapper에 label + innerDiv 넣기
        $wrapper.append($label).append($innerDiv);
    }

    
    
    
    // ✅ 이벤트 위임 (동적 생성 요소 대응)
    $("#selectMenuwrapper").on("change", "#vendorSelect", function(){
        console.log("선택한 vendorId:", $(this).val());
        // 여기서 Ajax 호출 또는 페이지 이동 가능
    });
    
    $("#categorySelectMenuwrapper").on("change", "#categorySelect", function(){
        console.log("선택한 categoryId:", $(this).val());
        var parentId = $(this).find("option:selected").data("parent-id");
        console.log(parentId); 
        // 여기서 Ajax 호출 가능
      
        
        
    });
    
    

    
 // 카테고리 추가 버튼 클릭
    $(document).on("click", "#openCategoryAddBtn", function() {
        $("#add-category-modal").fadeIn(200).css({
            display: "flex",
            alignItems: "center",
            justifyContent: "center"
        });
    });

    // 모달 바깥 클릭 시 닫기
    $(document).on("click", "#add-category-modal", function(e) {
        if (e.target.id === "add-category-modal") {
            $(this).fadeOut(200);
        }
    });

    
    
});



function createSubCategory(){
	
	
}




//----------------------
//상품 그룹 추가 버튼 클릭
//----------------------
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

//선택된 option 요소
const selectedOption = $("#productGroupSelect option:selected");



// group_id(value) 가져오기
const groupId = selectedOption.val();


const selectedVendor = $("#vendorSelect option:selected");




const selectedCategory = $("#categorySelect option:selected");

const selectedVendorId=selectedVendor.val();
const categoryName = selectedCategory.data("product_group");


/* if(selectedVendor.val()==="none-vendor"){
	 alert("공급업체를 선택해주세요.");
	    $("#vendorSelect").focus();
	    return;
}

if(selectedCategory.val()==="none-category"){
	 alert("등록하고자 하는 상품의 카테고리를 선택해주세요");
	    $("#categorySelect").focus();
	    return;
}
 */
//console.log(groupId);     // group.groupId
console.log(categoryName);


if (!categoryName) {
    alert("상품 그룹을 선택하세요.");
    $("#categorySelect").focus();
    return;
}


const formData = new FormData();
// 상품 데이터 수집
formData.append("group_id", selectedCategory.val());
formData.append("category_id", selectedCategory.val());
formData.append("vendor_id", selectedVendorId);
formData.append("product_group",categoryName);
formData.append("product_name", $("#productName").val());
formData.append("product_price", $("#productPrice").val());
formData.append("online_product_quantity", $("#productQuantity").val());
formData.append("product_info", $("#productInfo").val());


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
    url: contextPath + "/api/admin/insert-product-infomation",
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
				<h1>거래처의 상품 정보를 입력</h1>
				<div class="header-subtitle">거래처와의 거래 상품 대상 정보를 입력합니다.</div>
			</div>

			<div id="contentBody">
				<h2>상품 등록</h2>

				<form id="productForm" enctype="multipart/form-data">
					<div id="selectMenuwrapper">
						<h2 id="supplyer-name">공급업체(거래처) 선택</h2>


					</div>
					<div id="categorySelectMenuwrapper">
						<h2>상품 카테고리 선택</h2>
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






	<!-- 카테고리 추가 모달 -->
	<div id="add-category-modal">
		<form id="categoryForm">

			<div class="select-box-wrapper">
				<label class="select-label">상위 카테고리 를 추가합니다.</label>

			</div>

			<div class="select-box-wrapper">
				<label class="select-label">카테고리명</label> <input type="text"
					id="name" class="styled-input" required>
			</div>

			<div class="select-box-wrapper">
				<label class="select-label">정렬 순서</label> <input type="number"
					id="sort_order" class="styled-input" value="0">
			</div>

			<hr style="margin: 25px 0;">

			<h3>하위 카테고리 (선택)</h3>

			<div id="childContainer"></div>

			<div style="margin-bottom: 15px;">
				<button type="button" id="addChildBtn" class="btn-blue">+
					하위 카테고리 추가</button>
			</div>


			<div class="select-box-wrapper">
				<label class="select-label">사용 여부</label> <select id="is_active"
					class="styled-select">
					<option value="true" selected>활성</option>
					<option value="false">비활성</option>
				</select>
			</div>

			<!--	<hr style="margin:25px 0;">

			 	<h3>카테고리 속성 (선택)</h3>
				<div id="attributeContainer"></div>

				<div style="margin-bottom:15px;">
					<button type="button" id="addAttributeBtn" class="btn-blue">
						+ 속성 추가
					</button>
				</div>
 -->


			<div style="text-align: right;">
				<button type="submit" class="btn-blue">카테고리 등록</button>
			</div>

		</form>


	</div>


	<script>


$(document).ready(function(){

    // CSRF 세팅
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    $.ajaxSetup({beforeSend: function(xhr){xhr.setRequestHeader(header, token);}});

    let attributeIndex = 0;

    // =======================
    // 속성 추가 / 삭제
    // =======================
    $("#addAttributeBtn").click(function(){

        let html = `
        <div class="attribute-item">
            <div class="select-box-wrapper">
                <label class="select-label">속성명</label>
                <input type="text" class="styled-input attr-name">
            </div>

            <div class="select-box-wrapper">
                <label class="select-label">입력 타입</label>
                <select class="styled-select attr-type">
                    <option value="text">text</option>
                    <option value="number">number</option>
                    <option value="select">select</option>
                </select>
            </div>

            <div class="select-box-wrapper select-options" style="display:none;">
                <label class="select-label">옵션 값 (콤마 구분)</label>
                <input type="text" class="styled-input attr-options"
                       placeholder="예: 빨강,파랑,노랑">
            </div>

            <div class="select-box-wrapper">
                <label class="select-label">필수 여부</label>
                <select class="styled-select attr-required">
                    <option value="true">필수</option>
                    <option value="false">선택</option>
                </select>
            </div>

            <button type="button" class="btn-blue removeAttrBtn">삭제</button>
        </div>
        `;

        $("#attributeContainer").append(html);
        attributeIndex++;
    });

    // select 타입 선택 시 옵션 표시
    $(document).on("change", ".attr-type", function(){
        let parent = $(this).closest(".attribute-item");
        if($(this).val() === "select"){
            parent.find(".select-options").show();
        }else{
            parent.find(".select-options").hide();
        }
    });

    // 속성 삭제
    $(document).on("click", ".removeAttrBtn", function(){
        $(this).closest(".attribute-item").remove();
    });

    // =======================
    // 하위 카테고리 추가 / 삭제
    // =======================
    $("#addChildBtn").click(function(){
        let html = `
            <div class="child-item" style="margin-bottom:8px; display:flex; gap:6px; align-items:center;">
                <input type="text" class="styled-input child-name" placeholder="하위 카테고리명 입력">
                <button type="button" class="btn-blue removeChildBtn">삭제</button>
            </div>
        `;
        $("#childContainer").append(html);
    });

    // 하위 삭제
    $(document).on("click", ".removeChildBtn", function(){
        $(this).closest(".child-item").remove();
    });

    // =======================
    // 폼 제출
    // =======================
    $("#categoryForm").submit(function(e){
        e.preventDefault();

        // 속성 정보 수집
        let attributes = [];
        $(".attribute-item").each(function(){
            attributes.push({
                name: $(this).find(".attr-name").val().trim(),
                inputType: $(this).find(".attr-type").val(),
                options: $(this).find(".attr-options").val().trim(),
                isRequired: $(this).find(".attr-required").val() === "true"
            });
        });

        // 하위 카테고리 정보 수집
        let children = [];
        $(".child-name").each(function(){
            let val = $(this).val().trim();
            if(val !== ""){
                children.push(val);
            }
        });

        // 최종 formData 구성
        let formData = {
            parentId: $("#parent_id").val() || null,
            name: $("#name").val().trim(),
            sortOrder: $("#sort_order").val(),
            isActive: $("#is_active").val() === "true",
            attributes: attributes,
            children: children
        };

        // 필수 체크
        if(formData.name === ""){
            alert("카테고리명은 필수입니다.");
            return;
        }

        console.log(formData);
       
        $.ajax({
            url: contextPath + "/api/admin/category-insert",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function(res){
                alert("카테고리 등록 완료!");
                location.reload();
            },
            error: function(xhr){
                console.error(xhr.responseText);
                alert("등록 실패");
            }
        });
       
    });
});
</script>


</body>
</html>