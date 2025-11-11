package com.spring.finall.user;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.exception.orderexception.OrderException;
import com.spring.finall.impl.OrderServiceDAO;
import com.spring.finall.impl.PaymentServiceDAO;
import com.spring.finall.reqDto.orderRequest.OrderItemDTO;
import com.spring.finall.reqDto.orderRequest.OrderRequestDTO;
import com.spring.finall.reqDto.payMentRequest.PaymentDTO;
import com.spring.finall.reqDto.wrapperRequest.OrderPaymentRequestDTO;
import com.spring.finall.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderServiceDAO orderServiceDAO;

	@Autowired
	private PaymentServiceDAO paymentServiceDAO;

	@Override
	public String checkoutDraftOrder(Map<String, Object> params,OrderRequestDTO orderRequestDTO ) {

		String merchant_uid = null;
		String user_id = (String) params.get("user_id");
		
		List<Map<String, Object>> 	list=orderServiceDAO.selectOneDraftOrder(user_id);
		Map<String, Object> myDraftOrderInfo = null;
		boolean 장바구니가변했니=false;

		if(list!=null&& !list.isEmpty()) {
			myDraftOrderInfo = list.get(0);
			 장바구니가변했니=findUpdateDraftValues(params, myDraftOrderInfo);
		}		
		
		
		if(list!=null&& !list.isEmpty() &&!장바구니가변했니) {
			myDraftOrderInfo = list.get(0);
			List<Long> orderItemIdList= new ArrayList<Long>();
			
			for(int k=0; k<list.size(); k++) {
				Long order_item_id=	(Long)list.get(k).get("order_item_id");
				orderItemIdList.add(k, order_item_id);
				orderRequestDTO.getItems().get(k).setOrderItemId(order_item_id);
			}
			orderRequestDTO.setOrderItemId(orderItemIdList);	
			
		}				
				
		if (myDraftOrderInfo != null && !장바구니가변했니) {
			// DB UPDATE문 실행
			Long order_info_id=(Long)myDraftOrderInfo.get("order_info_id");
			params.put("order_info_id", order_info_id);
			orderServiceDAO.updateDraftOrderItem(params);
			//여기서 항목도 찾아서 업데이트해주는 DAO메서드 추가하자.
			orderServiceDAO.updateOrderItemList(order_info_id,orderRequestDTO.getItems());		
			
		}

		if (myDraftOrderInfo != null && 장바구니가변했니) {

			merchant_uid = (String) myDraftOrderInfo.get("merchant_uid");
		}

		if (myDraftOrderInfo == null) {
			// DB INSERT문 실행
			String merchantUid = "mid_" + System.currentTimeMillis() + "_" + (int) (Math.random() * 1000);

			// 2️⃣ 파라미터 준비
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("user_id", user_id);
			paramMap.put("merchant_uid", merchantUid);

			Long orderInfoId = orderServiceDAO.insertDraftOrder(paramMap);

			params.put("order_info_id", orderInfoId);
			Long draft_order_info_id = orderServiceDAO.insertDraftOrderItem(params);
			
			int affectedRow = orderServiceDAO.insertDraftOrderItemList(orderInfoId, orderRequestDTO.getItems());
			merchant_uid = merchantUid;
		}

		return merchant_uid;
	}

	public boolean findUpdateDraftValues(Map<String, Object> params, Map<String, Object> draftinfo) {
		Object draftTotalAmount = draftinfo.get("draft_total_amount");
		Object draftTotalQuantity = draftinfo.get("draft_total_quantity");

		Object totalPrice = params.get("draft_total_amount");
		Object totalQuantities = params.get("draft_total_quantity");

		// null 방지 및 BigDecimal 변환
		BigDecimal draftAmountBD = draftTotalAmount != null ? new BigDecimal(draftTotalAmount.toString()) : null;
		BigDecimal totalPriceBD = totalPrice != null ? new BigDecimal(totalPrice.toString()) : null;

		BigDecimal draftQuantityBD = draftTotalQuantity != null ? new BigDecimal(draftTotalQuantity.toString()) : null;
		BigDecimal totalQuantityBD = totalQuantities != null ? new BigDecimal(totalQuantities.toString()) : null;

		// 값(value) 비교 → compareTo() == 0이면 값이 같음
		boolean isAmountEqual = draftAmountBD != null && totalPriceBD != null
				&& draftAmountBD.compareTo(totalPriceBD) == 0;
		boolean isQuantityEqual = draftQuantityBD != null && totalQuantityBD != null
				&& draftQuantityBD.compareTo(totalQuantityBD) == 0;

		return isAmountEqual && isQuantityEqual;
	}

	
	
	@Override
	public boolean updateOrderStatusToSuccess(String merchantUid) {
		
		return orderServiceDAO.updateOrderStatusToSuccess(merchantUid);
	}
	
	@Transactional
	@Override
	public boolean afterSuccesspaymentComplement(OrderRequestDTO orderRequestDTO, PaymentDTO paymentDTO) {
		try {
		String merchantUid=orderRequestDTO.getMerchantUid();
		Long orderInfoId =orderServiceDAO.selectOneOrderInfoId(merchantUid);
		if (orderInfoId == null || orderInfoId <= 0) {
			throw new OrderException("해당 주문번호로, 주문번호 고유키를 찾을 수 없음");
		}		
	
		int personInserted = orderServiceDAO.insertOrderPerson(orderInfoId, orderRequestDTO.getPerson());
		if (personInserted <= 0) {
			throw new OrderException("주문자 정보 삽입 실패");
		}
		int totalAmount = 0;

		List<OrderItemDTO> orderList = orderRequestDTO.getItems();

		for (int i = 0; i < orderList.size(); i++) {
			totalAmount = +orderList.get(i).getQuantity();
		}

		paymentDTO.setAmount(totalAmount);

		paymentDTO.setOrderInfoId(orderInfoId);
		
		paymentDTO.setPaymentNumber(merchantUid);

		int paymentInserted = paymentServiceDAO.insertPayment(paymentDTO);
		if (paymentInserted <= 0) {
			throw new OrderException("결제정보 삽입 실패");
		}
		return true;
	} catch (Exception e) {

		throw e; // 런타임 예외는 트랜잭션 롤백 발생
	}
}
	

	
	
	
	
	
	
	
	@Transactional
	@Override
	public boolean placeOrder(OrderRequestDTO orderRequestDTO, PaymentDTO paymentDTO) {
		try {
			Long orderInfoId = orderServiceDAO.insertOrderInfo(orderRequestDTO);
			if (orderInfoId == null || orderInfoId <= 0) {
				throw new OrderException("주문 정보 생성 실패");
			}			
			
			int itemsInserted = orderServiceDAO.insertOrderItems(orderInfoId, orderRequestDTO.getItems());
			if (itemsInserted <= 0) {
				throw new OrderException("주문 항목 삽입 실패");
			}
			int personInserted = orderServiceDAO.insertOrderPerson(orderInfoId, orderRequestDTO.getPerson());
			if (personInserted <= 0) {
				throw new OrderException("주문자 정보 삽입 실패");
			}

			int totalAmount = 0;

			List<OrderItemDTO> orderList = orderRequestDTO.getItems();

			for (int i = 0; i < orderList.size(); i++) {
				totalAmount = +orderList.get(i).getQuantity();
			}

			paymentDTO.setAmount(totalAmount);

			paymentDTO.setOrderInfoId(orderInfoId);

			int paymentInserted = paymentServiceDAO.insertPayment(paymentDTO);
			if (paymentInserted <= 0) {
				throw new OrderException("결제정보 삽입 실패");
			}
			return true;
		} catch (Exception e) {

			throw e; // 런타임 예외는 트랜잭션 롤백 발생
		}
	}

	@Override
	public List<OrderPaymentRequestDTO> getPagedOrders(LocalDate startDate, LocalDateTime endDate, int offset, int limit,int user_code) {
		// DAO 호출
		return orderServiceDAO.selectOrdersByDateWithPaging(startDate, endDate, offset, limit,user_code);
	}

	@Override
	public Boolean checkOneOrderAmount(Map<String, Object> params,Integer amount) {
		String 	주문장에있는가격	=orderServiceDAO.checkOneOrderAmount(params);
		Integer pg사로부터통보받은실물결제가격=amount;		
		return 가굑조작이니함수(주문장에있는가격,pg사로부터통보받은실물결제가격);
	}

	// 1000.00
	// 1000
	public boolean 가굑조작이니함수(String 주문장에있는가격, Integer pg사로부터통보받은실물결제가격) {
		
		// null 방지 및 BigDecimal 변환
		BigDecimal 주문장에있는가격BigDecimal = new BigDecimal(주문장에있는가격) ;


		BigDecimal pg사로부터통보받은실물결제가격BigDecimal = new BigDecimal(pg사로부터통보받은실물결제가격.toString());

		// 값(value) 비교 → compareTo() == 0이면 값이 같음
		boolean isAmountEqual = 주문장에있는가격BigDecimal.compareTo(pg사로부터통보받은실물결제가격BigDecimal) == 0;
	

		return isAmountEqual;
	}

	@Override
	public Boolean duplicateOrderCheck(String merchantUid) {
		// TODO Auto-generated method stub
		return orderServiceDAO.duplicateOrderCheck(merchantUid);
	}

	

	

	
	
	
	
	
	
	
	
	
}