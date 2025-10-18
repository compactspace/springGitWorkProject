package com.spring.finall.admin.admindto;


import com.spring.finall.admin.admindomain.ReserveinfoEntity;

import lombok.Builder;
import lombok.Getter;


@Getter
@Builder
public class RequestReserveinfoDTO {

	
	//이유는 모르겟는데.. DTO 에서 int 로 하면 다음 오류가 나서 눈치밥으로 Integer로 바꾸니 오류 사라짐 하 씨발
	//reserveinfo_num': rejected value [null]; codes [typeMismatch.requestReserveinfoDTO.reserveinfo_num,typeMismatch.reserveinfo_num,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [requestReserveinfoDTO.reserveinfo_num,reserveinfo_num]; arguments []; default message [reserveinfo_num]]; default message [Failed to convert value of type 'null' to required type 'int'; nested exception is org.springframework.core.convert.ConversionFailedException: Failed to convert from type [null] to type [int] for value 'null'; nested exception is java.lang.IllegalArgumentException: A null value cannot be assigned to a primitive type]
	//Field error in object 'requestReserveinfoDTO' on field 'onedayclass_num'
	private Integer reserveinfo_num;
	private Integer onedayclass_num;
	private String merchant_uid;
	private String openday;
	private Integer user_code;
	private String application_day;
	private String reservestatus;

	public ReserveinfoEntity toEntity() {		
		
		
		return ReserveinfoEntity.builder().reserveinfo_num(14L)
				
				.user_code(107).build();
		
//		return new ReserveinfoEntity(this);
	}

}
