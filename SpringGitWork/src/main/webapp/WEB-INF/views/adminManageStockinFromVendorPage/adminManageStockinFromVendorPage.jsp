<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:csrfMetaTags />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입고 관리</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<style>
html, body { height:100%; margin:0; font-family: 'Roboto', sans-serif; }
#pageWrapper { display:flex; height:100vh; }
#sidebar { width:240px; border-right:1px solid #e0e0e0; overflow-y:auto; }
#mainContent { flex:1; padding:24px; overflow-y:auto; }

#contentHeader { padding:20px 24px; background-color:#f5f7fa; border-left:6px solid #4a90e2; border-radius:4px; margin-bottom:20px; }
#contentHeader h1 { margin:0; font-size:1.8em; font-weight:700; }
#contentBody { background-color:#fff; padding:20px; border-radius:8px; min-height:400px; }

.product-row {
    background:#f8f9fa;
    cursor:pointer;
    font-weight:bold;
}

.warehouse-table {
    display:none;
    background:#ffffff;
}

.warehouse-table table {
    width:100%;
    border-collapse:collapse;
    margin:10px 0;
}

th, td {
    border:1px solid #ddd;
    padding:8px;
    text-align:center;
}

th { background:#f1f1f1; }

input[type="number"] { width:70px; }
select { width:120px; }
button { padding:6px 12px; margin-top:10px; cursor:pointer; }

.toggle-icon { float:right; }
</style>
</head>

<body>
<div id="pageWrapper">
    <div id="sidebar">
        <%@ include file="../compoents/adminVerticalBar/adminVerticalBar.jsp"%>
    </div>

    <div id="mainContent">
        <div id="contentHeader">
            <h1>입고 관리</h1>
            <div class="header-subtitle">최초입고 / 재입고 처리</div>
        </div>
        <div id="contentBody"></div>
    </div>
</div>

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



const stockList = ${getIncomingStockListVO};
const wareHouseList = ${wareHouseList};

/* =========================
   1. 상품 기준 그룹화 + 창고 합성
========================= */
function groupProducts(stockList, wareHouseList) {
    const map = {};

    stockList.forEach(item => {
        if(!map[item.productId]) {
            map[item.productId] = {
                productId: item.productId,
                productName: item.productName,
                hasInitialStock: item.hasInitialStock,
                warehouses: []
            };
        }
        map[item.productId].warehouses.push(item);
    });

    // 모든 상품에 대해 모든 창고 보장
    Object.values(map).forEach(product => {
        wareHouseList.forEach(wh => {
        
            if(!product.warehouses.find(w => w.warehouseId === wh.warehouseId)) {
                product.warehouses.push({
                    warehouseId: wh.warehouseId,
                    warehouseName: wh.name,
                    quantity: 0,
                    inventoryId: null
                });
            }
        });
    });

    
    
  // null인 warehouseId 제거
Object.values(map).forEach(product => {
    product.warehouses = product.warehouses.filter(w => w.warehouseId !== null);
});

    
    
    
    
    
    return Object.values(map);
}

/* =========================
   2. 테이블 렌더링
========================= */
function renderTable(stockList, wareHouseList) {
    const grouped = groupProducts(stockList, wareHouseList);    
  //  console.log(grouped);    
    let html = "";

    html += "<table style='width:100%; border-collapse:collapse;'>";
    html += "<thead>";
    html += "<tr><th>상품명</th><th>총재고</th><th>최초입고 여부</th></tr>";
    html += "</thead><tbody>";

    grouped.forEach(product => {
        const totalQty = product.warehouses.reduce((sum, w) => sum + (w.quantity || 0), 0);

        html += "<tr class='product-row' data-product='"+product.productId+"'>";
        html += "<td>"+product.productName+" <span class='toggle-icon'>▶</span></td>";
        html += "<td>"+totalQty+"</td>";
        html += "<td>"+(product.hasInitialStock ? "완료" : "필요")+"</td>";
        html += "</tr>";

        html += "<tr class='warehouse-table' id='wh-"+product.productId+"'>";
        html += "<td colspan='3'>";
        html += "<table>";
        html += "<thead><tr><th>창고</th><th>현재재고</th><th>입고수량</th><th>유형</th></tr></thead><tbody>";

        product.warehouses.forEach(wh => {
            let movementOptions = "";
            if(!product.hasInitialStock){
                movementOptions =
                    "<option value='INITIAL'>INITIAL</option>"+
                    "<option value='PURCHASE'>PURCHASE</option>"+
                    "<option value='RETURN'>RETURN</option>";
            } else {
                movementOptions =
                    "<option value='PURCHASE'>PURCHASE</option>"+
                    "<option value='RETURN'>RETURN</option>";
            }
            
            html += "<tr>";
            html += "<td>"+wh.warehouseName+"</td>";
            html += "<td>"+wh.quantity+"</td>";
            html += "<td><input type='number' min='1' " +
            "data-inventory='"+(wh.inventoryId || "")+"' " +
            "data-warehouse-id='"+(wh.warehouseId || "")+"' " +
            "data-product-id='"+product.productId+"' /></td>";
            html += "<td><select>"+movementOptions+"</select></td>";
            html += "</tr>";
        });

        html += "</tbody></table></td></tr>";
    });

    html += "</tbody></table>";
    html += "<button id='processStockin'>입고 처리</button>";

    $("#contentBody").html(html);
    
    
}

/* =========================
   3. 단일 아코디언
========================= */
$(document).on("click", ".product-row", function(){
    const productId = $(this).data("product");
    const target = $("#wh-" + productId);

    $(".warehouse-table").not(target).hide();
    $(".toggle-icon").text("▶");

    target.toggle();
    $(this).find(".toggle-icon").text(target.is(":visible") ? "▼" : "▶");
});




/* =========================
4. 입고 처리
========================= */
$(document).on("click", "#processStockin", function(){

 const purchaceRows = [];
 const initialRows=[];
 
 $("input[type='number']").each(function(){
     const qty = $(this).val();

     if(qty && qty > 0){
         const inventoryId = $(this).data("inventory");
         const productId = $(this).data("product-id");
         const warehouseId=$(this).data("warehouse-id")
         const movement = $(this).closest("tr").find("select").val();

              
         
         if(inventoryId===""){
        	 initialRows.push({
                 inventoryId: inventoryId,
                 productId: productId,
                 warehouseId:warehouseId,
                 quantity: Number(qty),
                 type: movement
             });
         }       
         
         
         
         else{
        	 purchaceRows.push({
                 inventoryId: inventoryId,
                 productId: productId,
                 warehouseId:warehouseId,
                 quantity: Number(qty),
                 type: movement
             });
         }
     }
 });

 
 
/*  if(purchaceRows.length === 0 || initialRows.length === 0){
     alert("입고 수량을 입력하세요.");
     return;
 } */

 console.log("입고 처리 대상:", purchaceRows);
 console.log("최초입고 처리 대상: ",initialRows);

 
  $.ajax({
	    url: contextPath + "/api/admin/atempt-StockIn",
	    type: "POST",
	    contentType: "application/json",
	    data: JSON.stringify({
	        purchaceRows: purchaceRows,
	        initialRows: initialRows
	    }),
	    success: function(response){
	        alert("입고 처리 완료");
	        location.reload();
	    },
	    error: function(xhr){
	        alert("입고 처리 실패");
	        console.error(xhr.responseText);
	    }
	}); 

});

/* =========================
   5. 초기 실행
========================= */
$(document).ready(function(){
    renderTable(stockList, wareHouseList);
});
</script>

</body>
</html>

