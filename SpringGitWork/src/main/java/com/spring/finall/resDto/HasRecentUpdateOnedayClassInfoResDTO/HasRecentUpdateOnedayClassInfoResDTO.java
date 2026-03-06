package com.spring.finall.resDto.HasRecentUpdateOnedayClassInfoResDTO;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class HasRecentUpdateOnedayClassInfoResDTO {
	private Long historyId;
	private Long onedayclassNum;

	private Long draftReserveinfoNum;
	private String merchantUid;
	private String userCode;
	private LocalDate selectedDate;

	public Long getHistoryId() {
		return historyId;
	}

	public void setHistoryId(Long historyId) {
		this.historyId = historyId;
	}

	public Long getOnedayclassNum() {
		return onedayclassNum;
	}

	public void setOnedayclassNum(Long onedayclassNum) {
		this.onedayclassNum = onedayclassNum;
	}

	public Long getDraftReserveinfoNum() {
		return draftReserveinfoNum;
	}

	public void setDraftReserveinfoNum(Long draftReserveinfoNum) {
		this.draftReserveinfoNum = draftReserveinfoNum;
	}

	public String getMerchantUid() {
		return merchantUid;
	}

	public void setMerchantUid(String merchantUid) {
		this.merchantUid = merchantUid;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public LocalDate getSelectedDate() {
		return selectedDate;
	}

	public void setSelectedDate(LocalDate selectedDate) {
		this.selectedDate = selectedDate;
	}

	public Integer getOnedayclassPrice() {
		return onedayclassPrice;
	}

	public void setOnedayclassPrice(Integer onedayclassPrice) {
		this.onedayclassPrice = onedayclassPrice;
	}

	private Integer onedayclassPrice;

}
