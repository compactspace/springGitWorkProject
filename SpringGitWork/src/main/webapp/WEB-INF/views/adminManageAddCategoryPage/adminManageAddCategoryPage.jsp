<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 등록</title>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

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
.attribute-item{border:1px solid #eee; padding:15px; margin-bottom:10px; border-radius:6px;}
</style>

<script>
const contextPath="${pageContext.request.contextPath}";

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


</head>
<body>
<div id="pageWrapper">

	<div id="sidebar">
		<%@ include file="../compoents/adminVerticalBar/adminVerticalBar.jsp"%>
	</div>

	<div id="mainContent">

		<div id="contentHeader">
			<h1>카테고리 등록</h1>
			<div class="header-subtitle">새로운 상품 카테고리를 추가합니다.</div>
		</div>

		<div id="contentBody">
			<form id="categoryForm">

				<div class="select-box-wrapper">
					<label class="select-label">상위 카테고리</label>
					<select id="parent_id" class="styled-select">
						<option value="">최상위</option>
						<c:forEach var="cat" items="${categoryList}">
							<option value="${cat.category_id}">
								${cat.name}
							</option>
						</c:forEach>
					</select>
				</div>

				<div class="select-box-wrapper">
					<label class="select-label">카테고리명</label>
					<input type="text" id="name" class="styled-input" required>
				</div>

				<div class="select-box-wrapper">
					<label class="select-label">정렬 순서</label>
					<input type="number" id="sort_order" class="styled-input" value="0">
				</div>
				
				<hr style="margin:25px 0;">

<h3>하위 카테고리 (선택)</h3>

<div id="childContainer"></div>

<div style="margin-bottom:15px;">
	<button type="button" id="addChildBtn" class="btn-blue">
		+ 하위 카테고리 추가
	</button>
</div>
				

				<div class="select-box-wrapper">
					<label class="select-label">사용 여부</label>
					<select id="is_active" class="styled-select">
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
 
 
				<div style="text-align:right;">
					<button type="submit" class="btn-blue">
						카테고리 등록
					</button>
				</div>

			</form>
		</div>

	</div>
</div>
</body>
</html>
