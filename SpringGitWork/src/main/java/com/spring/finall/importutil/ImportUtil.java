package com.spring.finall.importutil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;




import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Component;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


import io.jsonwebtoken.io.IOException;

@Component
public class ImportUtil {

	// REST API사용을 위한 인증(access_token취득)
	public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken";

	// 결제 단건조회(고유 가맹점 주문번호 조회) API
	public static final String IMPORT_PAYMENTINFO_URL = "https://api.iamport.kr/payments/find/";

	// 결제상태기준 복수조회 API
	public static final String IMPORT_PAYMENTLIST_URL = "https://api.iamport.kr/payments/status/all";

	// 결제취소 API
	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";

	// payments.validation : payments확장기능. 결제될 내역에 대한 사전정보 등록&검증
	// POST /payments/prepare결제금액 사전등록 API
	public static final String IMPORT_PREPARE_URL = "https://api.iamport.kr/payments/prepare";

	// "아임포트 Rest Api key로 설정";
	public static final String KEY = "5813011072781514";
	// "아임포트 Rest Api Secret로 설정";
	public static final String SECRET = "VNRG31vl6jUe1vmlJjSiyrlVgy442Ft4tD9sSpwUdBwkV1lDTeFDubHI1z0Egycl6ZUnlmixdzIVw0kO";
	// "가맹점 식별코드 값으로 설정"
	public static final String IMPKEY = "imp77544746";

	// import에 토큰을 요청하는 메소드
	public String getImportToken() {
		String result = "";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
		Map<String, String> m = new HashMap<String, String>();
		m.put("imp_key", KEY);
		m.put("imp_secret", SECRET); // 맵방식이라 보낼시 받는 곳엣 폼으로 바꿔주자 :new UrlEncodedFormEntity(convertParameter(m)
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			
			HttpResponse res = client.execute(post);
			
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response");
			result = resNode.get("access_token").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	// import에 토큰을 요청하는 메소드 종료

	public String cancelPayment(String token, String merchant_uid) throws IOException {

		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL);

		Map<String, String> map = new HashMap<String, String>();
		post.setHeader("Authorization", token);
		map.put("merchant_uid", merchant_uid);
		String asd = "";
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String enty = EntityUtils.toString(res.getEntity());
			System.out.println("enty 시작");
			System.out.println(enty);
			System.out.println("enty 종료");
			JsonNode rootNode = mapper.readTree(enty);
			asd = rootNode.get("response").asText();

		} catch (Exception e) {
			e.printStackTrace();
		}
		if (asd.equals("null")) {
			System.err.println("환불실패");
			return "-1";
		} else {
			System.err.println("환불성공");
			// 외부api와 취소후 데이터베이스에 접근하자.
			//환불 성공이니 컨트롤러에서 서비스메소드 호출후 남은 자리수 다시 업데이트 추가한다.
			return "1";
		}

		
	}

	// Map을 사용해서 Http요청 파라미터를 만들어 주는 함수
	public List<NameValuePair> convertParameter(Map<String, String> paramMap) {
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Set<Entry<String, String>> entries = paramMap.entrySet();

		for (Entry<String, String> entry : entries) {
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return paramList;
	}// Map을 사용해서 Http요청 파라미터를 만들어 주는 함수 종료

////문법분석 나중에 할것
//	public String getImportToken() {
//		System.out.println("모든 API호출시 토큰발행 이 출력되어야함");
//
//		String result = "";
//		HttpClient client = HttpClientBuilder.create().build();
//		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
//		
//		Map<String, String> m = new HashMap<String, String>();
//		m.put("imp_key", KEY);
//		m.put("imp_secret", SECRET); // 맵방식이라 보낼시 받는 곳엣 폼으로 바꿔주자 :new UrlEncodedFormEntity(convertParameter(m)
//		
//		try {
//			//post 방식을 디파인 한뒤 보낼 데이터 꼴을 디파인한다.
//			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
//			//그다음 보낸다 토큰 발급해주는 api로
//			//그리고 res로 받았다.
//			HttpResponse res = client.execute(post);
//			HttpEntity entity=res.getEntity();
//			InputStream is = entity.getContent();
//			System.out.println("엔티티시작");
//			
//			System.out.println(entity);
//			System.out.println("엔티티종료");
//			BufferedReader r = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
//			String line;
//
//			while ((line = r.readLine()) != null) {
//				System.out.println("와일문");
//				System.out.println(line);
//			}
//			System.out.println("와일문종료");
//			System.out.println("토큰 발급당한시 응답객체");
//			System.out.println(res);
//			
//			  ObjectMapper mapper = new ObjectMapper();
//			  String body =EntityUtils.toString(res.getEntity());
//			  
//			  System.out.println("메퍼후 투스트링 body");
//			  System.out.println(body);
//				System.out.println(res);
//			  JsonNode rootNode = mapper.readTree(body); 
//			  JsonNode resNode = rootNode.get("response"); 
//			  result = resNode.get("access_token").asText();
//			 
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return result;
//	}

}
