package com.spring.finall.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.spring.finall.reqDto.orderRequest.OrderItemDTO;
import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.payMentRequest.PaymentDTO;
import com.spring.finall.reqDto.wrapperRequest.OrderPaymentRequestDTO;
import com.spring.finall.user.OrderStatusVO;

public interface OrderService {

	String checkoutDraftOrder(Map<String, Object> params, OrderRequestDTO orderRequestDTO);

	Boolean checkOneOrderAmount(Map<String, Object> params, Integer amount);

	Boolean duplicateOrderCheck(String merchantUid);

	boolean afterSuccesspaymentComplement(OrderRequestDTO orderRequestDTO, PaymentDTO paymentDTO);

	/**
	 * 주문을 생성하고 연관된 주문 항목, 주문자 정보를 함께 저장합니다. 트랜잭션이 보장되어야 합니다.
	 * 
	 * @param orderRequest 주문 요청 DTO
	 * @return 성공 여부
	 */
	boolean placeOrder(OrderRequestDTO orderRequestDTO, PaymentDTO paymentDTO);

	boolean updateOrderStatusToSuccess(String merchantUid);

	/**
	 * 주문 목록을 페이징 조회 (6개월 이내)
	 * 
	 * @param startDate 시작일
	 * @param endDate   종료일
	 * @param offset    페이징 시작 인덱스
	 * @param limit     페이징 사이즈
	 * @return 주문 목록(OrderRequestDTO 리스트)
	 */
	List<OrderPaymentRequestDTO> getPagedOrders(LocalDate startDate, LocalDateTime endDate, int offset, int limit,
			int user_code);

	Map<String, Object> getOrdersCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek);

	Map<String, Object> findOrdersByFilter(LocalDate startOfWeek, LocalDate endOfWeek, String statusCode);

	List<OrderStatusVO> getOrderStatusList();

	Map<String, Object> findOrdersDetailByOrderInfoId(String orderInfoId);
	boolean updateDraftStatusCancle(String user_id);
	boolean updateOrderStatusToRefunded( String impUid,    		String merchantUid,String orderInfoId ,String paymentId, List<OrderItemDTO> orderList);

}
