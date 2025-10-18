package com.spring.finall.admin.admindomain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.spring.finall.admin.admindto.ReponseReserveinfoDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;


@Table(name="reserveinfo")

@Setter
@Getter
@Builder
@AllArgsConstructor

@RequiredArgsConstructor
@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class ReserveinfoEntity {

	//Id 없으면 무조건 오류남..!!
	@Id
	public Long reserveinfo_num;
	public Integer onedayclass_num;
	public String merchant_uid;
	public String openday;
	
	
	// FetchType.LAZY : 바로 조회 하는게 아닌 추후 사용할때 쓴다 씨발
	 @ManyToOne	(fetch = FetchType.LAZY)	
     @JoinColumn(name="user_code" ,insertable = false, updatable = false)	
	 public UserEntity userEntity;
	
	 public Integer user_code;
	
	 public String application_day;
	 public String reservestatus;
	
	 @Transient
	 Integer contsrow;	 
	 
	 @Transient
	 Integer buttoncount;
	 
	 @Transient
	 Integer startbutton;
	 
	 @Transient
	 Integer endbutton;
	 
	 @Transient
	 String startDate;	 
	 
	 @Transient
	 String endDate;
	 
	 @Transient
	 Integer nextbtn;
	 
	 @Transient
	 Long nextvalue;
	 
	 
	 public ReponseReserveinfoDTO toResponseDto(ReserveinfoEntity reserveinfoEntity ) {
//			System.out.println("reserveinfoEntity.getUserEntity()??프록시>?? "+reserveinfoEntity.getUserEntity());
//			reserveinfoEntity.getUserEntity().getId();
//			reserveinfoEntity.getUserEntity().getPassword();
//			reserveinfoEntity.getUserEntity().getReserveinfoEntity();
//			reserveinfoEntity.getUserEntity().getUser_code();
//			reserveinfoEntity.getUserEntity().getUser_name();
//			reserveinfoEntity.getUserEntity().getUser_tell();
//			reserveinfoEntity.getUserEntity().getUser_where();
			return	ReponseReserveinfoDTO.builder()
			.reserveinfo_num(reserveinfoEntity.reserveinfo_num)
			.onedayclass_num(reserveinfoEntity.getOnedayclass_num())
			.merchant_uid(reserveinfoEntity.getMerchant_uid())
			.openday(reserveinfoEntity.getOpenday())
			.user_code(reserveinfoEntity.getUser_code())
			.application_day(reserveinfoEntity.getApplication_day())
			.reservestatus(reserveinfoEntity.getReservestatus())
			.contsrow(contsrow)
			.userEntity(reserveinfoEntity.getUserEntity())
			.
			build();
	 
	 }
	 
	 
	 
	 //개별페이지를 위한 toResponseDTO 오버로딩
		public ReponseReserveinfoDTO toResponseDto(ReserveinfoEntity reserveinfoEntity  , Integer startbutton, Integer endbutton, String startDate, String endDate,Integer nextbtn,Long nextvalue) {

			return	ReponseReserveinfoDTO.builder()
			.reserveinfo_num(reserveinfoEntity.reserveinfo_num)
			.onedayclass_num(reserveinfoEntity.getOnedayclass_num())
			.merchant_uid(reserveinfoEntity.getMerchant_uid())
			.openday(reserveinfoEntity.getOpenday())
			.user_code(reserveinfoEntity.getUser_code())
			.application_day(reserveinfoEntity.getApplication_day())
			.reservestatus(reserveinfoEntity.getReservestatus())			
			.startbutton(startbutton)
			.endbutton(endbutton)
			.startDate(startDate)
			.endDate(endDate)
			.nextbtn(nextbtn)
			.nextvalue(nextvalue)
			.userEntity(reserveinfoEntity.getUserEntity())
			.
			build();
			
			 
			
		}
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 //페이징을 위한 toResponseDTO 오버로딩
	public ReponseReserveinfoDTO toResponseDto(ReserveinfoEntity reserveinfoEntity ,Integer contsrow , Integer buttoncount, Integer startbutton, Integer endbutton,String startDate, String endDate,Integer nextbtn,Long nextvalue) {

		return	ReponseReserveinfoDTO.builder()
		.reserveinfo_num(reserveinfoEntity.reserveinfo_num)
		.onedayclass_num(reserveinfoEntity.getOnedayclass_num())
		.merchant_uid(reserveinfoEntity.getMerchant_uid())
		.openday(reserveinfoEntity.getOpenday())
		.user_code(reserveinfoEntity.getUser_code())
		.application_day(reserveinfoEntity.getApplication_day())
		.reservestatus(reserveinfoEntity.getReservestatus())
		.contsrow(contsrow)
		.buttoncount(buttoncount)
		.startbutton(startbutton)
		.endbutton(endbutton)
		.startDate(startDate)
		.endDate(endDate)
		.nextbtn(nextbtn)
		.nextvalue(nextvalue)
		.userEntity(reserveinfoEntity.getUserEntity())
		.
		build();
		
		 
		
	}
	
	
	

}
