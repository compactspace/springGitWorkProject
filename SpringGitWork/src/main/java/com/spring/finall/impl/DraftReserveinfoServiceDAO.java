package com.spring.finall.impl;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.reqDto.InsertDraftReserveinfoRequestDTO.InsertDraftReserveinfoDTO;
import com.spring.finall.resDto.HasRecentUpdateOnedayClassInfoResDTO.HasRecentUpdateOnedayClassInfoResDTO;
import com.spring.finall.user.DraftReserveinfoVO;

@Repository
public class DraftReserveinfoServiceDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public DraftReserveinfoVO findDraftReserveInfoByOnedayAndSelectedDate(int onedayclassNum, String selectedDate,
			int userCode) {

		Map<String, Object> paramMap = new HashMap();
		paramMap.put("onedayclassNum", onedayclassNum);
		paramMap.put("selectedDate", selectedDate);
		paramMap.put("userCode", userCode);
		DraftReserveinfoVO findDraftReserveInfo = mybatis
				.selectOne("DraftReserveMapper.findDraftReserveInfoByOnedayAndSelectedDate", paramMap);

		return findDraftReserveInfo;
	}

	public Long insertDraftReserveInfo(InsertDraftReserveinfoDTO insertDraftReserveInfoDTO) {
		// insert 실행
		mybatis.insert("DraftReserveMapper.insertDraftReserveInfo", insertDraftReserveInfoDTO);

		// DTO에 세팅된 생성키 반환
		Long generatedPk = insertDraftReserveInfoDTO.getDraftReserveinfoNum();
		return generatedPk;
	}

	public HasRecentUpdateOnedayClassInfoResDTO currentDraftInfoEqulLastedSnapshot(Long onedayclassNum,int userCode) {
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("onedayclassNum", onedayclassNum);
		paramMap.put("userCode", userCode);
		
		HasRecentUpdateOnedayClassInfoResDTO recentUpdateOnedayClassInfoResDTO = mybatis
				.selectOne("DraftReserveMapper.currentDraftInfoEqulLastedSnapshot", paramMap);

		return recentUpdateOnedayClassInfoResDTO;
	}

	public int confirmUpdatedOnedayPrice(int userCode, String selectedDate, String merchant_uid, Integer priceUpdated) {

		Map<String, Object> param = new HashMap<>();
		param.put("userCode", userCode);
		param.put("selectedDate", selectedDate);
		param.put("merchant_uid", merchant_uid);
		param.put("priceUpdated", priceUpdated);

		return mybatis.update("DraftReserveMapper.confirmUpdatedOnedayPrice", param);
	}

	public int rejectUpdatedOnedayPrice(int userCode, String selectedDate, String merchant_uid) {

		Map<String, Object> param = new HashMap<>();
		param.put("userCode", userCode);
		param.put("selectedDate", selectedDate);
		param.put("merchant_uid", merchant_uid);

		return mybatis.update("DraftReserveMapper.rejectUpdatedOnedayPrice", param);
	}

}
