<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        
        .content2 {
            width: 100%;
            margin: 0 auto;
            padding: 40px 0;
        }
        .product-item {
            display: flex;
            justify-content: space-between;
            background-color: #fff;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            padding: 15px;
        }
        .product-image {
            width: 150px;
            height: 150px;
            background-size: cover;
            background-position: center;
            border-radius: 8px;
        }
        .product-details {
            flex-grow: 1;
            padding-left: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .product-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        .product-info {
            font-size: 14px;
            color: #666;
            margin: 10px 0;
        }
        .price {
            font-size: 16px;
            font-weight: bold;
            color: #2f8d46;
        }
        .btn-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .sold-out {
            color: #f44336;
            font-weight: bold;
        }
        .add-to-cart-btn {
            background-color: #3a87ad;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .add-to-cart-btn:hover:not(:disabled) {
            background-color: #2a5b7c;
        }
        .login-message {
            color: #f44336;
            font-size: 13px;
            margin-left: 10px;
            font-weight: bold;
        }
        .control-buttons {
            margin-bottom: 30px;
            text-align: right;
        }
        .control-buttons button {
            margin-left: 10px;
            background-color: #5a9bd5;
            border: none;
            color: white;
            padding: 10px 18px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .control-buttons button:hover {
            background-color: #3a6fa3;
        }
        .cancel-cart-btn {
            display: none;
        }

        /* 모달 스타일 */
        #login-modal {
            display: none;
            position: fixed;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            z-index: 1001;
            width: 300px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        #login-modal p {
            font-size: 16px;
            font-weight: bold;
            margin: 0 0 20px 0;
            color: #333;
        }
        #login-modal .modal-buttons {
            text-align: right;
        }
        #login-modal button {
            padding: 8px 16px;
            border: none;
            background-color: #ccc;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }
        #login-modal button:hover {
            background-color: #bbb;
        }
        #login-modal a {
            padding: 8px 16px;
            background: #3a87ad;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        #login-modal a:hover {
            background-color: #2a5b7c;
        }

        #modal-backdrop {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }
    </style> 


    <!-- 인증 여부를 JS로 안전하게 넘기기 -->
    <script>
      var isAuthenticated = ${isAuthenticated};
      console.log("isAuthenticated: "+isAuthenticated);
    </script>
    
    

  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <div class="content2">
        
        <c:if test="${empty productService}">
            <div style="text-align:center; padding: 50px; font-size: 20px;">
                등록된 상품이 없습니다.
            </div>
        </c:if>
        
        
        <c:forEach var="p" items="${productService}">   
          
            <c:if test="${p.product_Registration_status eq '1'}">
                <div class="product-item" data-product-cod="${p.product_cod}" data-product-id="${p.product_id}">             
                  <c:if test="${p.imagePath ne null}">
                
                  
                      <div class="product-image" style="background-image: url('${pageContext.request.contextPath}${p.imagePath}')"></div>
                  </c:if>     
                       
                       
                          
                  
                   <c:if test="${p.imagePath eq null}">
                    <div class="product-image" style="background-image: url('${pageContext.request.contextPath}/resources/img_product/${p.product_img}')"></div>
                   </c:if>

                    <div class="product-details">
                        <div>
                            <span class="product-name">${p.product_name}</span>
                            <p class="product-info">${p.product_info}</p>
                        </div>

                        <div class="btn-area">
                            <span class="price">${p.new_price} 원</span>

                            <c:choose>
                                <c:when test="${p.product_status eq '품절'}">
                                    <span class="sold-out">품절</span>
                                </c:when>
                                <c:otherwise>
                                 <button type="button" class="add-to-cart-btn">카트에 담기</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
        <div class="control-buttons">
          <!--   <button type="button" class="add-all-to-cart-btn">전체 담기</button>
            <button type="button" class="cancel-cart-btn">장바구니 비우기</button> -->
        </div>
    </div>
        
    <div id="login-modal">
        <p>로그인이 필요합니다.</p>
        <div class="modal-buttons">
            <button onclick="closeLoginModal()">닫기</button>
            <a href="${pageContext.request.contextPath}/guest/login">로그인하러 가기</a>
        </div>
    </div>
    <div id="modal-backdrop"></div>
