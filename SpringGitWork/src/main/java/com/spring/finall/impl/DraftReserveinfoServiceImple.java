package com.spring.finall.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finall.reqDto.InsertDraftReserveinfoRequestDTO.InsertDraftReserveinfoDTO;
import com.spring.finall.resDto.HasRecentUpdateOnedayClassInfoResDTO.HasRecentUpdateOnedayClassInfoResDTO;
import com.spring.finall.service.DraftReserveinfoService;
import com.spring.finall.user.DraftReserveinfoVO;

@Service
public class DraftReserveinfoServiceImple implements DraftReserveinfoService {

	@Autowired
	private DraftReserveinfoServiceDAO draftReserveinfoServiceDAO;

	@Override
	public DraftReserveinfoVO findDraftReserveInfoByOnedayAndSelectedDate(int onedayclassNum, String selectedDate,
			int userCode) {
		// TODO Auto-generated method stub
		return draftReserveinfoServiceDAO.findDraftReserveInfoByOnedayAndSelectedDate(onedayclassNum, selectedDate,
				userCode);
	}

	@Override
	public Long insertDraftReserveInfo(InsertDraftReserveinfoDTO insertDraftReserveInfoDTO) {

		Long generatedPk = draftReserveinfoServiceDAO.insertDraftReserveInfo(insertDraftReserveInfoDTO);

		return generatedPk;
	}

	public Map<String,Object> currentDraftInfoEqulLastedSnapshot(Long OnedayClassNum, DraftReserveinfoVO draftReserveinfoVO) {

		HasRecentUpdateOnedayClassInfoResDTO recentUpdateOnedayClassInfoResDTO = draftReserveinfoServiceDAO
				.currentDraftInfoEqulLastedSnapshot(OnedayClassNum);

		Integer draftPrice = draftReserveinfoVO.getOnedayclassPrice();

		Integer currentUpdatePrice = recentUpdateOnedayClassInfoResDTO.getOnedayclassPrice();

		boolean isEqual = draftPrice.equals(currentUpdatePrice);
		Map<String,Object> resultMap=new HashMap<>();
	
		resultMap.put("isEqual", true);
		if(!isEqual) {
			resultMap.put("recentUpdateOnedayClassInfoResDTO", recentUpdateOnedayClassInfoResDTO);
			resultMap.put("isEqual", isEqual);
			
			
		}

		return resultMap;

	}

	@Override
	public int confirmUpdatedOnedayPrice(int userCod, String selectedDate, String merchant_uid,Integer priceUpdated) {
		draftReserveinfoServiceDAO.confirmUpdatedOnedayPrice(userCod, selectedDate, merchant_uid, priceUpdated);
		return 0;
	}

	@Override
	public int rejectUpdatedOnedayPrice(int userCod, String selectedDate, String merchant_uid) {
		draftReserveinfoServiceDAO.rejectUpdatedOnedayPrice(userCod, selectedDate, merchant_uid);
		return 0;
	}

}
