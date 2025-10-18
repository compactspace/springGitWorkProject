package com.spring.finall.user.impl;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.user.ReserveVO;
import com.spring.finall.user.UserVO;

@Repository
public class ReserveDAOMybatis {
	ArrayList<String> checklist = new ArrayList<String>();

	@Autowired
	private SqlSessionTemplate mybatis;

	
	//달력 클릭후 예약 하면 예약되는 메소드
	public boolean insertreserve(ReserveVO vo, String checks) {
		
		List<ReserveVO> revo = checkinsertreserve(vo);
		if (checkinsertreserve(vo).size() == 0) {				
			mybatis.insert("ReservoVO.insertreserve", vo);
			return true;
				
		} else {
			/* checklist.clear(); */				
			return false;

		}

	}
	//이미 같은날 같은 이름 예약자가 있는지 확인
	public List<ReserveVO> checkinsertreserve(ReserveVO vo) {
		List<ReserveVO> size=mybatis.selectList("ReservoVO.checkselectreserve", vo);
		System.out.println("엠프티일땐 뭐냐 size가->>"+size.size());
		/* checklist.add("중복방지용"); */
		return size;
	}
	
	
	

	public UserVO getuser(UserVO vo) {

		return (UserVO) mybatis.selectOne("UserVO.getuser", vo);
	}

}
