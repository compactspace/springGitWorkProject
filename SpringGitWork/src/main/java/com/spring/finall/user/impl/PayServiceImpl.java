package com.spring.finall.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.CustomException.PayRunTimeTranException;
import com.spring.finall.user.PayService;
import com.spring.finall.user.PayVO;
import com.spring.finall.user.UserVO;

@Service("payservice")
public class PayServiceImpl implements PayService {

	@Autowired
	private PayDAOMybatis paydao;

	@Override
	public void insertPay(PayVO pvo, Integer cart_id)  throws PayRunTimeTranException{

		paydao.insertPay(pvo, cart_id);
	}

	// 고객 전체 결제 현황
	@Override
	public List<PayVO> showpaylist(PayVO pvo) {

		return paydao.showpaylist(pvo);
	}

//고객 단건 상세 조회및 취소
	@Override
	public List<PayVO> mypaydetailinfo(UserVO uvo, PayVO pvo) {

		return paydao.mypaydetailinfo(uvo, pvo);
	}

	// 고객 취소시 우선 취소대상 카트번호들을 뽑아옴
	@Override
	public Integer cancellistcartid(PayVO pvo) {
		return paydao.cancellistcartid(pvo);

	};

}
