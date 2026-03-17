package com.spring.finall.view.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.finall.WorkImgVO;
import com.spring.finall.RabitEvent.ReserveEvent;
import com.spring.finall.impl.ArtworkServiceDAO;
import com.spring.finall.impl.WorkServcieRedisDao;
import com.spring.finall.resDto.SearchProductResDTO.SearchProductResDTO;
import com.spring.finall.security.UserDetailsVO2;
import com.spring.finall.service.ArtworkService;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.service.SearchService;
import com.spring.finall.service.WorkService;
import com.spring.finall.user.ArtworkVO;
import com.spring.finall.user.OneDayClassVO;
import com.spring.finall.user.ProductGroupVO;
import com.spring.finall.user.ProductService;
import com.spring.finall.user.ProductVO;
import com.spring.finall.user.ReserveRestVOService;

@Controller
@RequestMapping("/guest")
public class GuestViewController {

	@Autowired
	private OneDayClassService oneDayClassService;

	@Autowired
	private ProductService protService;

	@Autowired
	private ReserveRestVOService reserveRestServie;

	@Autowired
	private WorkService workService;
	
	
	@Autowired
	private ArtworkService artWorkService;
	
	
	@Autowired
	private SearchService searchService;
	
	@Autowired
	private WorkServcieRedisDao workServiceRedisDao;
	
	@Autowired
	private ArtworkServiceDAO artworkServiceDAO;
	@Autowired
    private RabbitTemplate rabbitTemplate;
	@Autowired
	private RedisTemplate<String, String> redisTemplate;

	  @GetMapping("/")
	    public String showMainHome() {
		  //스프링상의 payment 정보 삽입
//          ReserveEvent reserveEvent = new ReserveEvent();
//          reserveEvent.setUserCode(0);
//          reserveEvent.setPaymentMethod("Credit Card");
//          reserveEvent.setMerchantUid(null);
//          rabbitTemplate.setMessageConverter(new Jackson2JsonMessageConverter());
//
//	        rabbitTemplate.convertAndSend("reserveQueue", reserveEvent);
	        return "mainPage/mainhome";
	    }

	@GetMapping("/login") // 실제 요청 경로: /users/login
	public String showLoginPage(HttpSession session) {
	
		session.setAttribute("age", 21);
		
		return "loginPage/login"; // 뷰리졸버에 의해 /WEB-INF/views/login.jsp로 매핑됨
	}

	
	
	
	
	
	@GetMapping("/onedayclasses") // 실제 요청 경로: /users/login
	public String showOnedayClassPage() {
		
		return "onedayclass"; // 뷰리졸버에 의해 /WEB-INF/views/login.jsp로 매핑됨
	}

	@RequestMapping(value = "/communityPage")
	public String showCommunityPage(@RequestParam(defaultValue = "0") int offset, Model model) {

	    Map<String, Object> artWorkInfo = artWorkService.getArtWorkList(offset);
	    
	    // artWorkList를 받아서 Model에 추가
	    model.addAttribute("artWorkList", (List<Map<String, Object>>) artWorkInfo.get("artWorkList"));
	    model.addAttribute("hasNext", artWorkInfo.get("hasNext"));
	    
	    return "communityPage/communityPage";
	}
	
	
	//artWorkDetailPage
	@RequestMapping(value = "/get-artwork-detail")
	public String showArtWorkDetailPage(@RequestParam("artWorkID") int artWorkID, Model model) {   
	    
	    Map<String, Object> artWorkDetail = artWorkService.getArtWorkDetail(artWorkID);
		
		
	    model.addAttribute("artWorkDetail", artWorkDetail);
	    
	    
	    return "artWorkDetailPage/ArtWorkDetailPage";
	}
	
	
	
	@GetMapping("/onedayclass-intro")
	public String showOnedayclassIntro(OneDayClassVO ovo, Model model) {

		List<OneDayClassVO> onedayclassList = oneDayClassService.selectDayClassList(ovo);

		model.addAttribute("onedayclassList", onedayclassList);

		return "onedayclassIntroPage/onedayclassIntro";
	}

	@GetMapping("/workpage")
	public String showWorkpage(
			@RequestParam(name = "onedayclass_num", required = false, defaultValue = "1") int onedayclassNum,
			Model model) {

		return "workPage/workPage";
	}

	@GetMapping("/indReviewGroupOnedayClass")
	public String indReviewGroupOnedayClass(
			@RequestParam(name = "onedayclass_num", required = false, defaultValue = "1") int onedayclassNum,
			Model model) {

		List<Map<String, Object>> workReviews = workService.getWorkReviews(onedayclassNum);
		model.addAttribute("workReviews", workReviews); // 뷰로 데이터 전달

		return "compoents/workPage/workPageFragment";
	}

	@GetMapping("/work-detail-page")
	public String showWorkDetailpage(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			@RequestParam(name = "work_id", required = true) int work_id,

			Model model) {

		Map<String, Object> workDetail = workService.getWorkDetail(work_id);
		model.addAttribute("workDetail", workDetail); // 뷰로 데이터 전달

		if (userDetails != null) {
			int userCode = userDetails.getUser_code();
			Map<Object, Object> dangerousUser = workServiceRedisDao.getAttemptCntDangerousUser(userCode);
			if (dangerousUser != null && !dangerousUser.isEmpty()) {
				model.addAttribute("commenWriteLockUser", "true"); // 뷰로 데이터 전달

			}

		} else {
			model.addAttribute("commentWriteLockUser", "false"); // 정상 유저
		}

		return "wrokDetailPage/wrokDetailPage";
	}

	@RequestMapping(value = "/guest_loginsuccess.do")
	public String loginsuccessForm(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("GuestViewController :/loginsuccess.do  시큐리티 석세스핸들러로부터 컨트롤러");
		return "mainPage/mainhome";
	}

	// 일반 상품 상품페이지로 최초 진입이나, 제품군 선택시 호출되는 메서드
	@RequestMapping(value = "/productlist")
	public String showProductGroupLlistPage(ProductVO vo,
			@RequestParam(value = "product_group", required = false, defaultValue = "pencile") String product_group,
			@AuthenticationPrincipal UserDetailsVO2 user,
			Model model) {

		if ("groupdetermined".equals(product_group)) {
			product_group = "제품군미정";
		}

		vo.setProduct_group(product_group);

		List<Map<String, Object>> grouplist = protService.productGroupLlist(vo);

		model.addAttribute("productService", grouplist);
		List<ProductGroupVO> groupInfolist =protService.getProductGroupList();
		model.addAttribute("groupInfolist", groupInfolist);
		// 로그인 여부
				Boolean isAuthenticated = user != null;
				model.addAttribute("isAuthenticated", isAuthenticated);
		return "productPage/generalproductlist";
	}

	// Spring의 커맨드 객체 바인딩은:
	// 폼 필드나 QueryString에 있는 값들의 name이 VO의 필드명과 일치할 때
	@RequestMapping(value = "/getonedayclass-info")
	public String getReserv(@RequestParam(defaultValue = "취미만화반") String onedayclass_name,
			@RequestParam(defaultValue = "0") int nextpage,

			WorkImgVO vo, OneDayClassVO ovo, Model model, HttpServletRequest req) throws JsonProcessingException {
		ovo.setOnedayclass_name(onedayclass_name);
		ovo.setNextpage(nextpage);

		HashMap<String, Object> map = oneDayClassService.getReview(ovo);

		OneDayClassVO onedayVO = (OneDayClassVO) map.get("onedayclass");

		LocalDate today = LocalDate.now(); // 현재 날짜
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");

		Integer onedayClassNum = onedayVO.getOnedayclass_num();
		String searchMonth = today.format(formatter);

		// 결과 맵에 담기

		model.addAttribute("candiImageList", map.get("candiImageList"));
		model.addAttribute("onedayclass", map.get("onedayclass"));
		model.addAttribute("joinToReview", map.get("joinToReview"));
		model.addAttribute("isEmpty", map.get("isEmpty")); // null 일 수도 있으니 뷰에서 체크 필요
		model.addAttribute("endPageFlag", map.get("endPageFlag"));
		model.addAttribute("nextpage", map.get("nextpage"));

		return "onedayclassinfopage/onedayinfopage";
	}

	@RequestMapping(value = "/getpossibleDateFragment")
	public String possibleDateFragment(@AuthenticationPrincipal UserDetailsVO2 userDetails,
			@RequestParam(defaultValue = "취미만화반") String onedayclass_name,
			@RequestParam(defaultValue = "0") int nextpage,

			WorkImgVO vo, OneDayClassVO ovo, Model model, HttpServletRequest req) throws JsonProcessingException {
		ovo.setOnedayclass_name(onedayclass_name);
		ovo.setNextpage(nextpage);

		HashMap<String, Object> map = oneDayClassService.getReview(ovo);

		OneDayClassVO onedayVO = (OneDayClassVO) map.get("onedayclass");

		LocalDate today = LocalDate.now(); // 현재 날짜
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");

		Integer onedayClassNum = onedayVO.getOnedayclass_num();
		String searchMonth = today.format(formatter);

		int userId = 0;
		if (userDetails != null) {
			userId = userDetails.getUser_code();
		}

		List<Map<String, Object>> getAvailableDaysInMonth = reserveRestServie.restOneDayClass(
		        onedayClassNum, searchMonth, userId);

		// openday 기준 오름차순 정렬
		getAvailableDaysInMonth.sort((map1, map2) -> {
		    Timestamp t1 = (Timestamp) map1.get("openday");
		    Timestamp t2 = (Timestamp) map2.get("openday");
		    return t1.compareTo(t2); // compareTo: 오름차순
		});

		// model에 그대로 넘김 (JSON으로 변환 안 함)
		model.addAttribute("filteredList", getAvailableDaysInMonth);

		return "compoents/onedayclassinfopage/possibleDateFragment";

	}

	@RequestMapping(value = "/get-onedayclass-list")

	public String getOnedayClassList(HttpServletResponse res, OneDayClassVO ovo, Model model) {

		List<OneDayClassVO> onedayclassList = oneDayClassService.selectDayClassList(ovo);

		model.addAttribute("onedayclassList", onedayclassList);

		return "compoents/mainPage/TopTenOnedayClassListFragment";
	}
	
	
	@RequestMapping(value = "/get-onedayclass-detail-one-page")
	public String getonedayclassDetailOnePage(HttpServletResponse res) {

		

		return "onedayclassDetailOnePage/onedayclassDetailOnePage";
	}
	
	
	@RequestMapping(value = "/get-onedayclass-detail-one-fragment")
	public String getOnedayClassDetailOneFragment(HttpServletResponse res, OneDayClassVO ovo, Model model) {

		OneDayClassVO onedayclassInfo = oneDayClassService.getOneOneDayClass(ovo);

		model.addAttribute("onedayclassInfo", onedayclassInfo);

		return "compoents/onedayclassDetailOnePage/onedayclassDetailOneFragment";
	}

	//
	@RequestMapping(value = "/get-introduce-onedayclass")

	public String getIntroduceOnedayClass(HttpServletResponse res, OneDayClassVO ovo, Model model) {

		List<OneDayClassVO> onedayclassList = oneDayClassService.selectDayClassList(ovo);

		model.addAttribute("onedayclassList", onedayclassList);

		return "compoents/mainPage/introMainHomeFragMent";
	}

	@RequestMapping(value = "/get-signup-page")

	public String showSignUpPage(@AuthenticationPrincipal UserDetailsVO2 userDetails,HttpServletRequest req) {
		
	
		if(userDetails != null && userDetails.getId() != null) {
			return "mainPage/mainhome";
		}		
		   // 1. 현재 사용자의 HttpSession 객체 획득
	    HttpSession session = req.getSession();

	    // 2. 이 사용자의 고유 세션 ID 확인
	    String sessionId = session.getId();

	    String verifiedKey = "signup:verified:session:" + sessionId;
	  
	    if(redisTemplate.hasKey(verifiedKey)) {
	    	
	    	return "signupPage/signUpPage";
	    	
	    }
	
			return "usersignupSmsAuthPage/signupSmsAuthPage";

	}
	
	
	
	
	@RequestMapping(value = "/get-teacher-signup-page")

	public String showTeacherSignUpPage(@AuthenticationPrincipal UserDetailsVO2 userDetails,HttpServletRequest req) {
		
	
		if(userDetails != null && userDetails.getId() != null) {
			return "mainPage/mainhome";
		}		
		   // 1. 현재 사용자의 HttpSession 객체 획득
	    HttpSession session = req.getSession();

	    // 2. 이 사용자의 고유 세션 ID 확인
	    String sessionId = session.getId();

	    String verifiedKey = "signup:verified:session:" + sessionId;
	  
	    if(redisTemplate.hasKey(verifiedKey)) {
	    	
	    	return "teacherSignUpPage/teacherSignUpPage";
	    	
	    }
	
			return "teachersignupSmsAuthPage/teachersignupSmsAuthPage";

	}
	
	
	
	
	
	//여기
	@RequestMapping(value = "/artwork-comment")
	public String test(Model model,@RequestParam(name = "work_id", required = true) int work_id) throws Exception {
	    List<Map<String, Object>> list = artworkServiceDAO.getMoreWorkComments(work_id, 10, 0);

	    ObjectMapper mapper = new ObjectMapper();
	    String jsonList = mapper.writeValueAsString(list);

	    model.addAttribute("listJson", jsonList);

	    return "compoents/artWorkDetailPage/artWorkCommentFragment";
	}
	
	@RequestMapping(value = "/search")
	public String showSearchResultPage(
			@AuthenticationPrincipal UserDetailsVO2 user,
	        Model model,
	        @RequestParam(defaultValue = "community") String search_type,
	        @RequestParam("query") String query,
	        @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "10") int limit,
	        @CookieValue(value = "cachyTotalCnt", defaultValue = "0") String cachyTotalCnt
	) throws Exception {
	    System.out.println("쿠키 cachyTotalCnt 값: " + cachyTotalCnt);

	    model.addAttribute("searchType", search_type);
	    model.addAttribute("query", query);

	    if (search_type.equals("community")) {
	        ArtworkVO artWorkVO = new ArtworkVO();
	        int offSet = (page - 1) * limit;
	        artWorkVO.setContent(query);
	        artWorkVO.setLimit(limit);
	        artWorkVO.setOffSet(offSet);

	        int TotalCnt = Integer.parseInt(cachyTotalCnt);
	        if (TotalCnt <= 0) {
	            int totalCnt = artWorkService.searchyCntAll(artWorkVO);
	            model.addAttribute("totalCnt", totalCnt);
	        } else {
	            model.addAttribute("totalCnt", TotalCnt);
	        }

	        Map<String, Object> searchData = artWorkService.searchyArtWork(artWorkVO);
	        model.addAttribute("searchyList", searchData.get("searchyList")); // List<Map<String,Object>>
	    }

	    if (search_type.equals("product")) {
	        List<SearchProductResDTO> productList = searchService.SearchFindProductList(query);
	        model.addAttribute("productList", productList);

	        // 상품도 totalCnt 필요하면:
	        model.addAttribute("totalCnt", productList.size());
	    }
	    
	 // 로그인 여부
	 		Boolean isAuthenticated = user != null;
	 		model.addAttribute("isAuthenticated", isAuthenticated);

	    return "searchResultPage/searchResultPage";
	}
	
}
