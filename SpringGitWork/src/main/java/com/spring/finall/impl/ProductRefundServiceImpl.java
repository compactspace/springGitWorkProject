package com.spring.finall.impl;

import java.time.LocalDate;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.exception.requestRefund.RequestRefundException;
import com.spring.finall.reqDto.refundRequest.ProductRefundDTO;
import com.spring.finall.service.ProductRefundService;
import com.spring.finall.user.impl.OrderInfoServiceDAOMybatis;

@Service
public class ProductRefundServiceImpl implements ProductRefundService {

	@Autowired
	private ProductRefundServiceDAO productRefundServiceDAO;

	@Autowired
	private OrderInfoServiceDAOMybatis orderInfoServiceDAOMybatis;

	@Override
	@Transactional
	public boolean reqeustRefund(ProductRefundDTO refundDTO) {
		boolean reqeustRefundSuccess = false;
		try {
			boolean alreadyRefunded = productRefundServiceDAO.existsByPaymentId(refundDTO);
			if (alreadyRefunded) {

				String message = "해당 결제건" + String.valueOf(refundDTO.getPaymentId()) + " 에 대하여 이미 환불 신청이 되어있습니다.";

				throw new RequestRefundException("해당 결제건 " + refundDTO.getPaymentId() + " 에 이미 환불 신청이 되어있습니다.", 40001);
			}

			Long orderInfoId = refundDTO.getOrderInfoId();
			reqeustRefundSuccess = productRefundServiceDAO.reqeustRefund(refundDTO);
			if (!reqeustRefundSuccess) {
				throw new RequestRefundException("주문번호  " + orderInfoId + "에 대한 환불 신청테이블에 데이터 삽입하다 실패", 40001);

			}

			//관리자가 볼 수 있도록 오더인포의 스테터스컬럼: 환불신청으로 없데이트
			reqeustRefundSuccess = orderInfoServiceDAOMybatis.updateOrderStatusToRefundRequested(orderInfoId);
			if (!reqeustRefundSuccess) {
				throw new RequestRefundException("주문번호  " + orderInfoId + "에 대한 오더인포테이블의 상태 업데이트하다 실패", 40001);
			}

			

		} catch (DataIntegrityViolationException e) {
			// UNIQUE 제약 위반 등 DB 예외 처리
			throw new RequestRefundException("이미 환불 요청이 접수된 결제건입니다: " + refundDTO.getPaymentId(), 40001);
		} catch (Exception e) {
			// 기타 예외
			throw new RequestRefundException("환불 신청 중 에러가 발생했습니다: " + refundDTO.getPaymentId(), 50000);
		}
		return reqeustRefundSuccess;
	}

	@Override
	public Map<String, Object> getProductRefundCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek) {
		// TODO Auto-generated method stub
		return productRefundServiceDAO.getProductRefundCountByTodayAndWeek(startOfWeek, endOfWeek);
	}

}
