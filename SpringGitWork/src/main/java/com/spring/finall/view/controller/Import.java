package com.spring.finall.view.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.AftterPayService;
import com.spring.finall.user.CartService;
import com.spring.finall.user.OrderInfoService;
import com.spring.finall.user.OrderInfoVO;
import com.spring.finall.user.PayService;
import com.spring.finall.user.PayVO;
import com.spring.finall.user.ProductService;
import com.spring.finall.user.ProductVO;
import com.spring.finall.user.ReceiptService;
import com.spring.finall.user.ReceiptVO;

@Controller
public class Import {

	@Autowired
	private AftterPayService aftterPayService;

	@Autowired
	private ReceiptService receiptService;

	@Autowired
	private CartService cartservice;

	@Autowired
	private PayService payService;

	@Autowired
	private OrderInfoService orderinfo;

	@Autowired
	private ProductService productservice;

	@Autowired
	private RedisTemplate redisTemplate;

	@Autowired
	private SqlSessionTemplate mybatis;

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

	// 아임포트 인증(토큰)을 받아주는 함수
	// => 토큰을 받아야만!! 다음 API를 쓸수 있다니깐??
	// IMPORT_PAYMENTINFO_URL,IMPORT_PAYMENTLIST_URL
	// ,IMPORT_PAYMENTLIST_URL,IMPORT_CANCEL_URL



	public String getImportToken() {
		System.out.println("모든 API호출시 토큰발행 이 출력되어야함");

		String result = "";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
		Map<String, String> m = new HashMap<String, String>();
		m.put("imp_key", KEY);
		m.put("imp_secret", SECRET);
		// 맵방식이라 보낼시 받는 곳엣 폼으로 바꿔주자 :new UrlEncodedFormEntity(convertParameter(m)
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

	// Map을 사용해서 Http요청 파라미터를 만들어 주는 함수 private
	List<NameValuePair> convertParameter(Map<String, String> paramMap) {
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Set<Entry<String, String>> entries = paramMap.entrySet();
		/*
		 * Set Interface -> 순서X 중복X     Set 인터페이스는 중복 요소를 포함할 수 없으며 랜덤 액세스를 허용하지않아
		 * iterator 또는 foreach를 이용하여 요소를 탐색할 수 있다. 현재 내용이 어렵지
		 * 
		 */
		for (Entry<String, String> entry : entries) {
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return paramList;
	}

	// 아임포트 결제금액 변조는 방지하는 함수
	public void setHackCheck(String amount, String mId, String token) {
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_PREPARE_URL);
		Map<String, String> m = new HashMap<String, String>();
		post.setHeader("Authorization", token);
		m.put("amount", amount);
		m.put("merchant_uid", mId);
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			System.out.println("루트노드:" + rootNode);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 일반 상품 결제취소
	@RequestMapping(value = "/cancelpay.do", method = RequestMethod.POST)
	@ResponseBody
	public int cancelGeneralPayment(PayVO pvo, OrderInfoVO ovo, Model model) throws IOException {

		System.out.println("받은 거래번호 " + pvo.getReceipt_merchant_uid());

		int executerow = payService.cancellistcartid(pvo);
		System.out.println("나는 또한 주문 수량이 창고수량 보다 초과하는 경우 발생 executerow" + executerow);

		return executerow;
	}

	// 레디스 특가상품 결제취소
	@RequestMapping(value = "/paycan.do", method = RequestMethod.POST)
	@ResponseBody
	public int cancelPayment(HttpServletRequest request, HttpServletResponse response, Model model, ReceiptVO rvo,
			ProductVO pvo) throws IOException {
//		String mid=request.getParameter("receipt_merchant_uid");
//		String bid=request.getParameter("receipt_buyer_id");
//		System.out.println("취소메소드에서!mid 가 보여야함 "+mid);
//		System.out.println("취소메소드에서!바이어 아이디가 가 보여야함 "+bid);
//	 
//		String token = getImportToken();
//		HttpClient client = HttpClientBuilder.create().build();
//		HttpPost post = new HttpPost(IMPORT_CANCEL_URL);
//		Map<String, String> map = new HashMap<String, String>();
//		post.setHeader("Authorization", token);
//		map.put("merchant_uid", mid);
//		String asd = "";
//		try {
//			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
//			HttpResponse res = client.execute(post);
//			ObjectMapper mapper = new ObjectMapper();
//			String enty = EntityUtils.toString(res.getEntity());
//			JsonNode rootNode = mapper.readTree(enty);
//			asd = rootNode.get("response").asText();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (asd.equals("null")) {
//			System.err.println("환불실패");
//			return -1;
//		} else {
//			System.err.println("환불성공");
//			try {
//				//외부api와 취소후 데이터베이스에 접근하자.
//				
//				paycancel(rvo,pvo);
//				
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			return 1;
//		}
		paycancel(rvo, pvo);
		return 1;
	}

	// 상품결제 폼 호출:
	// UserController 에서 method = RequestMethod.GET 을 작성하였기에
	// 주석처리했슴
//	@RequestMapping(value = { "/pay", "/" }, method = RequestMethod.GET)
//	public String pay(HttpServletRequest request, Model model) {
//
//		String nm = request.getParameter("unm");

//		System.out.println("어쨋뜬 나도 서블릿 매핑!!!" + nm);
//		// 값은 아임포트의 가맹점 식별코드 입력
//		model.addAttribute("impKey", IMPKEY);
//		return "pay";
//	}

	// 결제 진행 폼=> 이곳에서 DB저장 로직도 추가하기
	@RequestMapping(value = "/pay.do", method = RequestMethod.POST)
	public void payment(HttpServletRequest request, HttpServletResponse response, Model model, ReceiptVO rvo)
			throws IOException {

		System.out.println("결제API후 트리거후 ");
		System.out.println(rvo);
		receiptService.insertReceipt(rvo);

	}

	// 레디스 특가상품 다날 결제이후 트리거에 의해 발동되는 함수
	@RequestMapping(value = "/paycomplete.do", method = RequestMethod.POST)
	@ResponseBody
	public String paymentcomplete(HttpServletRequest req, HttpServletResponse res, PayVO pvo) throws IOException {
		// 아작스로 보내는건 네임명 일치해도 커맨드 객체 됨!
//		System.out.println("아작스도 커맨드 객체 되나 테스트나 해보자.");
//	System.out.println(req.getParameter("receipt_merchant_uid"));
		System.out.println("거래번호" + pvo.getReceipt_merchant_uid());
		System.out.println("총금액" + pvo.getReceipt_paid_amount());
		System.out.println("거래자 아이디" + pvo.getId());

		// 거래한적 없으니 우선 하나 넣자.
//		pvo.setReceipt_merchant_uid("하하하하하하");
		pvo.setReceipt_paid_amount(req.getParameter("receipt_paid_amount"));
		pvo.setId(req.getParameter("id"));
		String[] cart_id = req.getParameterValues("cart_id");

		System.out.println("cart_id-->>>" + cart_id);

		// 솔직히..좋은건 아닌거 같지만 카트번호 하나당 지불여부를 업데이트 처리하자..
		// 아쉽지만 pay테이블을 제1 유형만 만족하도록 하자 하나의 주문번호=merchant_uid 에 대해 orderinfo_id를 넣자.
		for (int k = 0; k < cart_id.length; k++) {
			System.out.println(cart_id[k]);

			orderinfo.payupdate(Integer.parseInt(cart_id[k]));
			payService.insertPay(pvo, Integer.parseInt(cart_id[k]));
			cartservice.afterpaydeletecart(Integer.parseInt(cart_id[k]));

		}

		return null;

	}

	// 일반상품 다날 결제이후 트리거에 의해 발동되는 함수 인데 현 재 이는 트랜잭션 단위가 개판이니 수정중
	// 테스트용으로 잠시 , method = RequestMethod.POST 는 버림

	/**
	 * 아작스로 넘어 오는것 "receipt_merchant_uid": receipt_merchant_uid, type : javaScript
	 * String "receipt_paid_amount":$("#amount").val(), type : javaScript unmber
	 * id:$("#unm").val(),cart_id:cart_idarray , type : javaScript array
	 * "user_code":$("#user_code").val(), type : javaScript String
	 * "cart_quantity":cart_quantity, type : javaScript array
	 * "product_cod":product_cod type : javaScript array
	 * 
	 * 
	 */

	@RequestMapping(value = "/generalpaycomplete.do")
	@ResponseBody
	public int generalpaymentcomplete(HttpServletRequest req, HttpServletResponse res, PayVO pvo)
			throws IOException, PayRunTimeTranException {

		String[] cart_quantity_array = req.getParameterValues("cart_quantity");
		String[] product_cod_array = req.getParameterValues("product_cod");
		String[] cart_id = req.getParameterValues("cart_id");
		String user_code = req.getParameter("user_code");

		
		
		
		int pay_status_code = 1;
		
		try {
			aftterPayService.AftterPayUpdateService(cart_id, user_code, cart_quantity_array, product_cod_array, pvo);
		} catch (PayRunTimeTranException pre) {
			System.err.println("에러메시지:   " + pre.getMessage() + " 따라서 바로 결제 취소로 넘어갑니다.");

			System.out.println("받은 거래번호 " + pvo.getReceipt_merchant_uid());

			int executerow = payService.cancellistcartid(pvo);

			pay_status_code = -1;
			
			return pay_status_code;
		}

		return pay_status_code;

	}

	// 이는 트랜잭션과, service 로직이 너무 따로따로 호출되어 주석처리한다. 바로위 generalpaymentcomplete 메서드로
	// 대체한다.
//	@RequestMapping(value = "/generalpaycomplete2.do")
//	@Transactional
//	@ResponseBody
//	public int generalpaymentcomplete2(HttpServletRequest req, HttpServletResponse res, PayVO pvo)
//			throws IOException, PayRunTimeTranException {
//
//		int overquantity;
//
//		String[] cart_quantity_array = req.getParameterValues("cart_quantity");
//		String[] product_cod_array = req.getParameterValues("product_cod");
//
//		String[] cart_id = req.getParameterValues("cart_id");
//		String user_code = req.getParameter("user_code");
//// 아작스 파라미터도, 커맨드 객체가 반응하니 pvo.set은 주석처리했다잉		
////		pvo.setReceipt_paid_amount(req.getParameter("receipt_paid_amount"));
////		pvo.setId(req.getParameter("id"));	
////		System.out.println("카트번호 배열:  "+Arrays.toString(cart_id));
////		System.out.println("각 번호에대 해한 수량배열:  "+Arrays.toString(cart_quantity_array ));		
////		System.out.println("담긴 상품코드 배열 :  "+Arrays.toString(product_cod_array));
////		System.out.println("주문의 총 수량:  "+pvo.getReceipt_paid_amount());
////		System.out.println("주문자의 로그인 id :  "+pvo.getId());
////		System.out.println("주문자의 유저 코드: "+user_code);
//
//		// 카카오 성님들도 해당 주문 번호에대한 부분 수량 취소따윈 없다하니
//		// 주문번호=merchant_uid 여러개으 상품을 환불 처리하기 위해
//		// 주문번허도 심어야 한다..! 퍽
//		// 아쉽지만 pay테이블을 제1 유형만 만족하도록 하자 하나의 주문번호=merchant_uid 에 대해 여러개의 orderinfo_id를
//		// 넣자.
//		try {
//			for (int k = 0; k < cart_id.length; k++) {
//				// System.out.println(cart_id[k]);
//
//				// 여기서 결제가 완료된 후니 여기서 제품 테이블의 주문 수량을 삽입한다.
//				// 여기서도 논리가 꼬일 수 있다. 최초 주문자라면 인설트문이 유리 하다. 혹은 업데이트문이 유리 할수도있다.
//				// 그러나? 사용자는 여러명이라. 먼저 해당 product_order_quantity 컬럼을 조회하는 select 문도 필요하다.
//				// 따라서 select 문으로 먼저 product_order_quantity 를 조회 한후 값을 빼화
//				// 업데이트문으로 + 처리를 하자.
//
//				int ovverquantity = productservice.updateOrderQuantity(Integer.parseInt(cart_quantity_array[k]),
//						Integer.parseInt(product_cod_array[k]));
//
//				// 다시한번 말하지만 하나의 주문번호=merchant_uid 에 여러개의 카트 아이디가 있는데 환불은 모두 되어야함
//				// 부분 수량환불 이딴거 없어서 아래처럼 데이터를 넣는다.
//				// 런타임 에러 롤백이 않되 맨위에 있던 코드를 if문 아래로 내렸다. ㅂㄷ ㅂㄷ 아래로 옮겨야 주문 수량 오류 종료가 된뒤 오더인포 발급안함
//				int order_status_code = orderinfo.insertgeneralorderinfo(Integer.parseInt(cart_id[k]),
//						Integer.parseInt(user_code));
//
//				int cartUpdate_status_code = cartservice.afgerpaycartupdate(Integer.parseInt(cart_id[k]));
//
//				// 다시한번 말하지만 하나의 주문번호=merchant_uid 에 여러개의 카트 아이디가 있는데 환불은 모두 되어야함
//				// 부분 수량환불 이딴거 없어서 아래처럼 데이터를 넣는다.
//				payService.insertPay(pvo, Integer.parseInt(cart_id[k]));
//
//			}
//
//		} catch (PayRunTimeTranException payException) {
//			System.out.println("트랜잭션 실패시 매시지:  " + payException.getMessage());
//
//			// 실제 환불은 여기서 일어나니 잠시 주석처리
//			// int executerow = payService.cancellistcartid(pvo);
//
//			int pay_status_code = -1;
//			return pay_status_code;
//		}
//
//		int pay_status_code = 1;
//		return pay_status_code;
//
//	}

	@RequestMapping(value = "/completeredis.do")
	@ResponseBody
	public Integer testredis2(HttpServletRequest request, ReceiptVO rvo, ProductVO pvo, @Param("code") Object code) {

		ArrayList<Object> quantity = new ArrayList();
		ArrayList<Object> codes = new ArrayList();
		// 먼저 영수증 테이블 SELECT * FROM receipt 로 받아온다.
		List<HashMap<String, Object>> list = receiptService.testcanclequantity();
//		System.out.println(list);
//		System.out.println(list.get(0).get("receipt_product_cod"));
//		System.out.println(list.get(1).get("receipt_product_cod"));		
		System.out.println("quantity ->>>>>>" + quantity);
		for (int k = 0; k < list.size(); k++) {

			codes.add(list.get(k).get("receipt_product_cod"));
			quantity.add(list.get(k).get("receipt_paid_amount"));
		}

		HashMap<String, ArrayList<Object>> map = new HashMap<>();
		map.put("quantity", quantity);
		map.put("code", codes);

		// 상품테이블 재고를 반영 update product set product_quantity=#{quantity} where
		// product_cod=#{code}
		int check = productservice.completequantity(map);

		if (check > 0) {
			System.out.println("업데이트가 되면 내가뜸");
			return check;
		} else {
			System.out.println("실패면내가뜸");
			return check;
		}

	}

//@RequestMapping(value = "/completeredis2.do")
////테스트를 위해 아작스 응답인 리스펀스바디 주석처림
//	@ResponseBody
//	public Integer testredis23(HttpServletRequest request, ReceiptVO rvo, ProductVO pvo, @Param("code") Object code) {
//		String mid = request.getParameter("receipt_merchant_uid");
//		String bid = request.getParameter("receipt_buyer_id");
//
////		System.out.println("mid->"+mid+"___bid->>"+bid);
////		rvo.setReceipt_buyer_id(bid);
////		rvo.setReceipt_merchant_uid(mid);
//// 아오 세션 연결끊어져서 내일 수정 오늘은 테스트로 하드코딩
////		rvo.setReceipt_buyer_id("finall");
////		rvo.setReceipt_merchant_uid("1709795197941");
//
//		Object quantity = null;
//		//테스트코드를 위해 주석처리하자
//		//List<Map<String, Integer>> list = mybatis.selectList("ReceiptVO.canclequantity", rvo);
//		
//	
////		List<Map<String,Object>> list = mybatis.selectList("ReceiptVO.testcanclequantity");	
//		
//		List<HashMap<String, Object>> list =receiptService.testcanclequantity();
//		
//		//테스트를 위해 주석처리함
//		//String code = Integer.toString(list.get(0).get("receipt_product_cod"));
//		
//		 code =(list.get(0).get("code")).toString();
////		System.out.println("list-->>" + list);
//		//System.out.println("code-->>" + code);
//
//		redisTemplate.setKeySerializer(new StringRedisSerializer());
//		redisTemplate.setValueSerializer(new StringRedisSerializer());
//		redisTemplate.getValueSerializer();
//	
//		//redis get 2 에 대한 값을 가져온다.
//		quantity =	 redisTemplate.opsForValue().get(code);	
//		System.out.println("quantity ->>>>>>" + quantity);
//		
//		
////		quantity =String.valueOf(x);
////		
////		System.out.println("quantity->>>"+quantity);
//		
//		
//		//테스트를 위해 주석처리함
////		HashMap<String, String> map = new HashMap<>();
////		map.put("quantity", quantity);
////		map.put("code", code);
//		
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("quantity", quantity);
//		map.put("code", code);
//		//System.out.println("map_quantity->" + map.get("quantity") + "map_code->>" + map.get("code"));
//
//		//테스트를 위해 주석처리함
////		int check = mybatis.update("ProductVO.completequantity", map);
//
//	//	System.out.println(productservice.completequantity(map));
//		
//		
//		int check = productservice.completequantity(map);
//		
//		
//		
//		if (check > 0) {
//			System.out.println("업데이트가 되면 내가뜸");
//			return check;
//		} else {
//			System.out.println("실패면내가뜸");
//			return check;
//		}
//
//		
//	}

	public void paycancel(ReceiptVO rvo, ProductVO pvo) throws IOException {
		Object quantity = null;
		rvo.setReceipt_buyer_id("finall");
		rvo.setReceipt_merchant_uid("1709795197941");
		List<Map<String, Integer>> list = mybatis.selectList("ReceiptVO.canclequantity", rvo);
		System.out.println(list);
		Integer code = list.get(0).get("receipt_product_cod");
		redisTemplate.setKeySerializer(new StringRedisSerializer());
		redisTemplate.setValueSerializer(new StringRedisSerializer());
		redisTemplate.getValueSerializer();
		if (code != null) {
			redisTemplate.opsForValue().increment(Integer.toString(code));
			quantity = redisTemplate.opsForValue().get(Integer.toString(code));

			HashMap<String, Object> map = new HashMap<>();
			map.put("code", Integer.toString(code));
			map.put("quantity", quantity);
			map.put("id", list.get(0).get("receipt_buyer_id"));

			System.out.println("Integer.toString(code)->" + Integer.toString(code) + "_____id->>"
					+ list.get(0).get("receipt_buyer_id"));

			// 재고 반영
			mybatis.update("ProductVO.completequantity", map);
			// 소비자의 카트 수량 반영
			mybatis.delete("CartVO.dropcart", map);

		} else {

		}

	}

	public String quantitycancel(ReceiptVO rvo, ProductVO pvo, @Param("code") int code,
			@Param("quantity") Object quantity) {
		redisTemplate.setKeySerializer(new StringRedisSerializer());
		redisTemplate.setValueSerializer(new StringRedisSerializer());
		redisTemplate.getValueSerializer();
//	rvo.drop();
		System.out.println("셀렉트원 code 널인지 확인->>" + code);

		return null;
	}

	@RequestMapping(value = "/payments/complete")
	public void paymentMobile(HttpServletRequest request, HttpServletResponse response, Model model)
			throws IOException {
		String imp_uid = request.getParameter("imp_uid");
		String mid = request.getParameter("merchant_uid");
		String imp_success = request.getParameter("imp_success");
		String error_code = request.getParameter("error_code");
		String error_msg = request.getParameter("error_msg");

		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>주문완료</title></head>");
		out.println("<body>");
		out.print("고유 ID: " + imp_uid + "<br>");
		out.print("상점 거래ID: " + mid + "<br>");
		out.print("성공 여부: " + imp_success + "<br>");
		out.print("에러 코드: " + error_code + "<br>");
		out.print("에러 메세지: " + error_msg + "<br>");
		out.print("<a href='/pay'>쇼핑 계속하기</a>");
		out.print("<a href='javascript:(\"준비중입니다.\");'>나의 주문내역</a>");
		out.println("</body></html>");
	}

	// 아임포트 결제완료/취소건에 한하여 목록 반환
	// @ResponseBody 랑 짝궁 Object
	// 리퀘스트바디 어노테이션은 xml데이터나, 제이슨데이터
	@RequestMapping(value = "/payamount.do")
	@ResponseBody
	public Object getAmount(HttpServletRequest request, HttpServletResponse response, Model model, ReceiptVO vo) {
		// String mid = request.getParameter("mid");

		String mid = request.getParameter("receipt_merchant_uid");
//		String amount=request.getParameter("receipt_paid_amount");		
		String token = getImportToken();
		System.out.println("토큰값: " + token);
		System.out.println("vo값: " + vo);

		Map<String, String> map = new HashMap<String, String>();
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(IMPORT_PAYMENTINFO_URL + mid + request.getParameter("status"));
		get.setHeader("Authorization", token);
		try {
			// 여기서부터는 아작스 욫
			// 여기서 부터 외부 서버로 요청하는 코드가 들어간은거임...
			//
			HttpResponse res = client.execute(get);
			System.out.println("res.imp_uid!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + res);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response");
			System.out.println("777: " + resNode);
			if (resNode.asText().equals("null")) {
				System.out.println("내역이 없습니다.");
				map.put("msg", "내역이 없습니다.");
			} else {
				map.put("imp_uid", resNode.get("imp_uid").asText());
				map.put("merchant_uid", resNode.get("merchant_uid").asText());
				map.put("name", resNode.get("name").asText());
				map.put("buyer_name", resNode.get("buyer_name").asText());
				map.put("amount", resNode.get("amount").asText());
				payment(request, response, model, vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	// 아임포트 전체 목록 반환
	@RequestMapping(value = "/paylist")
	@ResponseBody
	public Object getlist() {
		String token = getImportToken();
		System.out.println("토큰값: " + token);
		List<Object> list = new ArrayList<Object>();
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(IMPORT_PAYMENTLIST_URL);
		get.setHeader("Authorization", token);
		try {
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response").get("list");
			System.out.println("555 rootNode: " + rootNode);
			System.out.println("555 resNode: " + resNode);

			for (int i = 0; i < resNode.size(); i++) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("imp_uid", resNode.get(i).get("imp_uid").asText());
				map.put("merchant_uid", resNode.get(i).get("merchant_uid").asText());
				map.put("name", resNode.get(i).get("name").asText());
				map.put("buyer_name", resNode.get(i).get("buyer_name").asText());
				map.put("amount", resNode.get(i).get("amount").asText());
				map.put("cancel_amount", resNode.get(i).get("cancel_amount").asText());
				map.put("failed_at", resNode.get(i).get("failed_at").asText());
				list.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
