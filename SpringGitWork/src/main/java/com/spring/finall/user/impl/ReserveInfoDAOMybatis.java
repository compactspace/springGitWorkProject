package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.ReserveInfoVO;

@Repository
public class ReserveInfoDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 예약시 혹시몰라 자리 확인
	public int checkRestCnt(Map<String, Object> param) {

		return mybatis.selectOne("ReserveMapper.checkRestCnt", param); // MyBatis 매퍼 호출
	}

	// 예약 시 rest 자리 1 감소 (rest > 0 조건 포함)
	public int decreaseRestIfAvailable(Map<String, Object> param) {

		int affectedRow = mybatis.update("ReserveMapper.decreaseRestIfAvailable", param);
		return affectedRow;
	}

	public int insertPayment(Map<String, Object> param) {
		int result = mybatis.insert("ReserveMapper.insertPayment", param);

		// insert 성공 시 param 맵에 "reserve_payment_id" 키에 생성된 PK 값이 들어있음
		if (result > 0) {
			Number generatedIdNum = (Number) param.get("reserve_payment_id");
			if (generatedIdNum != null) {
				return generatedIdNum.intValue(); // int로 반환
			}
		}
		return 0; // 실패 시 0 반환
	}

	// 예약 취소 또는 결제 오류 시 rest 자리 1 증가
	public int increaseRestOnCancel(Map<String, Object> param) {
		int affectedRow = mybatis.update("ReserveMapper.increaseRestOnCancel", param);
		return affectedRow;
	}

	public int insertreserveinfo(Map<String, Object> param) {
		int result = mybatis.insert("ReserveMapper.insertreserveinfo", param);

		if (result > 0) {
			Number generatedIdNum = (Number) param.get("reserveinfo_num");
			if (generatedIdNum != null) {
				return generatedIdNum.intValue();
			}
		}
		return 0; // 실패 또는 키값 없으면 0 반환
	}

	public int insertApplicantInfo(Map<String, Object> param) {

		int affectedRow = mybatis.insert("ReserveMapper.insertApplicantInfo", param);

		return affectedRow;
	};

	public boolean inscheckreserveinfo(ReserveInfoVO vo) {

		Object result = mybatis.selectOne("ReserveMapper.checkreserinfo", vo);

		Integer executerow = (Integer) result;

		if (executerow == 0) {

			return true;

		} else {

			return false;

		}

	}

	// 마이베티스 조인문 사용법을 몰라서
	// ReserveInfoVO-mapping.xml 에서 innerjoin을 한뒤
	// resultType을 java.util.HashMap으로 설정함(Map도 결과는동일)
	// 그러면 mybatis.selectList 가 각 인덱스자리에 HashMap형태를 넣어서 포장해온다.
	public List<Object> myreserveinfo(HttpServletRequest req) {

		Map<String, Object> map = new HashMap<>();
		map.put("user_code", req.getParameter("user_code"));
		List<Object> result = mybatis.selectList("ReserveMapper.myreserveinfo", map);

//	   System.out.println("리졀트"+result);
//	   System.out.println("리졀트 투스트링"+result.toString());	
		return result;

	}

	public void paystatusupdate(HttpServletRequest req) {
		String reserveinfo_num = req.getParameter("reserveinfo_num");
		System.out.println("예약 번호는" + reserveinfo_num);
		Map<String, Object> map = new HashMap<>();
		map.put("reserveinfo_num", reserveinfo_num);
		mybatis.update("ReserveMapper.paystatusupdate", map);

	}

	public Map<String, Object> getReserveStatus(int user_code, int offset) {
		int pageSize = 10;
		int queryLimit = pageSize + 1;

		Map<String, Object> map = new HashMap<>();
		map.put("user_code", user_code);
		map.put("offset", offset);
		map.put("limit", queryLimit); // 11개 요청

		List<Map<String, Object>> list = mybatis.selectList("ReserveMapper.selectRecentReserveInfo", map);

		// hasNext 여부 판단
		boolean hasNext = list.size() > pageSize;

		// 실제로는 10개만 리턴
		List<Map<String, Object>> resultList = list.stream().limit(pageSize).collect(Collectors.toList());

		// 결과 구성
		Map<String, Object> result = new HashMap<>();
		result.put("data", resultList);
		result.put("hasNext", hasNext);

		return result;

	}

	public String getNowOnedayclassStatus(Map<String, Object> bodyData) {
		// Map에 파라미터 담기
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("openday", (String) bodyData.get("selectedDate"));
		paramMap.put("onedayclass_num", (String) bodyData.get("onedayclass_num"));

		// MyBatis 조회
		Map<String, Object> resultMap = mybatis.selectOne("ManageOneDayClassMapper.getNowOnedayclassStatus", paramMap);

		// 결과 반환 (없으면 null)
		if (resultMap != null && resultMap.get("manageStatus") != null) {
			return resultMap.get("manageStatus").toString();
		} else {
			return null; // 혹은 기본값 "OPEN" 가능
		}
	}

	public boolean dupulicateCheckForReservePayment(String merchantUid) {
	    Map<String, Object> resultMap = mybatis.selectOne(
	        "ReservePaymentMapper.dupulicateCheckForReservePayment", merchantUid
	    );
	    return resultMap != null;
	}

	public Integer checkClientPriceEqualsToRecentUpdatedPrice(String merchantUid) {
	    return mybatis.selectOne(
	        "ReservePaymentMapper.checkClientPriceEqualsToRecentUpdatedPrice", merchantUid
	    );
	}

	public boolean updateDraftReserveStatusTo(String merchantUid) {
	    int affectedRow = mybatis.update(
	        "ReservePaymentMapper.updateDraftReserveStatusTo", merchantUid
	    );
	    return affectedRow > 0;
	}

}
