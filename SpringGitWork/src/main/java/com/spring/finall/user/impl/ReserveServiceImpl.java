package com.spring.finall.user.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.exception.reserveException.ReserveException;
import com.spring.finall.service.ReserveService;
import com.spring.finall.user.ReserveInfoVO;

@Service("ReserveInfoVOService")
public class ReserveServiceImpl implements ReserveService {

	@Autowired
	public ReserveInfoDAOMybatis rdao;


	@Override
	public boolean checkreserveinfo(ReserveInfoVO vo) {

		return rdao.inscheckreserveinfo(vo);

	};

	@Override
	public List<Object> myreserveinfo(HttpServletRequest req) {

		return rdao.myreserveinfo(req);
	}
	
	@Override
	public void paystatusupdate(HttpServletRequest req){
		
		rdao.paystatusupdate(req);
		
	}

	
	@Transactional
	@Override
	public boolean makeReservation(Map<String, Object> param) {		

			try {
				int restCnt=rdao.checkRestCnt(param);				
				
				if (restCnt<1) {
					throw new ReserveException("해당 일의 자리수 마감됨");
				}
				
				int generatedPaymentId =rdao.insertPayment(param);
				if(generatedPaymentId==0) {
					throw new ReserveException("결제 정보 삽입실패");
				}				
				
				int affectedRow=0;
				 affectedRow=rdao.decreaseRestIfAvailable(param);
				if (affectedRow==0) {
					throw new ReserveException("자리수 마감 업데이트 실패");
				}
				
				int generatedPaymentIdReserveInfoId=rdao.insertreserveinfo(param);
			 	if (affectedRow==0) {
					throw new ReserveException("예약정보 삽입 실패");
				}
			 	param.put("reserveinfo_num", generatedPaymentIdReserveInfoId);
				affectedRow=rdao.insertApplicantInfo(param);
			 	if (affectedRow==0) {
					throw new ReserveException("예약자 인적사항 정보 삽입 실패");
				}			 	
			 	

				return true;
			} catch (Exception e) {
				
				

				throw e; // 런타임 예외는 트랜잭션 롤백 발생
			}		
		
		

	}

	@Override
	public Map<String,Object> getReserveStatus(int user_code,int offset) {
		Map<String,Object>  recentlyReserveStatusObj=	rdao.getReserveStatus(user_code, offset);
		return recentlyReserveStatusObj;
	};
	
	

}
