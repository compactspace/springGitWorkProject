package com.spring.finall.user;

import java.time.LocalDate;
import java.util.List;

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
	    public List<OrderPaymentRequestDTO> getPagedOrders(LocalDate startDate, LocalDate endDate, int offset, int limit) {
	        // DAO 호출
	        return orderServiceDAO.selectOrdersByDateWithPaging(startDate, endDate, offset, limit);
	    }

}