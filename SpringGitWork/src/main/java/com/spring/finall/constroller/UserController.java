package com.spring.finall.constroller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.aspectj.lang.annotation.Aspect;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.RabitEvent.ReserveEvent;
import com.spring.finall.apiResponseController.ApiResponse;
import com.spring.finall.businessresult.ArtWorkImagesDeleteResult;
import com.spring.finall.businessresult.CheckCurrentPwdResult;
import com.spring.finall.businessresult.SmsSendResult;
import com.spring.finall.exception.artworkexception.ArtWorkCompleteException;
import com.spring.finall.exception.common.BusinessException;
import com.spring.finall.exception.requestRefund.RequestRefundException;
import com.spring.finall.impl.SmsServiceRedisDao;
import com.spring.finall.impl.WorkServcieRedisDao;
import com.spring.finall.redisutil.RedisUtil;
import com.spring.finall.reqDto.orderRequest.OrderItemDTO;
import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.payMentRequest.PaymentDTO;
import com.spring.finall.reqDto.refundRequest.ProductRefundDTO;
import com.spring.finall.reqDto.wrapperRequest.OrderPaymentRequestDTO;
import com.spring.finall.reqDto.writeWorkComment.WorkCommentDTO;
import com.spring.finall.security.SecurityUserVO;
import com.spring.finall.security.SecurityUserVOService;
import com.spring.finall.security.UserDetailsVO2;
import com.spring.finall.service.ArtworkService;
import com.spring.finall.service.DraftReserveinfoService;
import com.spring.finall.service.ManageProductService;
import com.spring.finall.service.MemberService;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.service.OrderService;
import com.spring.finall.service.ProductRefundService;
import com.spring.finall.service.ReserveService;
import com.spring.finall.service.SmsService;
import com.spring.finall.service.WorkService;
import com.spring.finall.user.ArtWorkCommentVO;
import com.spring.finall.user.CartService;
import com.spring.finall.user.CartVO;
import com.spring.finall.user.OneDayClassVO;
import com.spring.finall.user.OrderInfoService;
import com.spring.finall.user.OrderInfoVO;
import com.spring.finall.user.PayService;
import com.spring.finall.user.PayVO;
import com.spring.finall.user.UserVO;

@Aspect
@Controller
@RequestMapping("/api/users")
public class UserController {

	// REST API사용을 위한 인증(access_token취득)
	public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken";

	// 결제 단건조회(고유 가맹점 주문번호 조회) API
	public static final String IMPORT_PAYMENTINFO_URL = "https://api.iamport.kr/payments/find/";

	// 결제상태기준 복수조회 API
	public static final String IMPORT_PAYMENTLIST_URL = "https://api.iamport.kr/payments/status/all";

	// 결제취소 API
	public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";

	// payments.validation : ments확장기능. 결제될 내역에 대한 사전정보 등록&검증
	// POST /payments/prepare결제금액 사전등록 API
	public static final String IMPORT_PREPARE_URL = "https://api.iamport.kr/payments/prepare";

	// "아임포트 Rest Api key로 설정";
	public static final String KEY = "5813011072781514";
	// "아임포트 Rest Api Secret로 설정";
	public static final String SECRET = "VNRG31vl6jUe1vmlJjSiyrlVgy442Ft4tD9sSpwUdBwkV1lDTeFDubHI1z0Egycl6ZUnlmixdzIVw0kO";
	// "가맹점 식별코드 값으로 설정"
	public static final String IMPKEY = "imp77544746";

	@Autowired
	private SmsService smsService;

	@Autowired
	private SmsServiceRedisDao smsServiceDao;

	@Autowired
	private WorkServcieRedisDao workServiceRedisDao;

	@Autowired
	private ManageProductService manageProductService;

	boolean PASSWORDCHANGE;

	// 서비스호출위해 자동주입

	@Autowired
	private RedisTemplate<String, String> redisTemplate;

	@Autowired
	private RedisUtil redisutil;

	@Autowired
	private PayService payService;

	@Autowired
	private ReserveService reserveService;

	@Autowired
	private WorkService workService;

	@Autowired
	private CartService cartService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private SecurityUserVOService SecurityUserVOService;

	@Autowired
	private OrderInfoService orderInfoService;

	@Autowired
	private OneDayClassService OneDayClassService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ArtworkService artworkService;

	@Autowired
	private ProductRefundService productRefundService;
	
	@Autowired
	private DraftReserveinfoService draftReserveinfoService;
	
	

	@Autowired
	private RabbitTemplate rabbitTemplate;

	@RequestMapping(value = "/403", method = { RequestMethod.GET, RequestMethod.POST })
	public String error403() {
		System.out.println("권하이 없다꼬요");
		return "403";
	}

	@PostMapping("/after-successpayment-complement")
	@ResponseBody
	public ApiResponse<Boolean> afterSuccesspaymentComplement(
			@RequestBody OrderPaymentRequestDTO OrderPaymentRequestDTO, @AuthenticationPrincipal UserDetailsVO2 user) {

		int userCode = user.getUser_code();

		OrderRequestDTO orderRequestDTO = OrderPaymentRequestDTO.getOrder();

		orderRequestDTO.setUserCode(userCode);

		orderRequestDTO.toStringLog();
		PaymentDTO paymentDTO = OrderPaymentRequestDTO.getPayment();
		paymentDTO.toStringLog();

		// afterSuccesspaymentComplement

		try {
			orderService.afterSuccesspaymentComplement(orderRequestDTO, paymentDTO);
			return ApiResponse.<Boolean>builder().code(201).success(true).message("결제 성공").data(true).build();
		} catch (Exception e) {
			System.err.println("[ERROR] 주문 처리 중 예외 발생: " + e.getMessage());
			return ApiResponse.<Boolean>builder().code(500).success(false).message("결제 실패").data(false).build();
		}
	}

	@PostMapping("/stock-check")
	public ResponseEntity<?> stockCheck(@RequestBody List<Map<String, Object>> items) {

		for (Map<String, Object> item : items) {
			Long productId = Long.valueOf(item.get("productId").toString());
			Integer quantity = Integer.valueOf(item.get("quantity").toString());

		}

		List<Map<String, Object>> possibleStock = manageProductService.stockCheck(items);

		return ResponseEntity.ok(possibleStock);
	}

	@RequestMapping(value = "/update-draft-order", method = RequestMethod.POST)
	@ResponseBody
	public String updateDraftOrder(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			@RequestParam("product_id") List<String> productIds,
			@RequestParam("cart_quantity") List<Integer> quantities,
			@RequestParam("pricePerUnit") List<Integer> pricePerUnit, // 새로 추가된 단가
			@RequestParam("product_name") List<String> productNames, @RequestParam("finallsum") String finallsum,
			Model model) {
		System.out.println("업데이트전 최종 합계: " + finallsum);
		// 데이터 출력 (디버깅용)
		for (int i = 0; i < productIds.size(); i++) {
			System.out.println("상품 ID: " + productIds.get(i));
			System.out.println("상품 이름: " + productNames.get(i));
			System.out.println("수량: " + quantities.get(i));
			System.out.println("단가: " + pricePerUnit.get(i));
		}

		System.out.println("업데이트후 최종 합계: " + finallsum);

		int userCode = userDetails.getUser_code();
		OrderRequestDTO orderRequestDTO = new OrderRequestDTO();

		List<OrderItemDTO> orderItemDTOlist = new ArrayList<OrderItemDTO>();
		// orderRequestDTO.getItems() -> OrderItemDTO

		int totalPrice = Integer.parseInt(finallsum.replace(",", ""));
		System.out.println(totalPrice); // 20400

		int totalQuantities = 0;
		for (int i = 0; i < productIds.size(); i++) {
			OrderItemDTO orderItem = new OrderItemDTO();

			orderItem.setProductId(Long.valueOf(productIds.get(i)));
			orderItem.setProductName(productNames.get(i));
			orderItem.setQuantity(quantities.get(i));
			orderItem.setPricePerUnit(pricePerUnit.get(i));

			orderItemDTOlist.add(orderItem); // 세팅 후 리스트에 추가
			orderItem = null;
			totalQuantities += quantities.get(i);

		}
		orderRequestDTO.setItems(orderItemDTOlist);
		orderRequestDTO.setUserCode(userCode);

		String user_id = String.valueOf(userDetails.getUser_code());

		Map<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("draft_total_quantity", totalQuantities);
		params.put("draft_total_amount", totalPrice);

		String merchant_uid = orderService.checkoutDraftOrder(params, orderRequestDTO);
		return "orderSuccess"; // 성공적인 응답 후 이동할 페이지명
	}

	@RequestMapping(value = "/update-draft-status-cancle", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> updateDraftStatusCancle(@AuthenticationPrincipal UserDetailsVO2 userDetails) {

		String user_id = String.valueOf(userDetails.getUser_code());
		boolean statusCancle = orderService.updateDraftStatusCancle(user_id);

		Map<String, Object> bodyData = new HashMap<>();

		try {

			bodyData.put("statusCancle", statusCancle);

			return ResponseEntity.status(200).body(bodyData);

		} catch (Exception e) {

			bodyData.put("statusCancle", statusCancle);

			return ResponseEntity.status(500).body(bodyData);

		}

	}

	@PostMapping("/payment")
	@ResponseBody
	public ApiResponse<Boolean> processPayment(@RequestBody OrderPaymentRequestDTO OrderPaymentRequestDTO,
			@AuthenticationPrincipal UserDetailsVO2 user) {

		int userCode = user.getUser_code();

		OrderRequestDTO orderRequestDTO = OrderPaymentRequestDTO.getOrder();

		orderRequestDTO.setUserCode(userCode);

		orderRequestDTO.toStringLog();
		PaymentDTO paymentDTO = OrderPaymentRequestDTO.getPayment();
		paymentDTO.toStringLog();

		try {
			orderService.placeOrder(orderRequestDTO, paymentDTO); // 내부에서 트랜잭션 처리
			return ApiResponse.<Boolean>builder().code(201).success(true).message("결제 성공").data(true).build();
		} catch (Exception e) {
			System.err.println("[ERROR] 주문 처리 중 예외 발생: " + e.getMessage());
			return ApiResponse.<Boolean>builder().code(500).success(false).message("결제 실패").data(false).build();
		}
	}

	@PostMapping("/request-refund")
	@ResponseBody
	public ResponseEntity<ApiResponse<Boolean>> requestRefund(@AuthenticationPrincipal UserDetailsVO2 user,
			@RequestBody ProductRefundDTO refundDto) {

		ApiResponse<Boolean> response = null;

		try {

			boolean requestSuccess = productRefundService.reqeustRefund(refundDto);
			if (requestSuccess) {
				response = ApiResponse.<Boolean>builder().code(201).success(true).message("환불 요청이 정상적으로 접수되었습니다.")
						.data(true).build();
				return ResponseEntity.status(200).body(response);
			} else {

				response = ApiResponse.<Boolean>builder().code(50001).success(false).message("환불 신청시 에러").data(false)
						.build();
				return ResponseEntity.status(500).body(response);
			}

		} catch (RequestRefundException e) {

			response = ApiResponse.<Boolean>builder().code(50001).success(false).message(e.getMessage()).data(false)
					.build();
			return ResponseEntity.status(500).body(response);

		}

	}

	// 일반 상품을 카트에 추가 하는 매핑
	// 특가 상품과는 다르게 오더 인포테이블은 여기서 건드리지 않을 것임
	@RequestMapping(value = "/generaladdcart.do")
	@ResponseBody
	public int generaladdcart(CartVO vo, HttpSession session, Model model, HttpServletRequest req,
			@Param("id") String id) throws UnsupportedEncodingException {

		int executerow = (Integer) cartService.generalproductlist(vo);

		return executerow;
	}

	// 레디스 특가상품 전용 카드
	@RequestMapping(value = "/addcart.do")
	@ResponseBody
	public String addcart(CartVO vo, OrderInfoVO ovo, HttpSession session, Model model, HttpServletRequest req,
			@Param("id") String id) throws UnsupportedEncodingException {
		req.setCharacterEncoding("UTF-8");
		// 먼저 레디스에 있는 클라인지 확인하자.
		String check = addredis(req);

		id = req.getParameter("id");

		if (check.equals("1")) {

			Integer cartid = (Integer) cartService.addcart(vo);
			ovo.setCart_id(cartid);
			ovo.setUser_code((Integer) session.getAttribute("user_code"));

			orderInfoService.insertorderinfo(ovo);

			return "1";
		} else if (check.equals("0")) {

			return "0";
		} else {
			return "-1";
		}

	}

	@PostMapping("/request-sms-code")
	@ResponseBody
	public ApiResponse<SmsSendResult> requestSmsCode(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			HttpServletRequest req, @RequestParam("phone") String phone, Model model) {

		String userId = userDetails.getId();

		// 서비스에 위임
		SmsSendResult result = smsService.requestSmsCode(userId, phone, req.getSession(), model);

		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (result.isSuccess()) {
			return ApiResponse.<SmsSendResult>builder().code(201).success(true).message("인증번호가 발송되었습니다.").data(result)
					.build();
		} else {
			return ApiResponse.<SmsSendResult>builder().code(201).success(true).message(result.getStatus()).data(result)
					.build();
		}
	}

	@PostMapping("/remove-smsCoolDown")
	@ResponseBody
	public ApiResponse<String> removeSmsCooldown(HttpServletRequest req) {
		HttpSession session = req.getSession();
		ApiResponse<String> response = null;
		try {
			smsService.removeSmsCooldown(session);
			response = ApiResponse.<String>builder().code(201).success(true).message("쿨다운 세션제거").data(null).build();
		} catch (Exception e) {
			System.out.println(e);
			response = ApiResponse.<String>builder().code(500) // 실패이므로 201 보단 500같은 에러 코드가 맞겠네요.
					.success(false).message("쿨다운 세션제거 실패").data(null).build();
		} finally {
			return response;
		}
	}

	@PostMapping("/verify-sms-code")
	@ResponseBody
	public ApiResponse<SmsSendResult> verifySmsCode(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			HttpServletRequest req, @RequestParam("code") String inputCode, @RequestParam("token") String token,
			Model model) {

		String userId = userDetails.getId();
		HttpSession session = req.getSession();
		SmsSendResult smsSendResult = smsService.verifySmsCode(userId, session, inputCode, token);

		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (smsSendResult.isSuccess()) {
			model.addAttribute("smsVerified", true);
			return ApiResponse.<SmsSendResult>builder().code(201).success(true).message("인증이 완료되었습니다.")
					.data(smsSendResult).build();
		} else {
			return ApiResponse.<SmsSendResult>builder().code(201).success(true).message("인증 실패").data(smsSendResult)
					.build();
		}
	}

	// 코멘트
	@RequestMapping(value = "/write-work-comments", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> writeWorkComments(@Valid WorkCommentDTO workCommentDTO,
			BindingResult bindingResult, @AuthenticationPrincipal UserDetailsVO2 userDetail, Model model,
			HttpServletRequest req) {

		int userCode = userDetail.getUser_code();

		Map<String, Object> map = new HashMap<>();
		if (bindingResult.hasErrors()) {
			String errorMsg = bindingResult.getAllErrors().get(0).getDefaultMessage();
			map.put("falseCauz", "댓글달 내용이 없습니다.");
			return ResponseEntity.badRequest().header("Content-Type", "application/json; charset=UTF-8").body(map);
		}

		Map<Object, Object> dangerousUser = workServiceRedisDao.getAttemptCntDangerousUser(userCode);
		if (dangerousUser != null && !dangerousUser.isEmpty()) {
			map.put("success", false);
			map.put("falseCauz", "해당 댓글 서비스를 이용할 수 없습니다. 서비스 이용에 제한되었습니다 관리자에게 문의해주세요");
			return ResponseEntity.ok().header("Content-Type", "application/json; charset=UTF-8").body(map);
		}

		Long attemptCnt = workServiceRedisDao.getAttemptCntCommentWrite(workCommentDTO, userCode);

		if (attemptCnt >= 3) {
			map.put("success", false);
			map.put("falseCauz", "너무 빠른삽입입니다.");
			return ResponseEntity.ok().header("Content-Type", "application/json; charset=UTF-8").body(map);
		}

		Long commentId = workService.writeWorkComment(workCommentDTO, userCode);

		if (commentId != null && commentId > 0) {
			map.put("success", true);
			map.put("commentId", commentId);
			return ResponseEntity.ok().header("Content-Type", "application/json; charset=UTF-8").body(map);
		} else {
			map.put("success", false);
			return ResponseEntity.ok().header("Content-Type", "application/json; charset=UTF-8").body(map);
		}
	}

	public String addredis(HttpServletRequest req) {
		redisutil.RedisAllSerializer();

		String checkid = req.getParameter("id");
		String checkpcode = req.getParameter("product_cod");
		HashMap<String, Object> dateMap = new HashMap<String, Object>();
		// key 명이 userInfo 이고, 가르키는게 HashMap 형태인 필드명 checkid 과 필드값 checkid 이다.
		String isAlreadyid = (String) redisTemplate.opsForHash().get("isExist", checkid);
		String isAlreadycode = (String) redisTemplate.opsForHash().get("isExist",
				"checkpcode" + checkid + req.getParameter("product_cod"));

		// 널포인트 익셉션 그냥 if로 처리하자.
		if (redisTemplate.opsForValue().get(checkpcode) == null) {
			return "0";
		}

		Integer isZero = Integer.parseInt((String) redisTemplate.opsForValue().get(checkpcode));

		if (isZero == 0) {

			return "0";

		} else {

			if (isAlreadyid == null || !isAlreadyid.equals(checkid)) {
				dateMap.put(checkid, checkid);
				dateMap.put("checkpcode" + checkid + req.getParameter("product_cod"), checkpcode);
				System.out.println("레디에 에 없는 값으로 생성");
				// redis에 Hash 형태로 삽입시는 다음 set 함수들 4개가 모두 필요하다.
				redisTemplate.opsForHash().putAll("isExist", dateMap);
				// decrement 함수는 redis 자료형이 숫자인 경우 key 명을 입력시 -1씩 감소시킨다.
				redisTemplate.opsForValue().decrement(req.getParameter("product_cod"));

				return "1";
			} else if (isAlreadycode == null || isAlreadyid.equals(checkid)) {
				System.out.println("isAlreadycode->>" + isAlreadycode);

				boolean checks = redisTemplate.opsForHash().hasKey("isExist",
						"checkpcode" + checkid + req.getParameter("product_cod"));

				if (checks) {
					System.out.println("레디스에 있는 값이니노생성");
					return "-1";
				} else {
					dateMap.put("checkpcode" + checkid + req.getParameter("product_cod"), checkpcode);
					redisTemplate.opsForHash().putAll("isExist", dateMap);
					redisTemplate.opsForValue().decrement(req.getParameter("product_cod"));

					return "1";
				}

			} else {

				System.out.println("레디스에 있는 값이니노생성");

				return "-1";
			}

		}

	}

	public boolean cancleredis(HttpServletRequest req) {

		// 나중 로그인자 아이디로 집어넣을시 주석을 해제하자.
		String checkid = req.getParameter("id");
//		String checkid = "Test";

		HashMap<String, Object> dateMap = new HashMap<String, Object>();
		dateMap.put(checkid, checkid);

		String test = (String) redisTemplate.opsForHash().get("userInfo", checkid);
		System.out.println("test=>>>" + test);

		if (test == null || !test.equals(checkid)) {
			System.out.println("레디에 에 없는 값으로 생성");

			redisTemplate.setKeySerializer(new StringRedisSerializer());
			redisTemplate.setValueSerializer(new StringRedisSerializer());
			redisTemplate.opsForHash().putAll("userInfo", dateMap);
			redisTemplate.opsForValue().decrement("2");

			return true;
		} else {

			System.out.println("레디스에 있는 값이니노생성");

			return false;
		}

		// 데이터 조회
//		String email = (String) redisTemplate.opsForHash().get("userInfo", "email");
//		String mobile = (String) redisTemplate.opsForHash().get("userInfo", "mobile");
//		

	}

//	@RequestMapping(value = "/plusoneajaxaddcart.do")
//	@ResponseBody
//	public int plusoneajaxaddcart(CartVO vo, Model model, HttpServletRequest req) {
//		vo.setId(req.getParameter("id"));
//		vo.setProduct_cod(Integer.parseInt(req.getParameter("product_cods")));
//		vo.setPlusone(Integer.parseInt(req.getParameter("plusone")));
//
//		cartService.addcart(vo);
//		int updateone = updateone(vo, model, req);
//
//		return updateone;
//
//	}

//	public int updateone(CartVO vo, Model model, HttpServletRequest req) {
//
//		System.out.println("req.getParameter(\"id\")->>>>>>>>>>>>>" + req.getParameter("id"));
//		model.addAttribute("mycart", cartService.cartlist(vo));
//
//		List<CartVO> listone = cartService.getupdateOne(vo);
//		for (CartVO voc : listone) {
//			System.out.println("voc->" + voc.getCart_quantity());
//		}
//
//		return listone.get(0).getCart_quantity();
//
//	}

	// 일반 상품 카트 버리기
	@RequestMapping(value = "/dropgeneralcart.do")
	@ResponseBody
	public int dropcart(CartVO vo, HttpServletRequest req) {
		// ParameterValues 는 대략 배열로 여러개의 파라미터를 받는다.

		System.out.println("뭐가오나->" + req.getParameterValues("cart_idarry"));
		String[] cart_idarry = req.getParameterValues("cart_idarry");
		int executequery;
		try {
			for (int i = 0; i < cart_idarry.length; i++) {
				System.out.println("카트번호->" + cart_idarry[i]);
				vo.setCart_id(Integer.parseInt(cart_idarry[i]));
				cartService.dropgeneralcart(vo);

			}

			executequery = 1;
		} catch (Exception e) {
			executequery = -1;
		}

		return executequery;

	}

	// 일반 상품 장바구니에서 수량 + - 하는 함수
	@RequestMapping(value = "/plusminus.do")
	@ResponseBody
	public int plusminus(CartVO vo, Model model, HttpServletRequest req) {

		Integer executequery = cartService.plusminus(vo);
		return executequery;

	}

	@RequestMapping(value = "/pay.do", method = RequestMethod.GET)
	public String cartlist(@RequestParam(value = "finallsum", required = false) String finallsum, CartVO vo,
			Model model, HttpServletRequest req) {
		System.out.println("+req.getParameter(\"id\")->>>>>" + req.getParameter("id"));

//			req.setAttribute("finallsum", vo.setFinallsum(req.getParameter(finallsum)));
		model.addAttribute("pay", finallsum);
		model.addAttribute("id", req.getParameter("id"));
		model.addAttribute("impKey", IMPKEY);
		System.out.println("그냥 확인용");

		return "pay";

	}

	@RequestMapping(value = "/modalpay.do", method = RequestMethod.GET)
	@ResponseBody
	public List<String> modalcartlist(@RequestParam(value = "finallsum", required = false) String finallsum, CartVO vo,
			Model model, HttpServletRequest req) {
		System.out.println("+req.getParameter(\"id\")->>>>>" + req.getParameter("id"));

//			req.setAttribute("finallsum", vo.setFinallsum(req.getParameter(finallsum)));

		List<String> modalpayList = new ArrayList();
		modalpayList.add(0, finallsum);
		modalpayList.add(1, req.getParameter("id"));
		modalpayList.add(2, IMPKEY);

		/*
		 * model.addAttribute("pay", finallsum); model.addAttribute("id",
		 * req.getParameter("id")); model.addAttribute("impKey", IMPKEY);
		 */

		return modalpayList;

	}

// 회원가입전 이미 있는 아이디 인지 체그하는 아작스 호출 종료

	// 시큐리티 회원가입전 이미 있는 아이디 인지 체그하는 아작스 호출
	@RequestMapping(value = "/securitycheckid.do")
	@ResponseBody
	public boolean isduplicateId(SecurityUserVO vo, HttpSession session, HttpServletRequest req) throws Exception {

		int executerow = SecurityUserVOService.checkidMembership(vo);

		if (executerow <= 0) {
			// 확인함 리퀘스트 매핑 삭제시 리턴값을 전달도 못하고 오류남
			return true;
		} else {
			return false;
		}

	} // 회원가입전 이미 있는 아이디 인지 체그하는 아작스 호출 종료

	// 회원가입 시작! 바로위 아작스 처리후 주석 해제할것
	// 여기 url에서 새로고침하면 자꾸 데이터들어감 우찌 고치냐

//바로 밑에 있는 로그인 시도 login 메소드를 도와주는  일반 메소드로
//아이디있는지 없는지 를 먼저 판별하게 해준다.
	public boolean isexistid(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {
		boolean check = memberService.checkidMembershiptwo(vo);
		if (check) {
			System.out.println("있는 아이디라면  isexistid 호출됨" + check);
			return check;
		} else {
			System.out.println("없는아이디" + check);
			return check;
		}

	}// 로그인 시 있는 아이디 인지 함수종료

	// 회원가입 시작! 바로위 아작스 처리후 주석 해제할것
	// 여기 url에서 새로고침하면 자꾸 데이터들어감 우찌 고치냐
	@RequestMapping(value = "/securitysignup.do")
	@ResponseBody
	public String signupsecurityMembership(SecurityUserVO vo, HttpSession session) throws Exception {

		String password = BCrypt.hashpw(vo.getUser_pwd(), BCrypt.gensalt());
		vo.setUser_pwd(password);
		System.out.println(password);
		// 현재 날짜 및 시간 가져오기
		Date currentDate = new Date();
		// 원하는 형식으로 날짜 및 시간 포맷팅
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");

		String formattedDateTime = dateFormat.format(currentDate);

		// 결과 출력
		System.out.println("현재 시각: " + formattedDateTime);
		vo.setUser_create(formattedDateTime);

		try {

			SecurityUserVOService.insertMembership(vo);
			// memberService.insertMembership(vo);
			return "signupsuccess";

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("내가뜨면 아이디 유니크제약조건위배");
			return "signupfalse";
		}

//			return "login.jsp";

	}// 회원가입 종료

	@RequestMapping(value = "/loginpage.do")
	public String loginpage() {

		return "securityloginform";
	}

	// 로그인시도시작
	@RequestMapping(value = "/login.do")

	public String login(UserVO vo, HttpSession session, HttpServletRequest req) throws Exception {

		if (isexistid(vo, session, req)) {
			// memberService.getHashedPassword(vo);

			// 여기서 sql 인잭션이 막히는듯???
			boolean ispasswrodback = BCrypt.checkpw(vo.getPassword(), memberService.getHashedPassword(vo));

			if (ispasswrodback) {

				Integer user_code = memberService.selectmainhomeuser_code(vo);

				if (vo != null) {
					vo.setUser_where("finalluser");
					session.setAttribute("userId", vo.getId());
					session.setAttribute("user_code", user_code);
					session.setAttribute("user_where", vo.getUser_where());
					System.out.println("vo.getUser_where()->>" + vo.getUser_where());

					return "mainhome";
				}

			} else {

				return "login";
			}
		}

		return "login";

	}// 로그인시도 종료

//  개인정보수정중  원래비밀번호먼저확인하기 아작스

	// 비밀번호 변경 아작스 !
	// 네임값도 겹치니 그냥 아작스로 처리
	@RequestMapping(value = "/changepassword.do")
	@ResponseBody
	public boolean changepasswordcomplete(UserVO vo, HttpServletResponse response, HttpSession session,
			HttpServletRequest req) throws Exception {
		String afterpassword = vo.getAfterpassword();
		System.out.println("암호화전 afterpassword->>>>" + afterpassword);
		// 비밀번호 + salt로 암호화된 비밀번호 생성
		afterpassword = BCrypt.hashpw(afterpassword, BCrypt.gensalt());
		// vo.setPassword(memberService.loginpasswordMembership(vo));
		System.out.println("암호화후->>" + afterpassword);

		vo.setAfterpassword(afterpassword);
		int check = memberService.changepasswordcomplete(vo);

		if (check == 1) {
			// 당연히 비번을 변경했으니 기존 세션연결을 해지한다.
			session.setAttribute("userId", null);
			PASSWORDCHANGE = true;
			return PASSWORDCHANGE;
		} else {
			PASSWORDCHANGE = false;
			return PASSWORDCHANGE;
		}

	}

	// 로그아웃시도
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:mainhome";
	}

	@RequestMapping(value = "/selectOneDayClass.do")
	@ResponseBody
	public List<OneDayClassVO> selectOneDayClass(OneDayClassVO vo, HttpServletResponse response, HttpSession session,
			HttpServletRequest req) throws Exception {

		List<OneDayClassVO> onedayselect = OneDayClassService.selectOneDayClass(vo);
		System.out.println("onedayselect->>>" + onedayselect);
		return onedayselect;

	}

	@RequestMapping(value = "/onedayclasssubmit.do")
	public String onedayclasssubmit(OneDayClassVO vo, Model model, HttpServletRequest req) throws Exception {

		List<OneDayClassVO> onedayselect = OneDayClassService.selectOneDayClass(vo);
		model.addAttribute("firstonedayclass", onedayselect);

		for (OneDayClassVO rseult : onedayselect) {
			System.out.println("클래스 고유번호  " + rseult.getOnedayclass_num());
			System.out.println("클래스 이름  " + rseult.getOnedayclass_name());
		}

		return "onedayclasssubmit";

	}

	// 결제현황
	@RequestMapping(value = "/mypayinfo.do")
	public String mypayinfo(PayVO pvo, Model model, HttpSession session) {

		// 결제 가맹점번호는 잠시 하드코딩처리
		pvo.setReceipt_merchant_uid("sdff");

		List<PayVO> mypayinfo = payService.showpaylist(pvo);

		model.addAttribute("mypayinfo", mypayinfo);
		session.setAttribute("empty", mypayinfo);

		return "mypayinfo";

	}

	// 단건 결제 상세조회 현황 및 취소
	// 카카오 성님들도 해당 주문 번호에대한 부분 수량 취소따윈 없다하니
	// 각 주문번호마다 여러개으 상품을 환불 처리하기 위해
	// 주문번허도 심어야 한다..! 퍽
	@RequestMapping(value = "/mypaydetailinfo.do")
	public String mypaydetailinfo(UserVO uvo, PayVO pvo, Model model, HttpServletRequest req, HttpSession session) {

		List<PayVO> mypaydetailinfo = payService.mypaydetailinfo(uvo, pvo);

		model.addAttribute("mypaydetailinfo", mypaydetailinfo);
		String status = req.getParameter("status");
		if (status.equals("cancel")) {
			model.addAttribute("iscancelinfo", "cancelinfo");
		} else if (status.equals("pay")) {
			model.addAttribute("iscancelinfo", "payinfo");
		}

		session.setAttribute("empty", mypaydetailinfo);

		return "mypaydetailinfo";

	}

//  참고
	@RequestMapping(value = "/checkpassword")
	@ResponseBody
	public ApiResponse<CheckCurrentPwdResult> changepassword(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			@RequestParam("currentPassword") String currentPassword, UserVO userVO, HttpSession session,
			HttpServletRequest req) throws Exception {
		String userId = userDetails.getId();

		Long attemptCnt = memberService.isPasswordFailLimitExceeded(userId);

		if (attemptCnt >= 3) {
			smsServiceDao.removeVerified(userId);
			CheckCurrentPwdResult checkCurrentPwdResult = new CheckCurrentPwdResult(attemptCnt, false);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true)
					.message("3회 초과하였습니다." + "" + "관리자에게 문의 바랍니다.").data(checkCurrentPwdResult).build();
		}

		userVO.setId(userId);
		String HahsedPwd = memberService.getHashedPassword(userVO);

		if (HahsedPwd == null) {

			memberService.incrementPasswordFailCount(userId);
			attemptCnt = memberService.isPasswordFailLimitExceeded(userId); // 증가된 값 반영
			CheckCurrentPwdResult checkCurrentPwdResult = new CheckCurrentPwdResult(attemptCnt, false);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true).message("비밀번호가 일치하지 않습니다.")
					.data(checkCurrentPwdResult).build();
		}

		String currentUnHashPwd = userVO.getPassword();
		boolean checkpassword = BCrypt.checkpw(currentUnHashPwd, HahsedPwd);
		System.out.println("ispasswrodback->>>>>>>>>>" + checkpassword);

		if (checkpassword) {
			CheckCurrentPwdResult checkCurrentPwdResult = new CheckCurrentPwdResult(attemptCnt, true);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true).message("비밀번호가 확인되었습니다.")
					.data(checkCurrentPwdResult).build();

		} else {
			memberService.incrementPasswordFailCount(userId);
			attemptCnt = memberService.isPasswordFailLimitExceeded(userId); // 증가된 값 반영
			CheckCurrentPwdResult checkCurrentPwdResult = new CheckCurrentPwdResult(attemptCnt, false);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true).message("비밀번호가 일치하지 않습니다.")
					.data(checkCurrentPwdResult).build();
		}

	}

	@RequestMapping(value = "/onedayclass-applicant")
	@ResponseBody
	public Object onedayclassApplicant(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			@RequestParam Map<String, Object> paramMap) {
		String userId = userDetails.getId();
		int user_code = userDetails.getUser_code();
		// ✅ merchant_uid 생성
		String merchant_uid = "order_" + userId + "_" + System.currentTimeMillis();

		// ✅ paramMap에 추가
		paramMap.put("merchant_uid", merchant_uid);
		paramMap.put("user_code", user_code);
		paramMap.put("payment_method", "Credit Card");

		try {

			// 스프링상의 payment 정보 삽입
			ReserveEvent reserveEvent = new ReserveEvent();
			reserveEvent.setUserCode(user_code);
			reserveEvent.setPaymentMethod("Credit Card");
			reserveEvent.setMerchantUid(merchant_uid);
			// orderQueue에 메시지 발행
			rabbitTemplate.convertAndSend("reserveQueue", reserveEvent);

			reserveService.makeReservation(paramMap);

			return ApiResponse.<Boolean>builder().code(201).success(true).message("결제 성공").data(true).build();
		} catch (BusinessException be) {
			System.err.println("그새 선생님의 마감으로 예약 결제 환불 API호출!!: " + be.getMessage());

			// 자동환불 로직 구현해라 여기서

			return ApiResponse.<Boolean>builder().code(500).success(false).message("그새 선생님의 마감으로 예약 결제 환불 API호출!!: ")
					.data(false).build();
		}

		catch (Exception e) {
			System.err.println("[ERROR] 예약 결제중 예외 발생 환불 API호출!!: " + e.getMessage());

			return ApiResponse.<Boolean>builder().code(500).success(false).message("결제 실패").data(false).build();
		}

	}

	@PostMapping("/uploadImage")
	@ResponseBody
	public Map<String, Object> artWorkDraftUploadImage(@RequestParam("file") MultipartFile file,
			@AuthenticationPrincipal UserDetailsVO2 userDetails) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 🔹 파일 비어있는지 확인
		if (file.isEmpty()) {
			map.put("success", false);
			map.put("status", 400);
			return map;
		}

		int userCode = userDetails.getUser_code();
		Map<String, Object> executeQueryInfo = artworkService.artWorkDraftUploadImage(userCode, file);

		Object successObj = executeQueryInfo.get("success");

		boolean success = false;

		if (successObj instanceof Boolean) {
			success = (Boolean) successObj;
		} else if (successObj instanceof String) {
			success = Boolean.parseBoolean((String) successObj);
		}

		if (success) {
			map.put("success", true);
			map.put("status", 200);
			map.put("folder", "/userArtwork/");
			map.put("fileName", executeQueryInfo.get("finalFileName"));
		} else {
			map.put("success", false);
			map.put("status", 500);
		}

		return map;

	}

	@PostMapping("/delete-draft-image")
	@ResponseBody
	public ApiResponse<ArtWorkImagesDeleteResult> artWorkDraftDeleteImage(
			@AuthenticationPrincipal UserDetailsVO2 userDetails, @RequestParam("folder") String folder,
			@RequestParam("fileName") String fileName

	) {

		int userCode = userDetails.getUser_code();

		if (folder == null || fileName == null || (!folder.equals("/userArtwork/"))) {

			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(403).success(false).message("폴더 접근권한 없음")
					.data(null).build();

		}

		if (!fileName.startsWith(userCode + "_")) {
			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(403).success(false).message("사진 접근권한 없음")
					.data(null).build();

		}

		Map<String, Object> executeQueryInfo = artworkService.deleteArtWorkDraftImage(userCode, folder, fileName);

		boolean fileDeleteStauts = (boolean) executeQueryInfo.get("delte-status");

		if (fileDeleteStauts) {
			// ApiResponse.<Boolean>builder().code(201).success(true).message("결제
			// 성공").data(true).build();

			ArtWorkImagesDeleteResult artImageDeleteResult = new ArtWorkImagesDeleteResult(204, true);

			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(204).success(true).message("결제 성공")
					.data(artImageDeleteResult).build();

		} else {
			ArtWorkImagesDeleteResult artImageDeleteResult = new ArtWorkImagesDeleteResult(201, false,
					(String) executeQueryInfo.get("faile-reason"));

			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(500).success(false).message("결제 성공")
					.data(artImageDeleteResult).build();
		}

	}

	@GetMapping("/get-draft-image")
	public ResponseEntity<Resource> servePrivateDraftImage(@RequestParam("folder") String folder, // ex: /userArtwork/
			@RequestParam("name") String fileName, @AuthenticationPrincipal UserDetailsVO2 userDetails) {
		try {
			// ✅ 보안 상 폴더 경로 정규화 방어
			if (folder.contains("..") || folder.contains("\\") || !folder.startsWith("/")) {
				return ResponseEntity.badRequest().build();
			}

			// ✅ 서버 내부 절대 경로 설정
			String rootBaseDir = "C:/"; // 또는 환경변수로 뺄 수도 있음
			String fullPath = rootBaseDir + folder + fileName;
			Path filePath = Paths.get(fullPath).normalize();

			// ✅ 사용자 소유 파일인지 검증 (ex: 파일명이 userCode로 시작)
			int userCode = userDetails.getUser_code();
			if (!fileName.startsWith(userCode + "_")) {
				return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
			}

			if (!Files.exists(filePath)) {
				return ResponseEntity.notFound().build();
			}

			// 이 시점까지는 파일 스트림이 열리지 않은 상태입니다.
			// 아래 UrlResource 객체 생성은 단순히 파일 위치 정보를 갖는 객체를 만드는 것일 뿐, 스트림을 열지 않습니다.
			Resource resource = new UrlResource(filePath.toUri());

			// 파일의 MIME 타입을 검사합니다.
			String contentType = Files.probeContentType(filePath);
			if (contentType == null)
				contentType = "application/octet-stream";

			// 아래 ResponseEntity를 반환하는 순간,
			// Spring 내부에서 HTTP 응답을 처리할 때 resource.getInputStream()이 호출되어
			// **여기서부터 파일 스트림이 열리고, 클라이언트로 데이터 전송이 시작됩니다.**
			// public class ResourceHttpMessageConverter 클래스의 protected void writeContent
			// 메서드에서 톰캣 응답스트림과, 파일객체의 스트림을 적절히 결합한다.
			// 전송이 완료되면 스트림은 자동으로 닫힙니다.
			return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType)).body(resource);

		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@PostMapping("/draft-artwork-complete")
	@ResponseBody
	public ApiResponse<ArtWorkImagesDeleteResult> completeDraftArtWork(@RequestParam("content") String content,
			@AuthenticationPrincipal UserDetailsVO2 userDetails) {

		int userCode = userDetails.getUser_code();

		try {
			Map<String, Object> executeQueryInfo = artworkService.completeDraftArtWork(content, userCode);

			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(201).success(true).message("별탈없이 DB에 작업물이 저장됨")
					.data(null).build();

		} catch (ArtWorkCompleteException e) {

			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(e.getBussinessCode()).success(false)
					.message(e.getBussinessExceptionMessage()).data(null).build();

		}

	}

	//
	@PostMapping("/create-artwork-comment")
	@ResponseBody
	public ApiResponse<ArtWorkImagesDeleteResult> createArtworkComment(@RequestParam("commentText") String commentText,
			@RequestParam("artWorkID") int artWorkID, @AuthenticationPrincipal UserDetailsVO2 userDetails) {

		int userCode = userDetails.getUser_code();

		ArtWorkCommentVO artWorkCommentVO = new ArtWorkCommentVO();

		artWorkCommentVO.setUserCode(userCode);
		artWorkCommentVO.setCommentText(commentText);
		artWorkCommentVO.setArtworkId(artWorkID);

		try {
			int affectedRow = artworkService.createArtworkComment(artWorkCommentVO);
			int code = 0;
			boolean success = false;
			String massage = null;

			if (affectedRow > 0) {
				code = 201;
				success = true;
				massage = "별탈없이 DB에 댓글이 창조됨 저장됨";
			}

			if (affectedRow <= 0) {
				code = 500;
				success = false;
				massage = "잠시후 다시 시도해주세요";
			}
			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(code).success(success).message(massage)
					.data(null).build();

		} catch (Exception e) {

			System.out.println(e);
			return ApiResponse.<ArtWorkImagesDeleteResult>builder().code(500).success(false).message("백엔드 코드 에러")
					.data(null).build();

		}

	}

	@PostMapping("/applyTo-artwork-comment")
	@ResponseBody
	public ApiResponse<Object> applyToComment(@RequestParam("commentText") String commentText,
			@RequestParam("artWorkID") int artWorkID, @RequestParam("parentCommentId") int parentCommentId,
			@AuthenticationPrincipal UserDetailsVO2 userDetails) {

		int userCode = userDetails.getUser_code();

		ArtWorkCommentVO artWorkCommentVO = new ArtWorkCommentVO();

		artWorkCommentVO.setUserCode(userCode);
		artWorkCommentVO.setCommentText(commentText);
		artWorkCommentVO.setArtworkId(artWorkID);
		artWorkCommentVO.setParentCommentId(parentCommentId);

		try {
			int generatedPk = artworkService.applyToComment(artWorkCommentVO);
			int code = 0;
			boolean success = false;
			String massage = null;

			Map<String, Object> data = new HashMap<>();
			if (generatedPk > 0) {
				data.put("artwork_comment_id", generatedPk);
				code = 201;
				success = true;
				massage = "별탈없이 DB에 댓글이 창조됨 저장됨";
			}

			if (generatedPk <= 0) {
				code = 500;
				success = false;
				massage = "잠시후 다시 시도해주세요";
				data = null;
			}
			return ApiResponse.<Object>builder().code(code).success(success).message(massage).data(data).build();

		} catch (Exception e) {

			System.out.println(e);
			return ApiResponse.<Object>builder().code(500).success(false).message("백엔드 코드 에러").data(null).build();

		}

	}

	@PostMapping("/aggre-updated-onedayprice")
	@ResponseBody
	public ApiResponse<Object> aggreUpdatedOnedayprice(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			@RequestParam("merchant_uid") String merchant_uid, @RequestParam("selectedDate") String selectedDate,
			 @RequestParam(value = "priceUpdated", required = false) Integer priceUpdated,
			
			@RequestParam("isAgree") boolean isAgree) {
		
		int 	userCod=userDetails.getUser_code();
		
		
		if(isAgree) {
			draftReserveinfoService.confirmUpdatedOnedayPrice(userCod, selectedDate, merchant_uid, priceUpdated);
			return ApiResponse.<Object>builder().code(201).success(true).message("가격 인상동의를 하셨습니다.").data(null).build();
		}
		else {
			draftReserveinfoService.rejectUpdatedOnedayPrice(userCod, selectedDate, merchant_uid);
			return ApiResponse.<Object>builder().code(201).success(true).message("미동의를 하셨습니다. 메인홈으로 되돌아갑니다.").data(null).build();
		}
		


	}

}
