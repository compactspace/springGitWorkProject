package com.spring.finall.view.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.spring.finall.impl.SmsServiceRedisDao;
import com.spring.finall.reqDto.orderRequest.OrderItemDTO;
import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.payMentRequest.PaymentDTO;
import com.spring.finall.reqDto.wrapperRequest.OrderPaymentRequestDTO;
import com.spring.finall.security.UserDetailsVO2;
import com.spring.finall.service.ArtworkService;
import com.spring.finall.service.MemberService;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.service.OrderService;
import com.spring.finall.service.ReserveService;
import com.spring.finall.user.CartService;
import com.spring.finall.user.OneDayClassVO;
import com.spring.finall.user.UserVO;
@Controller
@RequestMapping("/users")  // 클래스 단위 경로 지정
public class UserViewController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private OneDayClassService oneDayClassService;
	
	@Autowired
	private SmsServiceRedisDao smsServiceRedisDao;
	
	@Autowired
	private ReserveService reserveService;
	
	@Autowired
	private ArtworkService  artworkService;
	
	
	
	// "가맹점 식별코드 값으로 설정"
	public static final String IMPKEY = "imp77544746";
	
	
	
	@RequestMapping(value = "/mypage")
	public String showMyInfoMainPage(  @AuthenticationPrincipal UserDetailsVO2 userDetails, Model model) {

		
		

		return "mypage/myinfoMain";

	}
	
	
	
	
	
	@RequestMapping(value = "/mypersonalinfo")
	public String mypersonalinfo(  @AuthenticationPrincipal UserDetailsVO2 userDetails, Model model) {

		
		// 인증된 사용자 ID만 UserVO에 넣어 사용
	    UserVO vo = new UserVO();
	    
	    String userId=userDetails.getId();
	    System.out.println("userId: "+userId);
	    vo.setId(userId);
		
		// 자료 형태가 길이가1 인 리스트 속에 UserVO 를 때려 박은거라 프론트에서 출력이 힘듬 살짝 가공하자. 에휴
	    UserVO myinfo= memberService.mypersonalinfo(vo);

		model.addAttribute("myinfolist", myinfo);

		return "compoents/mypage/myinfo";

	}
	
	
	// 일반 상품전용 카트
	@RequestMapping(value = "/generalcartlist")
	public String generalcartlist(
	    @AuthenticationPrincipal UserDetailsVO2 userDetails,
	    Model model) {

	    if (userDetails == null) {
	        return "redirect:/login";
	    }

	    String userId = userDetails.getUsername(); // 또는 getUserId() 등 명확한 메서드로!

	    model.addAttribute("impKey", IMPKEY);
	    model.addAttribute("mycart", cartService.cartlist(userId));
	    model.addAttribute("checkmycart", cartService.cartlist(userId).size());

	    return "cartpage/cart";
	}

	// 일반 상품전용 카트
	@RequestMapping(value = "/order")
	public String showOrderPage(
	    @AuthenticationPrincipal UserDetailsVO2 userDetails,
	    Model model) {

	    if (userDetails == null) {
	        return "redirect:/login";
	    }

	    return "orderPage/order";
	}

	@RequestMapping(value = "/payinfo")
	public String showPayInfoPage(
	    @AuthenticationPrincipal UserDetailsVO2 userDetails,
	    Model model) {

	    if (userDetails == null) {
	        return "redirect:/login";
	    }

	    return "payinfoPage/payInfoPage";
	}

	
	
	@RequestMapping(value = "/payinfo-type")
	public String showPayInfoPageType2(
	    @AuthenticationPrincipal UserDetailsVO2 userDetails,
	    Model model) {

	    if (userDetails == null) {
	        return "redirect:/login";
	    }

	    return "compoents/mypage/mypayinfo";
	}
	
	

	@RequestMapping("/listMore")
	public String listMore(@RequestParam(defaultValue = "0") int offset,
	                       @RequestParam(defaultValue = "10") int limit,
	                       Model model) {
	    LocalDate today = LocalDate.now();
	    LocalDate sixMonthsAgo = today.minusMonths(6);

	 // limit + 1개만 조회해서 다음 페이지 존재 여부 판단
	    List<OrderPaymentRequestDTO> orderList = orderService.getPagedOrders(sixMonthsAgo, today, offset, limit + 1);

	    boolean hasNext = false;
	    if (orderList.size() > limit) {
	        hasNext = true;
	        orderList = orderList.subList(0, limit); // 초과한 1개 제거
	    }

	    List<Map<String, Object>> viewList = convertToViewList(orderList);

	    model.addAttribute("orderList", viewList);
	    model.addAttribute("hasNext", hasNext);
	    model.addAttribute("limit", limit); // for JSP에서도 필요하면 사용
	    return "compoents/orderListFragment";  // JSP 조각 리턴
	}
	


	private List<Map<String, Object>> convertToViewList(List<OrderPaymentRequestDTO> orderList) {
	    List<Map<String, Object>> viewList = new ArrayList<>();

	    for (OrderPaymentRequestDTO dto : orderList) {
	        Map<String, Object> map = new HashMap<>();

	        // order 부분
	        Map<String, Object> orderMap = new HashMap<>();
	        OrderRequestDTO order = dto.getOrder();

	        orderMap.put("orderInfoId", order.getOrderInfoId());
	        orderMap.put("userId", order.getUserId());
	        orderMap.put("userCode", order.getUserCode());
	        orderMap.put("person", order.getPerson()); // person 객체 통째로 담음

	        List<Map<String, Object>> itemsList = new ArrayList<>();
	        if (order.getItems() != null) {
	            for (OrderItemDTO item : order.getItems()) {
	                Map<String, Object> itemMap = new HashMap<>();
	                itemMap.put("productId", item.getProductId());
	                itemMap.put("productName", item.getProductName());
	                itemMap.put("quantity", item.getQuantity());
	                itemMap.put("pricePerUnit", item.getPricePerUnit());
	                itemsList.add(itemMap);
	            }
	        }
	        orderMap.put("items", itemsList);

	        map.put("order", orderMap);

	        // pay 부분
	        Map<String, Object> payMap = new HashMap<>();
	        PaymentDTO payment = dto.getPayment();

	        if (payment != null) {
	            payMap.put("paymentMethod", payment.getPaymentMethod());
	            payMap.put("paymentNumber", payment.getPaymentNumber());
	            payMap.put("paymentDate", payment.getCreatedAt());
	            payMap.put("amount", payment.getAmount());
	        }

	        map.put("pay", payMap);

	        viewList.add(map);
	    }

	    return viewList;
	}

	
	// 
	@RequestMapping(value = "/get-my-reserve-page")
	public String showMyReservePage() {		

		return "myReservePage/myReservePage";
	}	
	
	@RequestMapping(value = "/get-my-reserve-fragment")
	public String getMyReserveFragMentPage(@AuthenticationPrincipal UserDetailsVO2 userDetails,			
			@RequestParam(defaultValue = "0")int offset,
			
			Model model) {
		
		int user_code=userDetails.getUser_code();
		
	Map<String,Object>	recentlyReserveStatusObj =reserveService.getReserveStatus(user_code, offset);
	List<Map<String, Object>> data = (List<Map<String, Object>>) recentlyReserveStatusObj.get("data");
	boolean hasNext = (Boolean) recentlyReserveStatusObj.get("hasNext");

	model.addAttribute("reserveList", data);       // 예약 리스트
	model.addAttribute("hasNext", hasNext);        // 다음 페이지 존재 여부
	model.addAttribute("offset", offset);          // 현재 offset (프론트에서 next offset 계산용)

		return "compoents/myReservePage/myReserveFragment";
	}
	
	
	
	
	
	
	//
	
	@RequestMapping(value = "/changePassword")
	public String showMypageComponentChangePassword(@AuthenticationPrincipal UserDetailsVO2 userDetails, Model model) {

		String userId = userDetails.getId();

		Long attemptCnt = memberService.isPasswordFailLimitExceeded(userId);

		if (attemptCnt >= 3) {
			model.addAttribute("lockPage", Boolean.TRUE);
			model.addAttribute("smsVerified", Boolean.FALSE);
			model.addAttribute("verifiedDate", null);
			model.addAttribute("verifiedTTL", null);

		} else {
			model.addAttribute("lockPage", Boolean.FALSE);

			Long ttl = smsServiceRedisDao.getVerifiedTTL(userId);
			String verifiedDate = smsServiceRedisDao.getVerifiedDate(userId);

			if (ttl != null && ttl > 0) {
				// TTL이 남아있으면 인증 상태 유지
				model.addAttribute("smsVerified", Boolean.TRUE);
				model.addAttribute("verifiedDate", verifiedDate);
				model.addAttribute("verifiedTTL", ttl);
				model.addAttribute("ttlStartTime", System.currentTimeMillis());
			} else {
				// TTL 없거나 만료되었으면 인증 상태 false
				model.addAttribute("smsVerified", Boolean.FALSE);
				model.addAttribute("verifiedDate", null);
				model.addAttribute("verifiedTTL", null);
			}
			
			
			
		}
		model.addAttribute("attemptCnt", attemptCnt);		

		return "compoents/mypage/changePassword";

	}
	
		@RequestMapping("/onedayclass-payment")
	    public String showOnedayClassPaymentPage(
	    		@RequestParam("onedayclass_num") int onedayclass_num, 
	    		@RequestParam("choiceOpenDay") String choiceOpenDay,
	    		@RequestParam("selectedDate") String selectedDate,
	    		
	    		@RequestParam("onedayclass_name")String onedayclass_name,
	    		@RequestParam("reserveRest_id") String reserveRest_id,
	    		Model model) throws JsonProcessingException {
	        // onedayclass_num을 뷰에 전달 (필요시)
			
			OneDayClassVO onedayVo= new OneDayClassVO();
			onedayVo.setOnedayclass_name(onedayclass_name);
			
			onedayVo=	oneDayClassService.selectOneDayClass(onedayVo).get(0);
		
			
			ObjectMapper mapper = new ObjectMapper();

			// 1. VO 객체를 ObjectNode로 변환
			ObjectNode node = mapper.valueToTree(onedayVo);

			// 2. 제외할 필드들 제거
			node.remove("nextpage");
			node.remove("preventNextPage");
			node.remove("endPageFlag");
			node.remove("reivewvo");

			// 3. 다시 JSON 문자열로 변환
			String json = mapper.writeValueAsString(node);

			model.addAttribute("onedayClassInfo", onedayVo);

			model.addAttribute("choiceOpendayInfo", choiceOpenDay);
			model.addAttribute("selectedDate", selectedDate);
			
			
			model.addAttribute("reserveRest_id",reserveRest_id);
	        
	        return "compoents/onedayclassinfopage/onedayClassPaymentPage";
	    }
    
	
		@RequestMapping("/get-free-write-gasigle")
		public String showFreeWriteGasipanPage(@AuthenticationPrincipal UserDetailsVO2 userDetails, Model model) {
			
						
			int userCode=userDetails.getUser_code();
			
			List<Map<String,Object>>  unfinishedDraftForUser	=artworkService.findDraftByUserCode(userCode);			
			
			if (unfinishedDraftForUser != null && !unfinishedDraftForUser.isEmpty()) {
			    Map<String, Object> firstDraft = unfinishedDraftForUser.get(0);

			  
			    model.addAttribute("unfinishedDraftArtWorkText", firstDraft.get("artworks"));

			    // artwork_images 가 없거나 null일 수도 있으니 널 체크
			    Object images = firstDraft.get("artwork_images");
			    if (images instanceof List) {
			        model.addAttribute("unfinishedDraftArtWorkImages", images);
			    } else {
			        model.addAttribute("unfinishedDraftArtWorkImages", Collections.emptyList());
			    }
			}else {
				
				artworkService.insertDraftArtwork(userCode);
				
			}			
			
			
			return "freeWriteGasiglePage/freeWriteGasiglePage";
		}
		
		
    
}
