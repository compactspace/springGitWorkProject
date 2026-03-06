package com.spring.finall.service;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.spring.finall.reqDto.InsertDraftReserveinfoRequestDTO.InsertDraftReserveinfoDTO;
import com.spring.finall.user.DraftReserveinfoVO;

public interface DraftReserveinfoService {

	DraftReserveinfoVO findDraftReserveInfoByOnedayAndSelectedDate(int onedayclassNum, String selectedDate,
			int userCode);

	Long insertDraftReserveInfo(InsertDraftReserveinfoDTO insertDraftReserveInfoDTO);

	Map<String,Object> currentDraftInfoEqulLastedSnapshot(Long OnedayClassNum, DraftReserveinfoVO draftReserveinfoVO);

int	confirmUpdatedOnedayPrice(int 	userCod,String selectedDate,String merchant_uid,Integer priceUpdated);
	
int	rejectUpdatedOnedayPrice(int 	userCod,String selectedDate,String merchant_uid);
	
	

}