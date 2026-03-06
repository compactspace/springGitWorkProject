package com.spring.finall.reqDto.manageonedayclass;

public class AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO {
	private String selectOpenMinDate;

	private String selectOpenMaxDate;

	private Long teacher_id;

	public AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO(String selectOpenMinDate, String selectOpenMaxDate,
			Long teacher_id) {

		this.selectOpenMinDate = selectOpenMinDate;
		this.selectOpenMaxDate = selectOpenMaxDate;
		this.teacher_id = teacher_id;

	}

	public String getSelectOpenMinDate() {
		return selectOpenMinDate;
	}

	public void setSelectOpenMinDate(String selectOpenMinDate) {
		this.selectOpenMinDate = selectOpenMinDate;
	}

	public String getSelectOpenMaxDate() {
		return selectOpenMaxDate;
	}

	public void setSelectOpenMaxDate(String selectOpenMaxDate) {
		this.selectOpenMaxDate = selectOpenMaxDate;
	}

	public Long getTeacher_id() {
		return teacher_id;
	}

	public void setTeacher_id(Long teacher_id) {
		this.teacher_id = teacher_id;
	}

}
