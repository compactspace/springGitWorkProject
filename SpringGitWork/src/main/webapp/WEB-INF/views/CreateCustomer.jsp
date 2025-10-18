<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<style>
.defaultNone {
	display: none;
}

.representativeVali {
	display: block;
	color: #ff5862;
}
</style>


</head>
<body>
	<!-- 은행 목록은 공통코트 테이블로 따로 빼두자. -->
	<form id="customerForm" action="/yourSubmitUrl" method="POST">
		<div>
			<label for="customerName">업체명:</label> <input type="text"
				name="customerName" id="customerName" placeholder="고객명" required />
		</div>


		<div>
			<label for="phoneNumber">전화번호:</label> <select name="phonePrefix"
				id="phonePrefix" required>
				<option value="">전화번호 앞자리 선택</option>
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="017">017</option>
				<option value="019">019</option>
				<!-- 더 많은 번호를 추가 가능 -->
			</select> - <input type="text" name="phoneNumberSuffix" id="phoneNumberSuffix"
				placeholder="전화번호 뒷자리" maxlength="4" required /> - <input
				type="text" name="phoneNumberSuffix2" id="phoneNumberSuffix2"
				placeholder="전화번호 두번째 뒷자리" maxlength="4" required />
		</div>

		<div>

			<label for="representative">대표이름:</label> <select name="national"
				onchange="nationalChangeFnc(event)" id="national" required>
				<option value="ko" selected>내/외국인 선택</option>
				<option value="ko">ko</option>
				<option value="eng">eng</option>

			</select> <input type="text" name="representative" id="representative"
				placeholder="대표이름" />

			<div id="representativeError" class="defaultNone">작성예시: 대포자의
				이름은 각각 한국어와 영어 로만 작성이 가능합니다. 그외의 조합 숫자 기호등은 포함될 수 없습니다. ko ex):홍길동
				->(o) 홍d동->(x) ㅎㄱㄷ->(x) eng ex):Wilson ->(o) Wil_son->(x)
				W,ilson->(x)</div>

		</div>

		<div>
			<label for="accountNumber">계좌번호:</label> <input type="text"
				name="accountNumber" id="accountNumber" placeholder="계좌번호" />
		</div>

		<div>
			<label for="businessNumber">사업자번호:</label> <input type="text"
				name="businessNumber" id="businessNumber" placeholder="사업자번호" />
		</div>

		<div>
			<label for="postalCode">우편번호:</label> <input type="text"
				name="postalCode" id="postalCode" placeholder="우편번호" />
		</div>

		<div>
			<label for="address">주소:</label> <input type="text" name="address"
				id="address" placeholder="주소" />
		</div>

		<div>
			<label for="industry">업종:</label> <input type="text" name="industry"
				id="industry" placeholder="업종" />
		</div>

		<div>
			<input id="confirmBtn" type="button" value="저장" />
		</div>

		<h1 id="allCheckFnc">모든 유효성 확인 버튼</h1>
	</form>

	<script src="resources/js/CustomerJS/errorMassage.js">
</script>
	<script src="resources/js/CustomerJS/valiFunctions.js"></script>

	<script>	
		var formValidation = {
				customerName:false,
				phoneNumberSuffix2:false,
				representative:false
		};
		
		
		
	$("#allCheckFnc").on("click",()=>{
			console.log(formValidation)
	});
	
	
	
	
    $(document).ready(function() {   	
        
    	
        $('#customerName').on('input', (e)=> {
            let value = e.target.value;
            formValidation.customerName=customerNameVali(e);
        });        
        
        $('#phoneNumberSuffix,#phoneNumberSuffix2').on('input',(e)=>{
        	formValidation.phoneNumberSuffix2=phoneVali(e)      	
        })       
        
        
        //성을 제외하고 5글자 이내 즉 총 6글자가 멕시멈
        $("#representative").on("input",(e)=>{         	
        	console.log($("#national").val());
        	
        	let value = e.target.value;
        	let national=$("#national").val();
        	if(national=='ko'){         		
        		formValidation.representative=korepresentative(value);
        	}
        	if(national=='eng'){
        		formValidation.representative=engrepresentative(value)
        	}
        	 
        	 console.log("대표자명 유효성: "+formValidation.representative);
        	
        })  
        
       
        $("#confirmBtn").on('click',()=>{
        	
        /* 	for (var key in formValidation) {
                if (formValidation[key] === false) {
                	alert("모든 창을 입력해주세요")
                    return  // 하나라도 false이면 제출 불가
                }
            } */
        	  // 폼 데이터 생성
            var form = $("#customerForm")[0];  // form 요소를 선택
    var formData = new FormData(form);
            
    
 // FormData 객체의 내용 확인하기
  
 let phone_number=$("#phonePrefix").val()+"-"+formData.get("phoneNumberSuffix").trim()+"-"+formData.get("phoneNumberSuffix2").trim()
    
   console.log(phone_number)   
    formData.append("phone_number",phone_number)
    
    
    let jsonData = {};
      formData.forEach(function(value, key) {
    	  jsonData[key] = value;
    });
    
      console.log(jsonData); // JSON 데이터 확인   
    
    
         	 $.ajax({
        		url:"createcustomer.do",
        		type:"POST",
        		 data: JSON.stringify(jsonData),
        		contentType: "application/json",
        		success:(res)=>{        			
        			console.log(res)
        		}       		
        		
        		
        	})  
        	
        	
        })
				

    });//ready함수 종료
</script>

</body>
</html>