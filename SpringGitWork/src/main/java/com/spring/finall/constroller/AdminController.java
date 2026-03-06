package com.spring.finall.constroller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.apiResponseController.ApiResponse;
import com.spring.finall.exception.applicantDocumentException.ApplicantDocumentException;
import com.spring.finall.exception.common.CommonFileException;
import com.spring.finall.reqDto.InsertCategoryRequestDTO;
import com.spring.finall.reqDto.atemptStockInRequestDTO.AtemptStockInRequestDTO;
import com.spring.finall.reqDto.atemptStockInRequestDTO.AtemptStockInWrapperDTO;
import com.spring.finall.reqDto.deliverRequest.RequestDeliverDTO;
import com.spring.finall.reqDto.newInsertVendorRequest.newInsertVendorRequest;
import com.spring.finall.reqDto.orderRequest.OrderItemDTO;
import com.spring.finall.reqDto.refundRequest.AfterSuccesPgRefundDTO;
import com.spring.finall.resDto.mannageUserListResPonse.ManageUserListResponseDTO;
import com.spring.finall.service.ApplicantDocumentService;
import com.spring.finall.service.CategoryService;
import com.spring.finall.service.DeliverService;
import com.spring.finall.service.ManageInventoryService;
import com.spring.finall.service.ManageProductService;
import com.spring.finall.service.ManageUserService;
import com.spring.finall.service.OrderService;
import com.spring.finall.service.ProductRefundService;
import com.spring.finall.service.VendorService;
import com.spring.finall.user.ProductGroupVO;
import com.spring.finall.user.ProductVO;

@Controller
@RequestMapping("/api/admin")
public class AdminController {

	String APIKEY = "sk_test_5F3C2D1A9B8E7F6G";
	private final String IMP_SECRET_KEY = "sk_test_5F3C2D1A9B8E7F6G";

	@Autowired
	private OrderService orderService;

	@Autowired
	private ProductRefundService productService;

	@Autowired
	private ApplicantDocumentService applicantDocumentService;

	@Autowired
	private ManageProductService manageProductService;

	@Autowired
	private ManageInventoryService manageInventoryService;

	@Autowired
	private ManageUserService manageUserService;

	@Autowired
	private DeliverService deliverService;
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private VendorService vendorService;
	
	// unread-document-list
	@GetMapping("/get-unread-document-list") // 실제 요청 경로: /users/login
	@ResponseBody
	public Map<String, Object> getUnreadDocumentList(@RequestParam(required = false) String stDate,
			@RequestParam(required = false) String edDate) {
		// stDate, edDate가 null일 수 있음

		List<Map<String, Object>> unReadDocumentList = applicantDocumentService.getUnreadDocumentList(stDate, edDate);

		Map<String, Object> resData = new HashMap<>();

		resData.put("unReadDocumentList", unReadDocumentList);

		return resData;

	}

	@GetMapping("/get-readed-document-list")
	@ResponseBody
	public Map<String, Object> getReadedDocumentList(

	) {

		List<Map<String, Object>> unReadDocumentList = applicantDocumentService.getReadedDocumentList();

		Map<String, Object> resData = new HashMap<>();

		resData.put("readDocumentList", unReadDocumentList);

		return resData;

	}

	@PostMapping("/get-document-file")
	@ResponseBody
	public ResponseEntity<Resource> getDocumentFile(@RequestParam Long teacherId) throws IOException {

		// DB 조회로 파일 경로 가져오기
		String filePath = applicantDocumentService.getFilePathByTeacherId(teacherId);
		if (filePath == null || filePath.isEmpty()) {
			return ResponseEntity.notFound().build();
		}

		Path path = Paths.get(filePath);
		if (!Files.exists(path)) {
			return ResponseEntity.notFound().build();
		}

		Resource resource = new UrlResource(path.toUri());

		// 파일 이름 추출
		String fileName = path.getFileName().toString();

		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"").body(resource);
	}

	// update-document-status

	// 상태 업데이트
	@PostMapping("/update-document-status")
	public ResponseEntity<ApiResponse<Map<String, Object>>> updateDocumentStatus(@RequestParam Long teacherId,
			@RequestParam String status) {

		ApiResponse<Map<String, Object>> apiRes = null;
		Map<String, Object> resBodyData = new HashMap<>();

		// 상태 값 검증
		if (!"Approved".equals(status) && !"Rejected".equals(status) && !"Insufficient".equals(status)
				&& !"Resubmit".equals(status)) {

			resBodyData.put("error_code", 4003);

			apiRes = ApiResponse.<Map<String, Object>>builder().code(4003).success(true).message(
					"잘못된 요청입니다. @RequestParam String status 는 빈값이거나 Approved, Rejected, Insufficient, Resubmit 중 하나여야 합니다.")
					.data(resBodyData).build();

			return ResponseEntity.status(400).body(apiRes);
		}

		try {

			boolean updated = applicantDocumentService.updateDocumentStatus(teacherId, status);

			apiRes = ApiResponse.<Map<String, Object>>builder().code(201).success(true).message("서류 상태가 변경되었습니다.")
					.data(resBodyData).build();

			return ResponseEntity.status(200).body(apiRes);
		} catch (ApplicantDocumentException ade) {
			resBodyData.put("error_code", 4001);
			apiRes = ApiResponse.<Map<String, Object>>builder().code(201).success(true).message("잠시후 다시 시도해주세요")
					.data(resBodyData).build();

			return ResponseEntity.status(4000).body(apiRes);

		} catch (Exception e) {
			resBodyData.put("error_code", 5001);
			apiRes = ApiResponse.<Map<String, Object>>builder().code(201).success(true).message("서버상의 에러가 의심됨")
					.data(resBodyData).build();

			return ResponseEntity.status(5000).body(apiRes);

		}

	}

	// 상품 그룹 선택 시 활성 상품 리스트 반환
	@PostMapping("/get-active-product-list")
	@ResponseBody
	public Map<String, Object> getActiveProductList(@RequestParam("groupId") int groupId) {
		Map<String, Object> result = new HashMap<>();

		try {
			// 서비스 호출
			List<Map<String, Object>> productList = manageProductService.getActiveProductList(groupId);

			result.put("success", true);
			// 아오 빈배열이면 프론트에서 적절히 처리하자. 이거 때문에 캐쉬 로직이 꼬임
			result.put("data", productList);

		} catch (Exception e) {
			result.put("success", false);
			result.put("message", e.getMessage());
		}

		return result;
	}

	// 상품 상태 업데이트
	@PostMapping("/update-product-status")
	@ResponseBody
	public Map<String, Object> updateProductStatus(@RequestParam("productId") int productId,
			@RequestParam("status") String status) {
		Map<String, Object> result = new HashMap<>();
		try {
			manageProductService.updateProductStatus(productId, status);
			result.put("success", true);
			result.put("message", "상태가 변경되었습니다.");
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "상태 변경 실패: " + e.getMessage());
		}
		return result;
	}

//	@PostMapping("/add-product")
//	@ResponseBody
//	public ResponseEntity<ApiResponse<Map<String, Object>>> addProduct(@RequestParam("group_id") int groupId,
//			@RequestParam("product_group") String product_group, @RequestParam("product_name") String name,
//			@RequestParam("product_price") int price,
//			@RequestParam(value = "online_product_quantity", required = false, defaultValue = "0") int online_product_quantity,
//			@RequestParam(value = "product_info", required = false) String info,
//			@RequestParam(value = "product_img", required = false) MultipartFile img,
//			// 🔹 추가된 부분 (창고 ID 리스트)
//			@RequestParam(value = "warehouse_id[]", required = false) List<Long> warehouseIds,
//
//			// 🔹 창고별 수량 Map (product_quantity[창고ID] 형태로 들어옴)
//			@RequestParam Map<String, String> allParams) {
//		Map<String, Object> resBodyData = new HashMap<>();
//
//		ApiResponse<Map<String, Object>> apiRes = null;
//
//		try {
//			ProductVO productVO = new ProductVO();
//
//			productVO.setProduct_group(product_group);
//			productVO.setGroup_id(groupId);
//			productVO.setProduct_name(name);
//			productVO.setProduct_price(price);
//			productVO.setProduct_quantity(online_product_quantity);
//			productVO.setProduct_info(info);
//
//			// 🔹 창고별 수량만 추출
//			// 🔹 창고별 수량 Map 생성
//			Map<String, Integer> quantityMap = new HashMap<>();
//
//			Iterator<Map.Entry<String, String>> it = allParams.entrySet().iterator();
//			while (it.hasNext()) {
//				Map.Entry<String, String> entry = it.next();
//				String key = entry.getKey();
//
//				if (key.startsWith("product_quantity[")) {
//					// [] 안의 값이 창고ID
//					String warehouseId = key.substring("product_quantity[".length(), key.length() - 1);
//					String valueStr = entry.getValue();
//
//					// 안전하게 Integer 변환
//					int quantity = 0;
//					if (valueStr != null && !valueStr.isEmpty()) {
//						try {
//							quantity = Integer.parseInt(valueStr);
//						} catch (NumberFormatException e) {
//							System.out.println("Invalid quantity for warehouse " + warehouseId + ": " + valueStr);
//						}
//					}
//
//					quantityMap.put(warehouseId, quantity);
//				} else {
//					// 🔹 나머지 키는 제거
//					it.remove();
//				}
//			}
//
//			manageProductService.saveProduct(productVO, img, warehouseIds, quantityMap);
//			resBodyData.put("success", true);
//
//			apiRes = ApiResponse.<Map<String, Object>>builder().code(201).success(true).message("상품을 등록하였습니다.")
//					.data(resBodyData).build();
//			return ResponseEntity.status(200).body(apiRes);
//
//		} catch (CommonFileException cfe) {
//			resBodyData.put("success", false);
//			resBodyData.put("message", cfe.getMessage());
//
//			apiRes = ApiResponse.<Map<String, Object>>builder().code(cfe.getBussinessCode()).success(false)
//					.message(cfe.getMessage()).data(resBodyData).build();
//			return ResponseEntity.status(400).body(apiRes);
//
//		}
//
//	}
//		
	
	@PostMapping("/atempt-StockIn")
	public ResponseEntity<?> atemptStockIn(
	        @RequestBody AtemptStockInWrapperDTO request) {

	    List<AtemptStockInRequestDTO> purchaseList = request.getPurchaceRows();
	    List<AtemptStockInRequestDTO> initialList = request.getInitialRows();

	    
	    
	    manageInventoryService.atemptStockIn(purchaseList, initialList);
	    if (purchaseList != null) {
	        purchaseList.forEach(dto ->
	            System.out.println("일반입고: " + dto.getProductId())
	        );
	    }

	    if (initialList != null) {
	        initialList.forEach(dto ->
	            System.out.println("최초입고: " + dto.getProductId())
	        );
	    }

	    return ResponseEntity.ok().build();
	}
	
	
	
	@PostMapping("/insert-product-infomation")
	@ResponseBody
	public ResponseEntity<ApiResponse<Map<String, Object>>> insertProductInfomation(
			@RequestParam("group_id") int groupId,
			@RequestParam("category_id") int category_id,
			@RequestParam("vendor_id") int vendor_id,			
			@RequestParam("product_group") String product_group,
			@RequestParam("product_name") String name,
			@RequestParam("product_price") int price,
			@RequestParam(value = "online_product_quantity", required = false, defaultValue = "0") int online_product_quantity,
			@RequestParam(value = "product_info", required = false) String info,
			@RequestParam(value = "product_img", required = false) MultipartFile img
		) {
		Map<String, Object> resBodyData = new HashMap<>();

		ApiResponse<Map<String, Object>> apiRes = null;

		try {
			ProductVO productVO  = new ProductVO();
			productVO.setVendor_id(vendor_id);
			productVO.setCategory_id(category_id);
			productVO.setProduct_group(product_group);
			productVO.setGroup_id(groupId);
			productVO.setProduct_name(name);
			productVO.setProduct_price(price);
			productVO.setProduct_quantity(online_product_quantity);
			productVO.setProduct_info(info);

		

			manageProductService.insertProductInfomation(productVO,img);
			resBodyData.put("success", true);

			apiRes = ApiResponse.<Map<String, Object>>builder().code(201).success(true).message("상품을 등록하였습니다.")
					.data(resBodyData).build();
			return ResponseEntity.status(200).body(apiRes);

		} catch (CommonFileException cfe) {
			resBodyData.put("success", false);
			resBodyData.put("message", cfe.getMessage());

			apiRes = ApiResponse.<Map<String, Object>>builder().code(cfe.getBussinessCode()).success(false)
					.message(cfe.getMessage()).data(resBodyData).build();
			return ResponseEntity.status(400).body(apiRes);

		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	@PostMapping("/add-product-group")
	@ResponseBody
	public ResponseEntity<ApiResponse<Map<String, Object>>> addProductGroup(
			@RequestParam("group_name") String group_name) {

		ProductGroupVO productGroupVO = new ProductGroupVO();
		productGroupVO.setGroupName(group_name);

		Map<String, Object> resBodyData = new HashMap<>();

		ApiResponse<Map<String, Object>> apiRes = null;
		try {
			manageProductService.addProductGroup(productGroupVO);
			resBodyData.put("success", true);
			resBodyData.put("insertedPk", productGroupVO.getGroupId());
			resBodyData.put("groupName", group_name);

			apiRes = ApiResponse.<Map<String, Object>>builder().code(201).success(true).message("상품 그룹을 추가하였습니다.")
					.data(resBodyData).build();
			return ResponseEntity.status(200).body(apiRes);
		} catch (CommonFileException cfe) {
			resBodyData.put("success", false);
			resBodyData.put("message", cfe.getMessage());

			apiRes = ApiResponse.<Map<String, Object>>builder().code(cfe.getBussinessCode()).success(false)
					.message("상품 그룹 추가 실패" + cfe.getMessage()).data(resBodyData).build();
			return ResponseEntity.status(400).body(apiRes);

		}

	}
	
	
	
	
	
	
	

	// order-list
	@GetMapping("/search-order-list-with-date")
	@ResponseBody
	public Map<String, Object> searchOrders(
			@RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
			@RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
			@RequestParam(value = "status", required = false) String statusCode, // 상태 추가
			Model model) {

		LocalDate today = LocalDate.now();

		// startDate, endDate가 없으면 이번 주 기본
		if (startDate == null || endDate == null) {
			startDate = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
			endDate = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
		}

		// 서비스 메서드에 상태 필터 포함
		Map<String, Object> ordersSummary = orderService.findOrdersByFilter(startDate, endDate, statusCode);

		Map<String, Object> resData = new HashMap<>();
		resData.put("ordersSummary", ordersSummary);
		resData.put("startDate", startDate.toString()); // <- LocalDate -> String
		resData.put("endDate", endDate.toString()); // <- LocalDate -> String
		resData.put("status", statusCode);

		return resData;
	}

	// order-list
	@GetMapping("/get-order-detail")
	@ResponseBody
	public Map<String, Object> searchOrders(

			@RequestParam("orderInfoId") String orderInfoId, // 상태 추가
			Model model) {

		Map<String, Object> ordersDetail = orderService.findOrdersDetailByOrderInfoId(orderInfoId);
		Map<String, Object> resBodyData = new HashMap<>();

		resBodyData.put("orderItemListte", ordersDetail.get("orderItemListte"));
		resBodyData.put("paymentInfo", ordersDetail.get("paymentInfo"));
		resBodyData.put("orderItemList", ordersDetail.get("orderItemList"));

		return resBodyData;
	}

	private final RestTemplate restTemplate = new RestTemplate();

	@PostMapping("/delegate-to-pg-refund")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> sendPayCancel(@RequestParam("impUid") String impUid,
			@RequestParam("merchantUid") String merchantUid, @RequestParam("amount") int amount,
			@RequestParam("orderInfoId") String orderInfoId
			) {

		Map<String, Object> resBodyData = new HashMap<>();

		try {
			ResponseEntity<Map<String, Object>> resFromPgServer = sendRefund(impUid, merchantUid, amount,
					IMP_SECRET_KEY);

			HttpStatus pgStatus = resFromPgServer.getStatusCode();
			Map<String, Object> pgBody = resFromPgServer.getBody();

			// JSON 바디에서 success, message 추출
			Boolean success = pgBody != null ? (Boolean) pgBody.get("success") : false;
			String message = pgBody != null ? (String) pgBody.get("message") : "PG 서버 응답 없음";

			resBodyData.put("success", success);
			resBodyData.put("message", message);

			// PG 상태 코드에 따라 Spring 상태 코드 설정
			if (pgStatus.is2xxSuccessful()) {
				
				
				
				return ResponseEntity.ok(resBodyData); // 성공
			} else if (pgStatus.is4xxClientError()) {
				return ResponseEntity.status(400).body(resBodyData);
			} else if (pgStatus.is5xxServerError()) {
				return ResponseEntity.status(500).body(resBodyData);
			} else {
				return ResponseEntity.status(pgStatus).body(resBodyData); // 기타 상태
			}

		} catch (Exception e) {
			resBodyData.put("success", false);
			resBodyData.put("message", "PF 서버 요청 중 오류 발생: " + e.getMessage());
			return ResponseEntity.status(500).body(resBodyData);
		}
	}

	
	
	@PostMapping("/payment-Cancelle-by-admmin")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> paymentCancelleByAdmmin(@RequestParam("impUid") String impUid,
			@RequestParam("merchantUid") String merchantUid, @RequestParam("amount") int amount,
			@RequestParam("orderInfoId") String orderInfoId
			) {

		Map<String, Object> resBodyData = new HashMap<>();

		try {
			ResponseEntity<Map<String, Object>> resFromPgServer = sendRefund(impUid, merchantUid, amount,
					IMP_SECRET_KEY);

			HttpStatus pgStatus = resFromPgServer.getStatusCode();
			Map<String, Object> pgBody = resFromPgServer.getBody();

			// JSON 바디에서 success, message 추출
			Boolean success = pgBody != null ? (Boolean) pgBody.get("success") : false;
			String message = pgBody != null ? (String) pgBody.get("message") : "PG 서버 응답 없음";

			resBodyData.put("success", success);
			resBodyData.put("message", message);

			// PG 상태 코드에 따라 Spring 상태 코드 설정
			if (pgStatus.is2xxSuccessful()) {			
				
				
				return ResponseEntity.ok(resBodyData); // 성공
			} else if (pgStatus.is4xxClientError()) {
				return ResponseEntity.status(400).body(resBodyData);
			} else if (pgStatus.is5xxServerError()) {
				return ResponseEntity.status(500).body(resBodyData);
			} else {
				return ResponseEntity.status(pgStatus).body(resBodyData); // 기타 상태
			}

		} catch (Exception e) {
			resBodyData.put("success", false);
			resBodyData.put("message", "PF 서버 요청 중 오류 발생: " + e.getMessage());
			return ResponseEntity.status(500).body(resBodyData);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	public ResponseEntity<Map<String, Object>> sendRefund(String impUid, String merchantUid, int amount,
			String IMP_SECRET_KEY) throws Exception {
		// 1️⃣ payload 생성
		String payload = impUid + "|" + merchantUid + "|" + amount;

		// 2️⃣ HMAC-SHA256
		Mac mac = Mac.getInstance("HmacSHA256");
		SecretKeySpec secretKeySpec = new SecretKeySpec(IMP_SECRET_KEY.getBytes(), "HmacSHA256");
		mac.init(secretKeySpec);
		byte[] digest = mac.doFinal(payload.getBytes());

		// 3️⃣ Base64 인코딩
		String signature = Base64.getEncoder().encodeToString(digest);

		// 4️⃣ HTTP 요청 헤더에 추가
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("X-Signature", signature);

		// 5️⃣ body
		Map<String, Object> body = new HashMap<>();
		body.put("impUid", impUid);
		body.put("merchantUid", merchantUid);
		body.put("amount", amount);
		body.put("status", "cancelled");

		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

		// 6️⃣ RestTemplate 요청
		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost:7010/api/complete-paycancel"; // fakePG Express URL

		ResponseEntity<Map<String, Object>> response = restTemplate.exchange(url, HttpMethod.POST, entity,
				new ParameterizedTypeReference<Map<String, Object>>() {
				});

		return response;

	}

	@PostMapping("/after-succes-pg-refund")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> afterSuccesPgRefund(@RequestBody AfterSuccesPgRefundDTO request) {

		// 단일 값 사용
		String impUid = request.getImpUid();
		String merchantUid = request.getMerchantUid();
		String orderInfoId = request.getOrderInfoId();
		String paymentId = request.getPaymentId();
		int amount = request.getAmount();
		// 주문 항목 리스트
		List<OrderItemDTO> orderList = request.getOrderItemList();

		Map<String, Object> resBodyData = new HashMap<>();
		boolean status = orderService.updateOrderStatusToRefunded(impUid, merchantUid, orderInfoId, paymentId,
				orderList);
		if (!status) {
			resBodyData.put("message", "백엔드 디비 에러");
			return ResponseEntity.status(500).body(resBodyData);

		}
		resBodyData.put("message", "PG사로부터 정식 환불이 되었으며, 재고반영에 성공하였습니다.");
		return ResponseEntity.status(200).body(resBodyData);
	}
	
	
	
	@PostMapping("/cancelled-by-admin-after-succes-pg-refund")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> cancelledByAdminAfterSuccesPgRefund(@RequestBody AfterSuccesPgRefundDTO request) {

		// 단일 값 사용
		String impUid = request.getImpUid();
		String merchantUid = request.getMerchantUid();
		String orderInfoId = request.getOrderInfoId();
		String paymentId = request.getPaymentId();
		int amount = request.getAmount();
		// 주문 항목 리스트
		List<OrderItemDTO> orderList = request.getOrderItemList();

		Map<String, Object> resBodyData = new HashMap<>();
		boolean status = orderService.updateOrderStatusToRefunded(impUid, merchantUid, orderInfoId, paymentId,
				orderList);
		if (!status) {
			resBodyData.put("message", "백엔드 디비 에러");
			return ResponseEntity.status(500).body(resBodyData);

		}
		resBodyData.put("message", "PG사로부터 정식 환불이 되었으며, 재고반영에 성공하였습니다.");
		return ResponseEntity.status(200).body(resBodyData);
	}
	
	
	

	@PostMapping("/delegate-to-deliver")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> requestDeliver(@RequestBody List<RequestDeliverDTO> requestList) {

		Map<String, Object> resBodyData = new HashMap<>();
		resBodyData.put("success", true);
		try {
			deliverService.ShipmentItem(requestList);
			resBodyData.put("message", "실물 배송이 이루어 졌으며 실물 재고가 창고별로 업데이트 되었습니다.");
			return ResponseEntity.status(200).body(resBodyData);
		} catch (Exception e) {
			resBodyData.put("success", false);
			resBodyData.put("message", "실물 배송이 이루어 졌으며 실물 재고가 창고별로 업데이트 되었습니다.");
			return ResponseEntity.status(500).body(resBodyData);

		}

	}

	@PostMapping("/get-userlist")
	@ResponseBody
	public ResponseEntity<Map<String, List<ManageUserListResponseDTO>>> getUserList() {		
		Map<String,List<ManageUserListResponseDTO>> map = new HashMap<>();
		map.put("findUserList", manageUserService.getUserList());		
	return	ResponseEntity.status(200).body(map);
	}
	
	// new-vendor-insert
	@PostMapping("/new-vendor-insert")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> newVendorInsert(
	        @RequestBody newInsertVendorRequest newInsertVendorRequestVO) {

	    System.out.println("받은 데이터 = " + newInsertVendorRequestVO.toString());

	    int result = vendorService.newVendorInsert(newInsertVendorRequestVO);

	    Map<String, Object> resBodyData = new HashMap<>();

	    if (result > 0) { // 성공
	        resBodyData.put("success", true);
	        resBodyData.put("message", "거래처 등록 완료!");
	        return ResponseEntity.ok(resBodyData);

	    } else if (result == -1) { // 중복 사업자 번호
	        resBodyData.put("success", false);
	        resBodyData.put("message", "사업자 번호가 이미 존재합니다.");
	        return ResponseEntity.status(HttpStatus.CONFLICT).body(resBodyData);

	    } else if (result == -2) { // 무결성 위반 (DB 제약 조건 등)
	        resBodyData.put("success", false);
	        resBodyData.put("message", "데이터 무결성 오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(resBodyData);

	    } else { // 기타 서버 오류
	        resBodyData.put("success", false);
	        resBodyData.put("message", "서버 내부 오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(resBodyData);
	    }
	}

	
	
	@PostMapping("/category-insert")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> categoryInsert(
	        @RequestBody InsertCategoryRequestDTO insertCategoryRequestDTO) {
		
		int result= categoryService.insertCategory(insertCategoryRequestDTO);
		
		
		
		  Map<String, Object> resBodyData = new HashMap<>();

		    if (result > 0) { // 성공
		        resBodyData.put("success", true);
		        resBodyData.put("message", "거래처 등록 완료!");
		        return ResponseEntity.ok(resBodyData);

		    } else if (result == -1) { // 중복 사업자 번호
		        resBodyData.put("success", false);
		        resBodyData.put("message", "사업자 번호가 이미 존재합니다.");
		        return ResponseEntity.status(HttpStatus.CONFLICT).body(resBodyData);

		    } else if (result == -2) { // 무결성 위반 (DB 제약 조건 등)
		        resBodyData.put("success", false);
		        resBodyData.put("message", "데이터 무결성 오류가 발생했습니다.");
		        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(resBodyData);

		    } else { // 기타 서버 오류
		        resBodyData.put("success", false);
		        resBodyData.put("message", "서버 내부 오류가 발생했습니다.");
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(resBodyData);
		    }
	}
	
	
	
}
