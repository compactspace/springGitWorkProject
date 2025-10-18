package com.spring.finall.user.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.security.UserDetailsVO2;
import com.spring.finall.user.UserVO;

@Repository
public class MemberDAOMybatis {
	boolean isDuplicated;
	boolean errorcheck;
	boolean checkid;

	@Autowired
	private SqlSessionTemplate mybatis;

	public boolean insertMembership(UserVO vo) {

		Integer checkrow = (Integer) mybatis.selectOne("UserVO.isDuplicated", vo);

		
		vo.setUser_where("finalluser");
		if (checkrow == 0) {
			mybatis.insert("UserVO.insertmember", vo);
			isDuplicated=false;
			
			return isDuplicated;
		}else {
			throw new RuntimeException("동일한 아이디 가입임!!");
//			isDuplicated=true;
//			return isDuplicated;
		}
	}

	
	
	public Integer selectusercode(UserVO vo) {		
	
		
		return  mybatis.selectOne("UserVO.selectusercode" ,vo);		
		
	
	};
	
	public  Integer selectmainhomeuser_code(UserVO vo) {
		
		return  mybatis.selectOne("UserVO.selectmainhomeuser_code",vo);
	}
	
	
	
	public boolean checkidMembership(UserVO vo) {

		
		
	
		
		Object check = mybatis.selectOne("UserVO.checkidMembership", vo);
		System.out.println("아이확인값이 널?:"+check);
		
		if (check == null) {
			System.out.println("네이버 정보로 가입한적없음");
			checkid = true;
			return checkid;
		} else {
			System.out.println("네이버 정보로 가입한적있음");
			checkid = false;
			return checkid;
		}

	}
	
	//로그인시도전 보조 아이디 체크용

	
	public boolean checkidMembershiptwo(UserVO vo) {		
		Object check = mybatis.selectOne("UserVO.checkidMembershiptwo", vo);		
		if (check != null) {		
			checkid = true;
			return checkid;
		} else {

			checkid = false;
			return checkid;
		}

	}
	
	
	

	public String loginpasswordMembership(UserVO vo) {
	    UserVO user = mybatis.selectOne("UserVO.loginpasswordMembership", vo);
	    
	    String hashedPwd=user.getPassword();
	    return hashedPwd;
	}


	public int changepasswordcomplete(UserVO vo){
		
		System.out.println("vo.getAfterpassword()"+vo.getAfterpassword());
		
		UserVO uvo=mybatis.selectOne("UserVO.loginpasswordMembership", vo);
		String id=vo.getId();
		String beforepassword=uvo.getPassword();
		String afterpassword=vo.getAfterpassword();
		HashMap<String,String> map  =new HashMap();
		map.put("id", id);
		map.put("beforepassword", beforepassword);
		map.put("afterpassword", afterpassword);
		System.out.println("마이바티스 삽입직전 id"+id+" 이전비번 "+beforepassword+" 새롭게 바꿀비번 "+afterpassword);
		
		//업데이트문은 에러 자체가 아니라 업데이트 한개 없으면 리턴 0 이고
		// 성공 업데이트라면?? 
		return mybatis.update("UserVO.changePasswordComplete",map);
		
	} 

	


	public boolean insertPhone(UserVO vo) {

		mybatis.insert("UserVO.insertPhone", vo);

		return errorcheck;

	}
	
	
	//핸드폰가입자 회원가입 시도시 이미 기가입자인지 체크하는 메소드

	public boolean  checkPhoneMembership(UserVO vo) {

		System.out.println("emptyset 은 어떤식으로 받아오는지 보자 템플레이트가 알아서 null로 변환해준다.");
		Object check = mybatis.selectOne("UserVO.checkPhoneMembership", vo);
		if (check == null) {
			System.out.println("신규가입자임.");
			checkid = true;
			return checkid;
		} else {
			System.out.println("기가입자임");
			checkid = false;
			return checkid;
		}

	}
	
	public UserVO mypersonalinfo(UserVO vo){		
			
	
		
		try {
			UserVO executerow = mybatis.selectOne("UserVO.mypersonalinfo", vo);
		
			
			return executerow;
			
		}catch(Exception e) {
			System.out.println("에러 출력"+e);
			
			return null;
			
		}
		
		
	}
	
	
	
	
	
	

	
	
	
	
}
