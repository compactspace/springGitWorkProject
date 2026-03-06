package com.spring.finall.constroller;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.finall.service.OrderService;
import com.spring.finall.service.ReserveService;

@Controller
@RequestMapping("/callback") // "callback"으로 수정
public class CallBackController {

	String APIKEY = "sk_test_5F3C2D1A9B8E7F6G";

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ReserveService reserveService;
	
	private final String IMP_SECRET_KEY = "sk_test_5F3C2D1A9B8E7F6G";
	

	//HandlerAdapter → 실제 컨트롤러 호출 전, 파라미터 바인딩 시도 <- 더 상위 디버깅은 여기 문제이다, 어노테이션값 이라던지 변수바인딩등
	
	 @RequestMapping(value = "/payment", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody 
    public ResponseEntity<Map<String,Object>> paymentCallback(@RequestBody(required = false) Map<String, Object> callbackData,
    		@RequestHeader(value = "X-Signature", required = false) String signature
    		) {
		 
		 
	     Map<String,Object> errorBodyMassage= new HashMap<>();
        try {
            // 1️⃣ 콜백 데이터 추출
            String impUid = (String) callbackData.get("imp_uid");
            String merchantUid = (String) callbackData.get("merchant_uid");
            Integer amount = (Integer) callbackData.get("amount");
            String pgTid = (String) callbackData.get("pg_tid");
            String responseCode = (String) callbackData.get("response_code");
            String status = (String) callbackData.get("status");

            // 2️⃣ 필수 값 체크
            if (impUid == null || merchantUid == null || amount == null) {
            	errorBodyMassage.put("errorCode", 3001);
            	errorBodyMassage.put("errorMassage", "필수 파라미터가 없음 :fakePG서버로 부터의 콜백 요청이 아니라 다이렉트로 콜백URL공격요청임이 의심됨");
                return ResponseEntity.status(400).body(errorBodyMassage);
            }

            // 3️⃣ HMAC 서명 검증
            String payload = impUid + "|" + merchantUid + "|" + amount;
            String expectedSignature = hmacSha256(payload, IMP_SECRET_KEY);
            if (!expectedSignature.equals(signature)) {
            	errorBodyMassage.put("errorCode", 3002);
            	errorBodyMassage.put("errorMassage", "❌ HMAC 검증 실패 fakePG서버로 부터의 콜백 요청이 아니라 다이렉트로 콜백URL공격요청이 의심됨");
              
                return ResponseEntity.status(400).body(errorBodyMassage);
            }        
            
            
            Map<String,Object> paramMap= new HashMap<>();
            paramMap.put("merchant_uid", merchantUid);
         
            //3 클라이언트의 같은 주문번호에 대한 재결재 방어 - 이걸 다시 익스프레스 fakePG에서 처리하자. 아우 실수로 여기서 로직짬 씨팔
            if (orderService.duplicateOrderCheck(merchantUid)) {
            	// 여기서 다시 환불을 진행
            	errorBodyMassage.put("errorCode", 4003);
            	errorBodyMassage.put("errorMassage", "같은 주문건에 대한 재결재임.");
                return ResponseEntity.status(400).body(errorBodyMassage);
            }
            
            
       
            //가격 변조 확인
            if (!orderService.checkOneOrderAmount(paramMap,amount)) {
            	
            	errorBodyMassage.put("errorCode", 4000);
            	errorBodyMassage.put("errorMassage", "가격 위조");
                return ResponseEntity.status(400).body(errorBodyMassage);
            }

            //주문상태 펜딩을 석세스로 업데이트
            if(!orderService.updateOrderStatusToSuccess(merchantUid)) {
            	errorBodyMassage.put("errorCode", 4001);
            	errorBodyMassage.put("errorMassage", "정상 결제가 이루어 졌으나 DB상 주문정보 상태 컬럼을 업데이트 하다 실패");
            	 return ResponseEntity.status(400).body(errorBodyMassage);
            };     
            
           
            
            
            
            Map<String,Object> successBodyMassage= new HashMap<>();
            successBodyMassage.put("successCode", 2001);
            successBodyMassage.put("successMassage", "정상결제 및 가격 대조 및 DB컬럼상의 주문정보 상태가 정상정으로 반영됨");
            return ResponseEntity.status(200).body(successBodyMassage);

        } catch (Exception e) {
            e.printStackTrace();
          	errorBodyMassage.put("errorCode", 5001);
        	errorBodyMassage.put("errorMassage", e);
        	 return ResponseEntity.status(500).body(errorBodyMassage);
        }
    }

	 
	 
	 
	 

		//HandlerAdapter → 실제 컨트롤러 호출 전, 파라미터 바인딩 시도 <- 더 상위 디버깅은 여기 문제이다, 어노테이션값 이라던지 변수바인딩등
		
		 @RequestMapping(value = "/reserve-payment-callback", method = {RequestMethod.GET, RequestMethod.POST})
		@ResponseBody 
	    public ResponseEntity<Map<String,Object>> reservePaymentCallback(@RequestBody(required = false) Map<String, Object> callbackData,
	    		@RequestHeader(value = "X-Signature", required = false) String signature
	    		) {
			 
			 
		     Map<String,Object> errorBodyMassage= new HashMap<>();
	        try {
	            // 1️⃣ 콜백 데이터 추출
	            String impUid = (String) callbackData.get("imp_uid");
	            String merchantUid = (String) callbackData.get("merchant_uid");
	            Integer amount = (Integer) callbackData.get("amount");
	            String pgTid = (String) callbackData.get("pg_tid");
	            String responseCode = (String) callbackData.get("response_code");
	            String status = (String) callbackData.get("status");

	            // 2️⃣ 필수 값 체크
	            if (impUid == null || merchantUid == null || amount == null) {
	            	errorBodyMassage.put("errorCode", 3001);
	            	errorBodyMassage.put("errorMassage", "필수 파라미터가 없음 :fakePG서버로 부터의 콜백 요청이 아니라 다이렉트로 콜백URL공격요청임이 의심됨");
	                return ResponseEntity.status(400).body(errorBodyMassage);
	            }

	            // 3️⃣ HMAC 서명 검증
	            String payload = impUid + "|" + merchantUid + "|" + amount;
	            String expectedSignature = hmacSha256(payload, IMP_SECRET_KEY);
	            if (!expectedSignature.equals(signature)) {
	            	errorBodyMassage.put("errorCode", 3002);
	            	errorBodyMassage.put("errorMassage", "❌ HMAC 검증 실패 fakePG서버로 부터의 콜백 요청이 아니라 다이렉트로 콜백URL공격요청이 의심됨");
	              
	                return ResponseEntity.status(400).body(errorBodyMassage);
	            }        
	            
	            
	            Map<String,Object> paramMap= new HashMap<>();
	            paramMap.put("merchant_uid", merchantUid);
	         
	            //3 클라이언트의 같은 주문번호에 대한 재결재 방어 - 이걸 다시 익스프레스 fakePG에서 처리하자. 아우 실수로 여기서 로직짬 씨팔
	            if (reserveService.dupulicateCheckForReservePayment(merchantUid)) {
	            	// 여기서 다시 환불을 진행
	            	errorBodyMassage.put("errorCode", 4003);
	            	errorBodyMassage.put("errorMassage", "같은 주문건에 대한 재결재임.");
	                return ResponseEntity.status(400).body(errorBodyMassage);
	            }
	            
	            
	       
	            //가격 변조 확인
	            if (!reserveService.checkClientPriceEqualsToRecentUpdatedPrice(merchantUid, amount)) {
	            	
	            	errorBodyMassage.put("errorCode", 4000);
	            	errorBodyMassage.put("errorMassage", "가격 위조");
	                return ResponseEntity.status(400).body(errorBodyMassage);
	            }

	            //주문상태 펜딩을 석세스로 업데이트
	            if(!reserveService.updateDraftReserveStatusTo(merchantUid)) {
	            	errorBodyMassage.put("errorCode", 4001);
	            	errorBodyMassage.put("errorMassage", "정상 결제가 이루어 졌으나 DB상 주문정보 상태 컬럼을 업데이트 하다 실패");
	            	 return ResponseEntity.status(400).body(errorBodyMassage);
	            };     
	            
	           
	            
	            
	            
	            Map<String,Object> successBodyMassage= new HashMap<>();
	            successBodyMassage.put("successCode", 2001);
	            successBodyMassage.put("successMassage", "정상결제 및 가격 대조 및 DB컬럼상의 주문정보 상태가 정상정으로 반영됨");
	            return ResponseEntity.status(200).body(successBodyMassage);

	        } catch (Exception e) {
	            e.printStackTrace();
	          	errorBodyMassage.put("errorCode", 5001);
	        	errorBodyMassage.put("errorMassage", e);
	        	 return ResponseEntity.status(500).body(errorBodyMassage);
	        }
	    }

		 
		 
	 
	 
	 
	 
	 
    // 🔹 HMAC 생성
    private String hmacSha256(String data, String key) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        mac.init(secretKeySpec);
        byte[] hash = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(hash);
    }
    
    
    
    
    
}
