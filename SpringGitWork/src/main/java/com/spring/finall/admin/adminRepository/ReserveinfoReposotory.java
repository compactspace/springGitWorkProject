package com.spring.finall.admin.adminRepository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.spring.finall.admin.admindomain.ReserveinfoEntity;


//우선 프록시=대리인 으로 아무튼 객체 만들어지고
//JpaRepository<ReserveinfoEntity,Long> extends 의 PagingAndSortingRepository 의 메서드들을 쓰는거임
public interface ReserveinfoReposotory extends JpaRepository<ReserveinfoEntity,Long> {	
	
	// extends JpaRepository<ReserveinfoEntity,Long> 의 extends 의 PagingAndSortingRepository 의 메서드임!
	Page<ReserveinfoEntity> findAll(Pageable pageable);
	
	@Query("select r from ReserveinfoEntity r join fetch r.userEntity")
	List<ReserveinfoEntity> findAll();
	
	
	@Query(value="select count(*) from reserveinfo r where DATE_FORMAT(r.application_day, '%Y-%m') BETWEEN :startDate and :endDate ", nativeQuery = true)
	Integer findDate(@Param("startDate") String startDate, @Param("endDate") String endDate );
	
	
	
	@Query(value="select * from reserveinfo r where DATE_FORMAT(r.application_day, '%Y-%m') BETWEEN :startDate and :endDate  limit :startpage , :endpage ", nativeQuery = true)
	List<ReserveinfoEntity> findDate(@Param("startDate") String startDate, @Param("endDate") String endDate , @Param("startpage") Integer startpage, @Param("endpage") Integer endpage);
	
	
	
	//다음페이지 버튼을 위한 총 로우 개수 구하기
	//https://m.blog.naver.com/zzang9ha/222011626272
	//from 절의 서브 쿼리는 반드시  (select 문~) as 별칭
	// 이렇게 줘야한다.
	@Query(value="SELECT COUNT(*) from (SELECT * from reserveinfo WHERE  DATE_FORMAT(application_day, '%Y-%m') BETWEEN :startDate and :endDate   and reserveinfo_num> :reserveinfo_num ) AS si ", nativeQuery = true)
	Integer findDate1(@Param("startDate") String startDate, @Param("endDate") String endDate , @Param("reserveinfo_num") Integer reserveinfo_num);
	
	
	@Query(value="select * from reserveinfo r where DATE_FORMAT(r.application_day, '%Y-%m') BETWEEN :startDate and :endDate  limit :nextstartpage , :endpage ", nativeQuery = true)
	List<ReserveinfoEntity> findDate2(@Param("startDate") String startDate, @Param("endDate") String endDate , @Param("nextstartpage") Integer  nextstartpage , @Param("endpage") Integer endpage);
	
	//개별 페이지 오버로딩
	@Query(value="select * from reserveinfo r where DATE_FORMAT(r.application_day, '%Y-%m') BETWEEN :startDate and :endDate  limit :startpage, :endpage ", nativeQuery = true)
	List<ReserveinfoEntity> findDate3(@Param("startDate") String startDate, @Param("endDate") String endDate , @Param("startpage") Integer  startpage , @Param("endpage") Integer endpage);
	
	
	//디테일 조회 시작
	
//	-- 동명인이 있다면 조건절로 서브쿼리는 에러가 난다..!!
// 따라서 In 연산자라는 다중행 반환 조건절 사용
//	SELECT user_code FROM ( SELECT * FROM user  WHERE user_name='김개똥') AS u;
//
//	SELECT * FROM (SELECT * FROM reserveinfo) AS re WHERE re.user_code IN (SELECT user_code FROM ( SELECT * FROM user  WHERE user_name='김개똥') AS u) AND reservestatus='payment';
	
	@Query(value="SELECT * FROM (SELECT * FROM reserveinfo) AS re WHERE re.user_code IN (SELECT user_code FROM ( SELECT * FROM user  WHERE user_name= :reservename) AS u) AND reservestatus= :payment AND DATE_FORMAT(application_day, '%Y-%m') BETWEEN :startDate AND :endDate", nativeQuery = true)
	List<ReserveinfoEntity> findDetailinfo(@Param("startDate") String startDate, @Param("endDate") String endDate , @Param("reservename") String  reservename , @Param("payment") String payment);
	
	
}
