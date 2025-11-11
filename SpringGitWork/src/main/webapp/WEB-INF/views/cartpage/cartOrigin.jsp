<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>장바구니</title>
<style>

/* 기본 스타일 */
#emptycarousel {
	display: none;
	text-align: center;
	margin-top: 100px;
}

#carousel {
	display: none;
}

table {
	width: 800px;
	max-width: 800px;
	min-width: 800px;
	margin: 0 auto;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

img {
	width: 80px;
	height: auto;
}

.quantity-control {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.quantity-control button {
	width: 32px;
	height: 32px;
	font-size: 20px;
	font-weight: bold;
	background-color: #f0f0f0;
	border: 1px solid #ccc;
	border-radius: 4px;
	cursor: pointer;
	user-select: none;
	transition: background-color 0.2s ease;
}

.quantity-control button:hover {
	background-color: #ddd;
}

.quantity-control input {
	width: 40px;
	text-align: center;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
	pointer-events: none; /* 직접 수정 방지 */
	background-color: #fff;
	user-select: none;
}


 #mobileNave{
  display: none;
}


 /*모바일 시작  */
@media screen and (max-width: 760px) {


    /* 네비게이션 전환 */
    #pcNave {
        display: none;
    }
    #mobileNave {
        display: block;
    }
}
/*모바일 종료  */ 

</style>

</head>
<body>

	<div id="wrapper">
	   		<div id="pcNave">
 <%@ include file="../pcNave.jsp"%>
</div>
<div id="mobileNave">
 <%@ include file="../mobileNave.jsp"%>
</div>

		<!-- 비어있을 때 보여줄 영역 -->
		<div id="emptycarousel">
			<div id="carouselimg"></div>
			<h3>장바구니가 비어있어요</h3>
		</div>

		<!-- 아이템 있을 때 보여줄 영역 -->
		<div id="carousel">
			<form action="${pageContext.request.contextPath}/users/order" id="forminfo">
				<!-- 테이블 바로 위 -->
				<div class="cart-controls"
					style="width: 800px; margin: 20px auto 10px; text-align: right;">
					<button type="button" class="allchoicebtn">전체선택</button>
					<button type="button" class="allclearbtn">전체선택해제</button>
					<button type="button" class="dropcart">장바구니비우기</button>
				</div>

				<table>
					<thead>
						<tr>
							<th colspan="2">상품정보</th>
							<th>수량</th>
							<th>개당가격</th>
							<th>수량대비가격</th>
							<th>확인</th>
						</tr>
					</thead>
					<tbody id="cart-items">
						<!-- JS가 장바구니 아이템 생성 -->
					</tbody>
					<tfoot>
						<tr>
							<td id="finallsum" colspan="6">
								<div class="finallpurchace">
									<div class="subfinallpurchace">합계금액:</div>
									<input id="ajaxfinallsum" type="text" name="finallsum"
										value="0" readonly>
								</div>
							</td>
						</tr>
					</tfoot>

				</table>


				<!-- 테이블 아래에 주문/쇼핑 버튼 -->
				<div class="order-actions"
					style="width: 800px; margin: 20px auto; display: flex; justify-content: space-between;">
					<a href="${pageContext.request.contextPath}/guest/productlist" class="continue-shopping"
						style="padding: 10px 20px; background: #f5f5f5; border: 1px solid #ccc; border-radius: 4px; text-decoration: none;">
						계속 쇼핑하기 </a> <input id="lastorder" type="submit" value="주문하기"
						style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">
				</div>
			</form>
		</div>
	</div>
	

	<script>
	
	  // localStorage에서 cart 불러오기
	let cart ;
	window.addEventListener('pageshow', function(event) {
		  if (event.persisted) {
		    console.log('뒤로가기로 복원된 페이지입니다 (bfcache).');
		    cart= JSON.parse(localStorage.getItem("cart") || "[]");
		    renderCart()
		  } else {
		    console.log('새로 로드된 페이지입니다.');
		    cart= JSON.parse(localStorage.getItem("cart") || "[]");
		    renderCart()
		  }
		});
	
	

const cartItemsTbody = document.getElementById("cart-items");
const totalSumInput = document.getElementById("ajaxfinallsum");
const emptyDiv = document.getElementById("emptycarousel");
const cartDiv = document.getElementById("carousel");

function escapeHtml(text) {
  return text
    .replace(/&/g, "&amp;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}
function extractImgUrl(imgStr) {
  const match = imgStr.match(/url\(["']?(.*?)["']?\)/);
  return match ? match[1] : imgStr;
}

function renderCart() {
  cartItemsTbody.innerHTML = "";

  if(cart.length === 0) {
    document.getElementById("carousel").style.display = "none";
    document.getElementById("emptycarousel").style.display = "block";
    totalSumInput.value = "0";
    return;
  } else {
    document.getElementById("carousel").style.display = "block";
    document.getElementById("emptycarousel").style.display = "none";
  }

  let totalSum = 0;
  
  cart.forEach((item, idx) => {
    console.log("productName:", item.productName);
    const quantity = item.quantity || 1;
    const price = Number(item.productPrice);
    const sum = price * quantity;
    totalSum += sum;

    const imgSrc = extractImgUrl(item.productImg);

    const tr = document.createElement("tr");

    let html = '';
    html += '<td class="col1">';
    html += '<img src="' + imgSrc + '" alt="' + item.productName + '">';
    html += '</td>';

    html += '<td class="col2" data-product-cod="' + item.productCod + '">';
    html += '<div>';
    html += '<input type="hidden" name="cart_id" value="' + (item.cartId || '') + '">';
    html += '<input type="hidden" name="product_img" value="' + imgSrc + '">';
    html += '<input type="hidden" name="id" value="' + (item.id || '') + '">';
    html += '<input type="hidden" name="product_id" value="' + item.productId + '">';

    html += '<input type="text" name="product_name" value="' + item.productName + '" readonly><br>';
    html += '<input type="hidden" name="user_code" value="' + (item.userCode || '') + '">';
    html += '</div>';
    html += '</td>';

    html += '<td>';
    html += '<div class="quantity-control">';
    html += '<button type="button" class="pluss" data-idx="' + idx + '" data-action="minus">-</button>';
    html += '<input name="cart_quantity" value="' + quantity + '" readonly>';
    html += '<button type="button" class="pluss" data-idx="' + idx + '" data-action="plus">+</button>';
    html += '</div>';
    html += '</td>';

    html += '<td class="onetoonprice">' + price.toLocaleString() + ' 원</td>';
    html += '<td class="quantityprice">' + sum.toLocaleString() + ' 원</td>';

    // checkbox에 selected 상태 반영
    html += '<td class="col5"><input type="checkbox" class="finalladd" data-idx="' + idx + '" ' + (item.selected ? 'checked' : '') + '></td>';

    tr.innerHTML = html;

    cartItemsTbody.appendChild(tr);
  });

  totalSumInput.value = totalSum.toLocaleString();
}
/* renderCart(); */
 
// 수량 버튼 이벤트
cartItemsTbody.addEventListener("click", (e) => {
  if(e.target.classList.contains("pluss")) {
    const idx = e.target.getAttribute("data-idx");
    const action = e.target.getAttribute("data-action");

    if(action === "plus") {
      cart[idx].quantity = (cart[idx].quantity || 1) + 1;
    } else if(action === "minus") {
      if(cart[idx].quantity > 1) {
        cart[idx].quantity--;
      }
    }
    localStorage.setItem("cart", JSON.stringify(cart));
    renderCart();
  }
});

// checkbox 클릭 시 selected 값 저장
cartItemsTbody.addEventListener("change", (e) => {
  if(e.target.classList.contains("finalladd")) {
    const idx = e.target.getAttribute("data-idx");
    cart[idx].selected = e.target.checked;
    localStorage.setItem("cart", JSON.stringify(cart));
  }
});

// 전체선택 버튼
document.querySelector(".allchoicebtn").addEventListener("click", () => {
  cart.forEach(item => item.selected = true);
  localStorage.setItem("cart", JSON.stringify(cart));
  renderCart();
});

// 전체해제 버튼
document.querySelector(".allclearbtn").addEventListener("click", () => {
  cart.forEach(item => item.selected = false);
  localStorage.setItem("cart", JSON.stringify(cart));
  renderCart();
});

// 장바구니 비우기 버튼
document.querySelector(".dropcart").addEventListener("click", () => {
  if(confirm("장바구니를 비우시겠습니까?")) {
    cart = [];
    localStorage.removeItem("cart");
    renderCart();
  }
});

</script>

</body>
</html>