package com.spring.finall.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.deliverRequest.RequestDeliverDTO;
import com.spring.finall.reqDto.orderRequest.OrderItemDTO;
import com.spring.finall.reqDto.orderRequest.OrderPersonDTO;
import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.wrapperRequest.OrderPaymentRequestDTO;
import com.spring.finall.user.OrderStatusVO;
import com.spring.finall.user.ProductVO;

@Repository
public class OrderServiceDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public List<Map<String, Object>> selectOneDraftOrder(String user_id) {

		List<Map<String, Object>> myDraftOrderInfoList = mybatis.selectList("OrderDAO.selectOneDraftOrder", user_id);

		// OrderDAO
		return myDraftOrderInfoList;
	}

	public String checkOneOrderAmount(Map<String, Object> paramMap) {
		String merchant_uid = String.valueOf(paramMap.get("merchant_uid"));
		Map<String, Object> myDraftOrderInfo = mybatis.selectOne("OrderDAO.checkOneOrderAmount", merchant_uid);
		// OrderDAO
		String draft_total_amount = String.valueOf(myDraftOrderInfo.get("draft_total_amount"));

		return draft_total_amount;
	}

	public Long insertDraftOrder(Map<String, Object> paramMap) {

		mybatis.insert("OrderDAO.insertDraftOrderInfo", paramMap);
		Long orderInfoId = (Long) paramMap.get("orderInfoId"); // 키 가져오기
		return orderInfoId; // int로 반환
	}

	public Long insertDraftOrderItem(Map<String, Object> params) {
		Map<String, Object> param = new HashMap<>();
		mybatis.insert("OrderDAO.insertDraftOrderItem", params);
		Long draft_order_info_id = (Long) params.get("draft_order_info_id"); // 키 가져오기
		return draft_order_info_id; // int로 반환
	}

	public int insertDraftOrderItemList(Long orderInfoId, List<OrderItemDTO> items) {
		Map<String, Object> param = new HashMap<>();
		param.put("orderInfoId", orderInfoId);
		param.put("list", items);
		int affectedRows = mybatis.insert("OrderDAO.insertDraftOrderItemList", param);

		return affectedRows;
	}

	public int updateDraftOrderItem(Map<String, Object> params) {

		int affectedRow = mybatis.update("OrderDAO.updateDraftOrderItem", params);

		return affectedRow; // int로 반환
	}

	public int updateOrderItemList(Long order_info_id, List<OrderItemDTO> items) {
		int affectedRows = 0;

		for (OrderItemDTO item : items) {
			Map<String, Object> param = new HashMap<>();
			param.put("order_info_id", order_info_id);
			param.put("order_item_id", item.getOrderItemId());
			param.put("product_id", item.getProductId());
			param.put("product_name", item.getProductName());
			param.put("quantity", item.getQuantity());
			param.put("price_per_unit", item.getPricePerUnit());

			affectedRows += mybatis.update("OrderDAO.updateOrderItemList", param);
		}

		return affectedRows;
	}

	public boolean updateOrderStatusToSuccess(String merchantUid) {

		boolean 업데이트상태 = false;
		int affectedRow = mybatis.update("OrderDAO.OrderStatusToSuccess", merchantUid);

		업데이트상태 = affectedRow > 0 ? true : false;

		return 업데이트상태; // int로 반환
	}

	

	
	public boolean duplicateOrderCheck(String merchantUid) {
		boolean 같은주문번호니 = false;

		Map<String, Object> orderInfo = mybatis.selectOne("OrderDAO.duplicateOrderCheck", merchantUid);
		if (orderInfo != null && !orderInfo.isEmpty()) {
			같은주문번호니 = true;
		}

		return 같은주문번호니;
	}

	public Long selectOneOrderInfoId(String merchantUid) {
		Map<String, Object> orderInfoObj = mybatis.selectOne("OrderDAO.selectOneOrderInfoId", merchantUid);
		Long orderInfoId = null;
		if (orderInfoObj != null)
			orderInfoId = (Long) orderInfoObj.get("order_info_id");
		return orderInfoId;
	}

//이 아래는 나중에 지워라. 아깝지만 실패한 코드임	

	// 1. 주문 기본 정보 insert (order_info)
	public Long insertOrderInfo(OrderRequestDTO orderRequest) {
		mybatis.insert("OrderDAO.insertOrderInfo", orderRequest);
		// order_info_id는 MyBatis에서 useGeneratedKeys로 orderRequest에 자동 set된다고 가정
		return orderRequest.getOrderInfoId();
	}

	// 1. 주문 정보를 팬딩에서 완료료 없데이트
//	public int updateOrderStatusToSuccess() {
//		mybatis.update("OrderDAO.updateOrderStatusToSuccess")
//		
//	}

	public boolean updateStockByOrderItemsQuantity(List<OrderItemDTO> orderList) {
		try {
			for (OrderItemDTO item : orderList) {

				Long productId = item.getProductId();
				// 1. row-level lock
				ProductVO product = mybatis.selectOne("OrderDAO.selectProductForUpdate", productId);

				if (product == null) {
					throw new RuntimeException("상품 없음: " + item.getProductId());
				}

				// 2. 재고 체크
				if (product.getProduct_quantity() < item.getQuantity()) {
					throw new RuntimeException("재고 부족: " + product.getProduct_quantity());
				}

				// 3. 재고 차감
				mybatis.update("OrderDAO.updateStockByOrderItemsQuantity", item);
			}

			return true; // 정상 처리

		} catch (Exception e) {
			e.printStackTrace();
			// 예외 발생 시 자동 롤백됨 (@Transactional)
			return false;
		}
	}
	
	
	
	
	public boolean updateStockByOrderItemsQuantityCausePayCancel(List<OrderItemDTO> orderList) {
		try {
			for (OrderItemDTO item : orderList) {

				Long productId = item.getProductId();
				// 1. row-level lock
				ProductVO product = mybatis.selectOne("OrderDAO.selectProductForUpdate", productId);			

				// 3. 재고 올림
				mybatis.update("OrderDAO.updateStockByOrderItemsQuantityCausePayCancel", item);
			}

			return true; // 정상 처리

		} catch (Exception e) {
			e.printStackTrace();
			// 예외 발생 시 자동 롤백됨 (@Transactional)
			return false;
		}
	}

	
	
	
	
	
	
	
	
	

	// 2. 주문 상품들 insert (order_item)
	public int insertOrderItems(Long orderInfoId, List<OrderItemDTO> items) {
		Map<String, Object> param = new HashMap<>();
		param.put("orderInfoId", orderInfoId);
		param.put("list", items);
		int affectedRows = mybatis.insert("OrderDAO.insertOrderItems", param);

		return affectedRows;
	}

	// 3. 주문자 정보 insert (order_person)
	public int insertOrderPerson(Long orderInfoId, OrderPersonDTO person) {
		Map<String, Object> param = new HashMap<>();
		param.put("orderInfoId", orderInfoId);
		param.put("name", person.getName());
		param.put("email", person.getEmail());
		param.put("phone", person.getPhone());

		// 새로 추가한 컬럼
		param.put("zipcode", person.getZipcode());
		param.put("address", person.getAddress());
		param.put("address_detail", person.getAddress_detail());

		int affectedRows = mybatis.insert("OrderDAO.insertOrderPerson", param);
		return affectedRows;
	}
	
	
	
	public int updateOrderInfoStatusByAfterSuccesspaymentComplement(Long orderInfoId) {
		Map<String, Object> param = new HashMap<>();
		param.put("orderInfoId", orderInfoId);
		int affectedRows = mybatis.insert("OrderDAO.updateOrderInfoStatusByAfterSuccesspaymentComplement", param);
		return affectedRows;
		
	}

	// 2. 페이징으로 6개월 이내 주문 목록 조회
	public List<OrderPaymentRequestDTO> selectOrdersByDateWithPaging(LocalDate startDate, LocalDateTime endDate,
			int offset, int limit, int user_code) {
		Map<String, Object> params = new HashMap<>();
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("user_id", user_code);
//		// 1. 주문 ID 리스트 조회
//		List<Map<String, Object>> orderIdMaps = mybatis.selectList(
//		    "OrderDAO.findOrderInfoIdListByDateWithPaging", params
//		);
//
//		// order_info_id만 추출
//		List<Long> orderIds = orderIdMaps.stream()
//		    .map(m -> ((Number) m.get("order_info_id")).longValue())
//		    .collect(Collectors.toList());
//
//		// 2. 주문 아이템 + 결제 + 주문자 정보 조회
//		if (!orderIds.isEmpty()) {
//		    List<Map<String, Object>> orderItems = mybatis.selectList(
//		        "OrderDAO.findOrderItemsList", orderIds
//		    );
//
//		    // 로그 확인
//		    orderItems.forEach(System.out::println);
//		}

		return mybatis.selectList("OrderDAO.selectOrdersByDateWithPaging", params);
	}

	public Map<String, Object> getOrdersCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek) {

		Map<String, Object> params = new HashMap<>();
		params.put("startOfWeek", startOfWeek);
		params.put("endOfWeek", endOfWeek);

		// DB 조회
		List<Map<String, Object>> list = mybatis.selectList("OrderDAO.getOrdersCountByTodayAndWeek", params);

		int todayCount = 0;
		int weekCount = 0;

		LocalDate today = LocalDate.now();

		for (Map<String, Object> m : list) {
			Object obj = m.get("order_date");
			LocalDate orderDate;

			if (obj instanceof java.sql.Timestamp) {
				orderDate = ((java.sql.Timestamp) obj).toLocalDateTime().toLocalDate();
			} else if (obj instanceof java.sql.Date) {
				orderDate = ((java.sql.Date) obj).toLocalDate();
			} else if (obj instanceof java.util.Date) { // 혹시 java.util.Date
				orderDate = ((java.util.Date) obj).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			} else {
				throw new IllegalArgumentException("Unsupported date type: " + obj.getClass());
			}

			if (orderDate.isEqual(today)) {
				todayCount++;
			}

			if (!orderDate.isBefore(startOfWeek) && !orderDate.isAfter(endOfWeek)) {
				weekCount++;
			}
		}

		Map<String, Object> result = new HashMap<>();
		result.put("todayOrders", todayCount);
		result.put("weekOrders", weekCount);

		return result;
	}

	public List<OrderStatusVO> getOrderStatusList() {

		List<OrderStatusVO> orderStatusList = mybatis.selectList("ManageOrderMapper.getOrderStatusList");
		return orderStatusList;
	}

	public Map<String, Object> findOrdersByFilter(LocalDate startOfWeek, LocalDate endOfWeek, String statusCode) {

		Map<String, Object> params = new HashMap<>();
		params.put("startOfWeek", startOfWeek);
		params.put("endOfWeek", endOfWeek);
		if (statusCode != null && !statusCode.isBlank()) {
	        Integer statusId = orderStatusId(statusCode);
	        params.put("statusId", statusId);
	    }
	

		// DB 조회
		List<Map<String, Object>> list = mybatis.selectList("ManageOrderMapper.findOrdersByFilter", params);

		int todayCount = 0;
		int weekCount = 0;

		LocalDate today = LocalDate.now();

		for (Map<String, Object> m : list) {
			Object obj = m.get("order_date");
			LocalDate orderDate;

			if (obj instanceof java.sql.Timestamp) {
				orderDate = ((java.sql.Timestamp) obj).toLocalDateTime().toLocalDate();
			} else if (obj instanceof java.sql.Date) {
				orderDate = ((java.sql.Date) obj).toLocalDate();
			} else if (obj instanceof java.util.Date) { // 혹시 java.util.Date
				orderDate = ((java.util.Date) obj).toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			} else {
				throw new IllegalArgumentException("Unsupported date type: " + obj.getClass());
			}

			if (orderDate.isEqual(today)) {
				todayCount++;
			}

			if (!orderDate.isBefore(startOfWeek) && !orderDate.isAfter(endOfWeek)) {
				weekCount++;
			}
		}

		Map<String, Object> result = new HashMap<>();
		result.put("findOrders", list);

		return result;
	}
	
	
	private static final Map<String, Integer> ORDER_STATUS_MAP = Map.of(
	        "Pending", 1,
	        "Paid", 2,
	        "Preparing", 3,
	        "Shipping", 4,
	        "Delivered", 5,
	        "Cancelled", 6,
	        "RefundRequested", 7,
	        "Refunded", 8
	);

	private Integer orderStatusId(String statusCode) {
	    return ORDER_STATUS_MAP.get(statusCode);
	}

	
	

	public List<Map<String, Object>> findOrdersItemByOrderInfoId(String orderInfoId) {

		List<Map<String, Object>> list = mybatis.selectList("ManageOrderMapper.findOrdersItemByOrderInfoId",
				orderInfoId);

		return list;
	}

	public Map<String, Object> findPayInfoByOrderInfoId(String orderInfoId) {

		// MyBatis에서 조회
		List<Map<String, Object>> rawList = mybatis.selectList("PaymentDAO.findPayInfoByOrderInfoId", orderInfoId);

		// 결과 담을 Map
		Map<String, Object> resultMap = new HashMap<>();

		// 주문 항목 리스트
		List<Map<String, Object>> orderItemList = new ArrayList<>();

		// 결제 정보 (한 번만)
		Map<String, Object> paymentInfo = null;

		for (Map<String, Object> row : rawList) {
			// --------------------------
			// 1. 주문 항목 + 상품 정보
			// --------------------------
			Map<String, Object> item = new HashMap<>();	
			
			item.put("order_item_id", row.get("order_item_id"));
			item.put("order_info_id", row.get("order_info_id"));
			item.put("product_id", row.get("product_id"));			
			
			item.put("product_name", row.get("product_name"));
			item.put("price_per_unit", row.get("price_per_unit"));
			item.put("quantity", row.get("quantity"));
			item.put("product_info", row.get("product_info"));
			item.put("file_category", row.get("file_category"));
			item.put("file_name", row.get("file_name"));

			orderItemList.add(item);

			// --------------------------
			// 2. 결제 정보 (중복 제거)
			// --------------------------
			if (paymentInfo == null) {
				paymentInfo = new HashMap<>();
				if (row.get("payment_id") == null) {
					paymentInfo.put("payment_id", null);
					paymentInfo.put("payment_method", null);
					paymentInfo.put("paycreated_at", null);
					paymentInfo.put("payamount", null);
					paymentInfo.put("payment_number", null);
					paymentInfo.put("imp_uid", null);

				}

				else {
					paymentInfo.put("payment_id", row.get("payment_id"));
					paymentInfo.put("payment_method", row.get("payment_method"));
					paymentInfo.put("paycreated_at", row.get("paycreated_at"));
					paymentInfo.put("payamount", row.get("payamount"));
					paymentInfo.put("payment_number", row.get("payment_number"));
					paymentInfo.put("imp_uid", row.get("imp_uid"));
				}

			}
		}

		// --------------------------
		// 최종 Map 구성
		// --------------------------
		resultMap.put("orderItemList", orderItemList);
		resultMap.put("paymentInfo", paymentInfo);

		// JSON으로 반환 (Spring @RestController 기준)
		return resultMap;

	}

	public boolean updateDraftStatusCancle(String user_id) {
		int affectedRow = mybatis.update("OrderDAO.updateDraftStatusCancle", user_id);

		return affectedRow > 0 ? true : false;

	}
	//섹
	public boolean approveForReqeustClientPayCancel(String orderInfoId) {
		int affectedRow = mybatis.update("OrderDAO.approveForReqeustClientPayCancel", orderInfoId);

		return affectedRow > 0 ? true : false;

	}
public int orderInfoStatusByAdmminCancellPayment(String orderInfoId) {
		
		return mybatis.update("OrderDAO.orderInfoStatusByAdmminCancellPayment",orderInfoId);
	}
	
	public void updateStatusToShippingByShipping(List<RequestDeliverDTO> requestList) {
		
		Long  orderInfoId =	requestList.get(0).getOrderInfoId();
		
		
		mybatis.update("OrderDAO.updateStatusToShippingByShipping",orderInfoId);
		
	}
	
	
	public String getCurrentOrderStatusByOrderInfoId(String orderInfoId){
	    // selectOne로 단일 결과 조회
	    String status = mybatis.selectOne("OrderDAO.getCurrentOrderStatusByOrderInfoId", orderInfoId);
	    return status;
	}

	
	public  List<Map<String,Object>>  getInventoryListFindByOrderInfoId(String orderInfoId){
	    // selectOne로 단일 결과 조회
	    List<Map<String,Object>> ivList = mybatis.selectList("OrderDAO.getInventoryListFindByOrderInfoId", orderInfoId);
	    return ivList;
	}

	
	public boolean updateInventoryPlusQuantiryByInventoryId(List<Map<String, Object>> ivList) {
	    boolean allUpdated = true;
	    
	    for (Map<String, Object> iv : ivList) {
	        int updated = mybatis.update(
	            "ManageinventoryMapper.updateInventoryPlusQuantiryByInventoryId", 
	            iv
	        );
	        
	        // 업데이트가 1건이 아닌 경우 실패로 처리
	        if (updated != 1) {
	            allUpdated = false;
	        }
	    }
	    
	    return allUpdated;
	}

	
	public boolean recodeInventoryLogByRefund(List<Map<String, Object>> ivList) {

	    int inserted = mybatis.insert(
	        "ManageinventoryMapper.recodeInventoryLogByRefund",
	        ivList
	    );

	    return inserted > 0;
	}
	public boolean updateShipmentByRefund(List<Map<String, Object>> ivList) {
	    int totalUpdated = 0;
	    for (Map<String, Object> item : ivList) {
	        totalUpdated += mybatis.update("ManageinventoryMapper.updateShipmentByRefund", item);
	    }
	    return totalUpdated > 0;
	}

	

	
}
