package com.spring.finall.admin.adminService;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.spring.finall.admin.adminRepository.ReserveinfoReposotory;
import com.spring.finall.admin.admindomain.ReserveinfoEntity;
import com.spring.finall.admin.admindto.ReponseReserveinfoDTO;

@Service("ReserveinfoService")
public class ReserveinfoService {

	@Autowired
	ReserveinfoReposotory reserveinfoReposotory;

	public ReponseReserveinfoDTO Showreserveinfo() {

		Pageable exchangePageable = PageRequest.of(0, 10);

		Page<ReserveinfoEntity> page = reserveinfoReposotory.findAll(exchangePageable);
//		List<UserEntity>   userList= page.getContent().get(0).getUserEntity();
//		for(UserEntity user: userList){
//			System.out.println("유저 아이디 "+user.getId());
//			System.out.println("유저 이름 "+user.getUser_name());
//			System.out.println("유저 전화번호 "+user.getUser_tell());
//		}		
		if (!page.isEmpty()) {
			page.getContent();

			ReponseReserveinfoDTO resdto = page.getContent().get(0).toResponseDto(page.getContent().get(0));

			return resdto;
		} else {
			return null;
		}

	}

	public List<ReponseReserveinfoDTO> resoveinfolist() {

		List<ReserveinfoEntity> resoveinfolist = reserveinfoReposotory.findAll();
		System.out.println("resoveinfolist 의 사이즈" + resoveinfolist.size());

		List<ReponseReserveinfoDTO> resdtolist = new ArrayList();

		for (ReserveinfoEntity reserveinfoentity : resoveinfolist) {
			resdtolist.add(reserveinfoentity.toResponseDto(reserveinfoentity));
		}

		for (int k = 0; k < resdtolist.size(); k++) {
			System.out.println("유저코드는???... " + resdtolist.get(k).getUser_code());

		}

		return resdtolist;

	}

	// Native Query
	public List<ReponseReserveinfoDTO> reserveinfobetweendate(String startDate, String endDate, Integer startpage,
			Integer endpage) {
		// @Query("select r from ReserveinfoEntity r join fetch r.userEntity")
		// 가 붙어있는데 강제로 한번 호출하자. fetch 가 붙어있어서
		List<ReserveinfoEntity> resoveinfolist = reserveinfoReposotory.findAll();

		// 한개의 버튼당 10개의 개시글을 보여 줄것임
		// 총 row/10 => 몫 : 개당 꽉찬 버튼 나머지: 10개 미만 게시글에 대응되는 버튼
		// 페이징 버튼 개수를 위해서 ... 아니 씨발 이러면 마이베티스랑 똩같은데???
		Integer contsrow = reserveinfoReposotory.findDate(startDate, endDate);

		int quotient = contsrow / 10;
		int rest = contsrow % 10;

		System.out.println(
				"최초 기간 검색시 받아온 로우수 contsrow는 ->>>>" + contsrow + " 그리고 quotient->>" + quotient + "rest-->> " + rest);

		int buttoncount;
		int startbutton = 0;
		int endbutton;
		int nextbtn = 0;
		

		// 새로운 독릭접인 값을 만들자.
		Long nextvalue = 0L;
		

		//
		if (quotient == 0) {
			nextbtn = 0;
			buttoncount = 0;
			endbutton = 1;
		} else {

			buttoncount = quotient + rest;

			if (quotient > 5) {
				endbutton = startbutton + 4;
				nextbtn = 50;

			} else {
				endbutton = startbutton + quotient + 1;
				nextbtn = 0;
			}

		}

		System.out.println("시작 버튼 ->>>>" + startbutton + " 그리고 종료버튼->>" + endbutton);

		List<ReserveinfoEntity> entitylist = reserveinfoReposotory.findDate(startDate, endDate, startpage, endpage);

		// 스파게티 코드지만 어쩔수 없다..!!!
		if (quotient > 5) {
			nextvalue = entitylist.get(entitylist.size() - 1).getReserveinfo_num() + 40;
		}

		System.out.println("nextvalue 가 널임?----->" + nextvalue);

		List<ReponseReserveinfoDTO> resdtolist = new ArrayList();
		System.out.println(
				"-----------------------------구분선 -------------------------------------------------------------------------");
		for (ReserveinfoEntity entity : entitylist) {
			entity.getUserEntity().getId();
			entity.getUserEntity().getPassword();
			entity.getUserEntity().getReserveinfoEntity();
			entity.getUserEntity().getUser_code();
			entity.getUserEntity().getUser_name();
			entity.getUserEntity().getUser_tell();
			entity.getUserEntity().getUser_where();

			// contsrow 는 엔티티 컬럼에서 제외 하였음으로 일반 변수로 던진다.
			resdtolist.add(entity.toResponseDto(entity, contsrow, buttoncount, startbutton, endbutton, startDate,
					endDate, nextbtn, nextvalue));
		}

		return resdtolist;

	}

	// Native Query
	public List<ReponseReserveinfoDTO> reserveinfopersonalpage(String startDate, String endDate, Integer startbutton,
			Integer endbutton, Integer endpage, Integer nextbtn, Long nextvalue, Integer startpage) {

		List<ReserveinfoEntity> resoveinfolist = reserveinfoReposotory.findAll();

		List<ReserveinfoEntity> entitylist = reserveinfoReposotory.findDate3(startDate, endDate, startpage, endpage);

		System.out.println("entitylist 가 널임?----->" + entitylist);

		List<ReponseReserveinfoDTO> resdtolist = new ArrayList();

		for (ReserveinfoEntity entity : entitylist) {
			entity.getUserEntity().getId();
			entity.getUserEntity().getPassword();
			entity.getUserEntity().getReserveinfoEntity();
			entity.getUserEntity().getUser_code();
			entity.getUserEntity().getUser_name();
			entity.getUserEntity().getUser_tell();
			entity.getUserEntity().getUser_where();

			// contsrow 는 엔티티 컬럼에서 제외 하였음으로 일반 변수로 던진다.
			resdtolist
					.add(entity.toResponseDto(entity, startbutton, endbutton, startDate, endDate, nextbtn, nextvalue));
		}

		return resdtolist;

	}// 개별 페이지 메서드 종료

	// Native Query
	public List<ReponseReserveinfoDTO> reserveinfonextpage(String startDate, String endDate, Integer buttoncount,
			Integer endbutton, Integer nextstartpage, Integer nextbtn, Integer endpage, Integer reserveinfo_num) {

		List<ReserveinfoEntity> resoveinfolist = reserveinfoReposotory.findAll();

		Integer contsrow = reserveinfoReposotory.findDate1(startDate, endDate, reserveinfo_num);

		int quotient = contsrow / 10;

		// 자바의 나눗셈은 정수론의 나눗셈 정리이 다 조심하자.
		int rest = contsrow % 10;

		System.out.println("reserveinfo_num->>>>" + reserveinfo_num + "총로우수->>" + contsrow + "quotient->>" + quotient
				+ "rest-->> " + rest);

		int startbutton = endbutton + 1;

		int backbtn = 0;
		Long nextvalue = 0L;
		int backvalue = 0;

		// 즉 rest == contsrow 인 경우 자바의 나눗셈은 정수론의 나눗셈정리 이다.
		if (quotient == 0) {
			nextbtn = 0;
			buttoncount = 0;
			endbutton = startbutton + 1;
		} else {

			buttoncount = quotient + rest;

			if (quotient > 5) {
				endbutton = startbutton + 4;
				nextbtn = nextbtn + 50;
			} else {

				if (rest == 0) {
					endbutton = startbutton + quotient;
				}

				endbutton = startbutton + quotient;
				nextbtn = 0;
			}

		}
		System.out.println("넥스트 페이지 서비스속 시작버튼 값->>" + startbutton + " 종료 버튼값 endbutton-->> " + endbutton);

		List<ReserveinfoEntity> entitylist = reserveinfoReposotory.findDate2(startDate, endDate, nextstartpage,
				endpage);

		// 스파게티 코드지만 어쩔수 없다..!!!
		if (quotient > 5) {
			nextvalue = entitylist.get(entitylist.size() - 1).getReserveinfo_num() + 40;
		}

		System.out.println("nextvalue 가 널임?----->" + nextvalue);

		List<ReponseReserveinfoDTO> resdtolist = new ArrayList();

		for (ReserveinfoEntity entity : entitylist) {
			entity.getUserEntity().getId();
			entity.getUserEntity().getPassword();
			entity.getUserEntity().getReserveinfoEntity();
			entity.getUserEntity().getUser_code();
			entity.getUserEntity().getUser_name();
			entity.getUserEntity().getUser_tell();
			entity.getUserEntity().getUser_where();

			// contsrow 는 엔티티 컬럼에서 제외 하였음으로 일반 변수로 던진다.
			resdtolist.add(entity.toResponseDto(entity, contsrow, buttoncount, startbutton, endbutton, startDate,
					endDate, nextbtn, nextvalue));
		}

		return resdtolist;
	}

	public List<ReponseReserveinfoDTO> detailbetweendate(String startDate, String endDate, String reservename,
			String payment) {
		
		if(payment.equals("pay")) {
			payment="payment";			
		}else {
			payment="paycancel";
		}
		
		System.out.println("paycancel->>"+payment);
		List<ReserveinfoEntity> entitylist=reserveinfoReposotory.findDetailinfo(startDate,  endDate, reservename,payment);

		List<ReponseReserveinfoDTO> resdtolist = new ArrayList();
		for (ReserveinfoEntity entity : entitylist) {			
			resdtolist.add(entity.toResponseDto(entity));
			System.out.println("유저코드 "+entity.getUserEntity().getUser_code());
			System.out.println("유저이름 "+entity.getUserEntity().getUser_name());
		}

		
		
		
		return resdtolist;

	}

}