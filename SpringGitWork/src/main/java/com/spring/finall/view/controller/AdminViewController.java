package com.spring.finall.view.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.finall.service.ApplicantDocumentService;
import com.spring.finall.service.ArtworkService;
import com.spring.finall.service.ManageInventoryService;
import com.spring.finall.service.ManageProductService;
import com.spring.finall.service.OrderService;
import com.spring.finall.service.ProductRefundService;
import com.spring.finall.user.InventoryVO;
import com.spring.finall.user.OrderStatusVO;
import com.spring.finall.user.WarehouseVO;

@Controller
@RequestMapping("/admin")
public class AdminViewController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private ProductRefundService productService;

	@Autowired
	private ApplicantDocumentService applicantDocumentService;

	@Autowired
	private ArtworkService artworkService;

	@Autowired
	private ManageProductService manageProductService;

	@Autowired
	private ManageInventoryService manageInventoryService;

	@GetMapping("/main")
	public String showMainHome(Model model) {

		LocalDate today = LocalDate.now(); // 오늘 날짜

		// 이번 주 시작 (월요일)
		LocalDate startOfWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));

		// 이번 주 끝 (일요일)
		LocalDate endOfWeek = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));

		// 오늘/이번주 주문 건수 조회
		Map<String, Object> ordersSummary = orderService.getOrdersCountByTodayAndWeek(startOfWeek, endOfWeek);

		Map<String, Object> productSummary = productService.getProductRefundCountByTodayAndWeek(startOfWeek, endOfWeek);

		Map<String, Object> applicantSummary = applicantDocumentService
				.getAppicantDocumentCountByTodayAndWeek(startOfWeek, endOfWeek);

		Map<String, Object> artWorkSummary = artworkService.getArtWorkCountByTodayAndWeek(startOfWeek, endOfWeek);

		// Model에 담아서 JSP로 전달
		model.addAttribute("ordersSummary", ordersSummary);
		model.addAttribute("productSummary", productSummary);
		model.addAttribute("applicantSummary", applicantSummary);
		model.addAttribute("artWorkSummary", artWorkSummary);
		return "adminMainPage/adminMainPage";
	}

	// order-list
	@GetMapping("/order-list")
	public String showOrderListPage(Model model) throws JsonProcessingException {

		List<OrderStatusVO> orderStatusList = orderService.getOrderStatusList();

		model.addAttribute("orderStatusListJson", new ObjectMapper().writeValueAsString(orderStatusList));

		model.addAttribute("orderStatusList", orderStatusList);
		return "adminManageOrderListPage/adminManageOrderListPage";
	}

	// order-list
	@PostMapping("/order-list-by-postmapping")
	public String showOrderListPageByPostMapping(Model model, @RequestParam(required = false) String startDate,
			@RequestParam(required = false) String endDate, @RequestParam(required = false) String status

	) throws JsonProcessingException {

		List<OrderStatusVO> orderStatusList = orderService.getOrderStatusList();

		model.addAttribute("orderStatusListJson", new ObjectMapper().writeValueAsString(orderStatusList));

		model.addAttribute("orderStatusList", orderStatusList);

		// 🔥 모델에 값만 넣기
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("status", status);

		return "adminManageOrderListPage/adminManageOrderListPage";
	}

	// delivery-list

	@GetMapping("/delivery-list")
	public String showDeliveryListPage(Model model) throws JsonProcessingException {

		List<OrderStatusVO> orderStatusList = orderService.getOrderStatusList();

		// 0번과 statusId가 5,6,7인 항목 제거
		List<OrderStatusVO> filteredStatusList = orderStatusList.stream().skip(1) // 첫 번째 항목 제거
				.filter(status -> !(status.getStatusId() == 5 || status.getStatusId() == 6
						|| status.getStatusId() == 7))
				.collect(Collectors.toList());

		Map<Long, List<InventoryVO>> fullInventoryList = manageInventoryService.getFullInventoryList();
		model.addAttribute("fullInventoryList", fullInventoryList);
		model.addAttribute("fullInventoryListJson", new ObjectMapper().writeValueAsString(fullInventoryList));
		model.addAttribute("orderStatusListJson", new ObjectMapper().writeValueAsString(filteredStatusList));
		model.addAttribute("orderStatusList", filteredStatusList);
		return "adminManageDelivery/adminManageDelivery";
	}

	@GetMapping("/login-page") // 실제 요청 경로: /users/login
	public String showAdminLoginPage(Model model) {

		return "adminLogin/adminLogin"; // 뷰리졸버에 의해 /WEB-INF/views/login.jsp로 매핑됨

	}

	// unread-document-list
	@PostMapping("/unread-document-list-by-postmapping") // 실제 요청 경로: /users/login
	public String showUnreadDocumentListPageByPostmapping(@RequestParam(required = false) String startDate,
			@RequestParam(required = false) String endDate, Model model) {

		// 🔥 모델에 값만 넣기
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		return "adminManageUnreadDocumentListPage/adminManageUnreadDocumentListPage"; // 뷰리졸버에 의해

	}

	// unread-document-list
	@GetMapping("/unread-document-list") // 실제 요청 경로: /users/login
	public String showUnreadDocumentListPage() {

		return "adminManageUnreadDocumentListPage/adminManageUnreadDocumentListPage"; // 뷰리졸버에 의해

	}

	@GetMapping("/readed-document-list") // 실제 요청 경로: /users/login
	public String showReadedDocumentList() {

		return "adminManageReadedDocumentListPage/adminManageReadedDocumentListPage"; // 뷰리졸버에 의해
																						// /WEB-INF/views/login.jsp로 매핑됨

	}
	
	@GetMapping("/user-list") // 실제 요청 경로: /users/login
	public String showUserListPage() {

		return "adminManageUser/adminManageUser"; // 뷰리졸버에 의해
																				
	}
	
	
	

	@GetMapping("/active-product-list") // 실제 요청 경로: /users/login
	public String showgActiveProductList(Model model) {

		List<Map<String, Object>> productCodeList = manageProductService.getProductCode();

		model.addAttribute("productCodeList", productCodeList);

		return "adminManageActiveProductListPage/adminManageActiveProductListPage"; // 뷰리졸버에 의해
																					// /WEB-INF/views/login.jsp로 매핑됨

	}

	@GetMapping("/add-product") // 실제 요청 경로: /users/login
	public String showgAdProductPage(Model model) {

		List<Map<String, Object>> productCodeList = manageProductService.getProductCode();
		List<WarehouseVO> wareHouseList = manageInventoryService.getWarehouseList();
		model.addAttribute("productCodeList", productCodeList);
		model.addAttribute("wareHouseList", wareHouseList);
		return "adminManageAdProductPage/adminManageAdProductPage"; // 뷰리졸버에 의해
																	// /WEB-INF/views/login.jsp로 매핑됨

	}

}
