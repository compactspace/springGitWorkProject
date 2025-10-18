package com.spring.finall.security;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SecurityUserDaoBatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public int checkidMembership(SecurityUserVO vo) {

		Integer executerow = mybatis.selectOne("SecurityUserVO.isDuplicate", vo);
		System.out.println("쿼리 실행값 0 이면 중복 아님" + executerow);

		return executerow;
	};

	public int insertMembership(SecurityUserVO vo) {

		// 여기서 회원과 관리자의 분기점을 주어보자.
		// 회사에서 가입시 특정 문자를 주고 그 문자열이 포함되어 있니로 할것이다.
		// 예를 들어 관리자들은 아이디 가입할때 반드시 XQLS 를 포함시키세요 공고를 하고
		// 그걸로 관리자를 구분하자.


		String check = vo.getUser_id();
		
		if (check.contains("XQLS")) {			
			vo.setUser_id(check);
			vo.setUser_role("ROLE_ADMIN");
			Integer executerow = mybatis.insert("SecurityUserVO.insertAdmin", vo);
			System.out.println("ok 넌 관리자임");
			return executerow;
		} else {

			vo.toString();
			Integer executerow = mybatis.insert("SecurityUserVO.insertMembership", vo);
			System.out.println("쿼리 실행값 0 이면 중복 아님" + executerow);

			return executerow;
		}

	};

}
