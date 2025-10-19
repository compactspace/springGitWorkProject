package com.spring.finall.constroller;

import java.io.UnsupportedEncodingException;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.finall.apiResponseController.ApiResponse;
import com.spring.finall.businessresult.CheckCurrentPwdResult;
import com.spring.finall.businessresult.SmsSendResult;
import com.spring.finall.impl.SmsServiceRedisDao;
import com.spring.finall.impl.WorkServcieRedisDao;
import com.spring.finall.importutil.ImportUtil;
import com.spring.finall.redisutil.RedisUtil;
import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.payMentRequest.PaymentDTO;
import com.spring.finall.reqDto.wrapperRequest.OrderPaymentRequestDTO;
import com.spring.finall.reqDto.writeWorkComment.WorkCommentDTO;
import com.spring.finall.security.SecurityUserVO;
import com.spring.finall.security.SecurityUserVOService;
import com.spring.finall.security.UserDetailsVO2;
import com.spring.finall.service.MemberService;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.service.OrderService;
import com.spring.finall.service.ReserveService;
import com.spring.finall.service.SendMessageApiService;
import com.spring.finall.service.SmsService;
import com.spring.finall.service.WorkService;
import com.spring.finall.user.CartService;
import com.spring.finall.user.CartVO;
import com.spring.finall.user.OneDayClassVO;
import com.spring.finall.user.OrderInfoService;
import com.spring.finall.user.OrderInfoVO;
import com.spring.finall.user.PayService;
import com.spring.finall.user.PayVO;
import com.spring.finall.user.ProductService;
import com.spring.finall.user.ReserveRestVOService;
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
	private SendMessageApiService sendmessageservice;

	@Autowired
	private SmsService smsService;
	
	@Autowired
	private SmsServiceRedisDao smsServiceDao;
	
	@Autowired
	private WorkServcieRedisDao workServiceRedisDao;

	boolean PASSWORDCHANGE;

	// 서비스호출위해 자동주입

	@Autowired
	private ImportUtil importutil;

	@Autowired
	private RedisTemplate<String, String> redisTemplate;

	@Autowired
	private RedisUtil redisutil;

	@Autowired
	private PayService payService;

	@Autowired
	private ReserveService reserveService;

	@Autowired
	private ReserveRestVOService reserveRestServie;

	@Autowired
	private WorkService workService;

	@Autowired
	private CartService cartService;

	@Autowired
	private ProductService protService;

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



	@RequestMapping(value = "/403", method = { RequestMethod.GET, RequestMethod.POST })
	public String error403() {
		System.out.println("권하이 없다꼬요");
		return "403";
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
			HttpServletRequest req, @RequestParam("code") String inputCode, @RequestParam("token") String token,Model model) {

		String userId = userDetails.getId();
		HttpSession session = req.getSession();
		SmsSendResult smsSendResult = smsService.verifySmsCode(userId, session, inputCode, token);

		// 결과에 따라 반환 (문자 발송 성공시 token 반환, 아니면 상태 문자열)
		if (smsSendResult.isSuccess()) {
			model.addAttribute("smsVerified", true);
			return ApiResponse.<SmsSendResult>builder().code(201).success(true).message("인증이 완료되었습니다.").data(smsSendResult)
					.build();
		} else {
			return ApiResponse.<SmsSendResult>builder().code(201).success(true).message("인증 실패").data(smsSendResult)
					.build();
		}
	}
	
	
	
	
	
	//코멘트
	@RequestMapping(value = "/write-work-comments", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> writeWorkComments(
	        @Valid WorkCommentDTO workCommentDTO,
	        BindingResult bindingResult,
	        @AuthenticationPrincipal UserDetailsVO2 userDetail,
	        Model model, HttpServletRequest req) {

	    int userCode = userDetail.getUser_code();

	    Map<String,Object> map = new HashMap<>();
	    if (bindingResult.hasErrors()) {
	        String errorMsg = bindingResult.getAllErrors().get(0).getDefaultMessage();
	        map.put("falseCauz", "댓글달 내용이 없습니다.");
	        return ResponseEntity
	                .badRequest()
	                .header("Content-Type", "application/json; charset=UTF-8")
	                .body(map);
	    }
	    
	    
	    
	   Map<Object,Object> dangerousUser=workServiceRedisDao.getAttemptCntDangerousUser(userCode);
	   if(dangerousUser!=null&& !dangerousUser.isEmpty()) {
		   	map.put("success", false);
	        map.put("falseCauz", "해당 댓글 서비스를 이용할 수 없습니다. 서비스 이용에 제한되었습니다 관리자에게 문의해주세요");
		   return ResponseEntity
				   		.ok()
	                .header("Content-Type", "application/json; charset=UTF-8")
	                .body(map);
	   }
	   
	    Long  attemptCnt=  workServiceRedisDao.getAttemptCntCommentWrite(workCommentDTO, userCode);
	    
	    if(attemptCnt>=3) {
	    	 	map.put("success", false);
		        map.put("falseCauz", "너무 빠른삽입입니다.");
	    	return ResponseEntity
	    			.ok()
	                .header("Content-Type", "application/json; charset=UTF-8")
	                .body(map);	    	
	    } 
	    
	    
	    Long commentId = workService.writeWorkComment(workCommentDTO, userCode);

	    if (commentId != null && commentId > 0) {
	        map.put("success", true);
	        map.put("commentId", commentId);
	        return ResponseEntity
	                .ok()
	                .header("Content-Type", "application/json; charset=UTF-8")
	                .body(map);
	    } else {
	        map.put("success", false);
	        return ResponseEntity
	                .ok()
	                .header("Content-Type", "application/json; charset=UTF-8")
	                .body(map);
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
			CheckCurrentPwdResult checkCurrentPwdResult= new CheckCurrentPwdResult(attemptCnt,false);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true).message("3회 초과하였습니다." + "" + "관리자에게 문의 바랍니다.")
					.data(checkCurrentPwdResult).build();
		}

		userVO.setId(userId);
		String HahsedPwd = memberService.getHashedPassword(userVO);

		if (HahsedPwd == null) {
			
			memberService.incrementPasswordFailCount(userId);
			attemptCnt = memberService.isPasswordFailLimitExceeded(userId); // 증가된 값 반영
			CheckCurrentPwdResult checkCurrentPwdResult= new CheckCurrentPwdResult(attemptCnt,false);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true).message("비밀번호가 일치하지 않습니다.").data(checkCurrentPwdResult)
					.build();
		}

		String currentUnHashPwd = userVO.getPassword();
		boolean checkpassword = BCrypt.checkpw(currentUnHashPwd, HahsedPwd);
		System.out.println("ispasswrodback->>>>>>>>>>" + checkpassword);

		if (checkpassword) {
			CheckCurrentPwdResult checkCurrentPwdResult= new CheckCurrentPwdResult(attemptCnt,true);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true).message("비밀번호가 확인되었습니다.").data(checkCurrentPwdResult).build();

		} else {
			 memberService.incrementPasswordFailCount(userId);
			 attemptCnt = memberService.isPasswordFailLimitExceeded(userId); // 증가된 값 반영
			 CheckCurrentPwdResult checkCurrentPwdResult= new CheckCurrentPwdResult(attemptCnt,false);
			return ApiResponse.<CheckCurrentPwdResult>builder().code(201).success(true).message("비밀번호가 일치하지 않습니다.").data(checkCurrentPwdResult)
					.build();
		}

	}
	@RequestMapping(value = "/onedayclass-applicant")
	@ResponseBody
	public Object onedayclassApplicant(@AuthenticationPrincipal UserDetailsVO2 userDetails, @RequestParam Map<String, Object> paramMap) {
		String userId = userDetails.getId();
		int user_code = userDetails.getUser_code();		
		   // ✅ merchant_uid 생성
	    String merchant_uid = "order_" + userId + "_" + System.currentTimeMillis();

	    // ✅ paramMap에 추가
	    paramMap.put("merchant_uid", merchant_uid);
	    paramMap.put("user_code", user_code);
	    paramMap.put("payment_method", "Credit Card");
	   
	
		
		try {
			reserveService.makeReservation(paramMap);
			
			return ApiResponse.<Boolean>builder().code(201).success(true).message("결제 성공").data(true).build();
		} catch (Exception e) {
			System.err.println("[ERROR] 예약 결제중 예외 발생 환불 API호출!!: " + e.getMessage());
			
			return ApiResponse.<Boolean>builder().code(500).success(false).message("결제 실패").data(false).build();
		}	
		
		
	}
	
	
	
	
}
