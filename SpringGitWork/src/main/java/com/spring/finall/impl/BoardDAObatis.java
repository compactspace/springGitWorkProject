package com.spring.finall.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finall.BoardVO;

@Repository
public class BoardDAObatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	//페이지 최초 진입
	public List<BoardVO> getBoard(BoardVO vo, Integer startpage) {
			
		
		//게시판만 있고 내용물이 없다면 mybatis.selectOne("BoardDAO.totalrow"); 널포인트 익셉션 발생하니
		try {
			Integer	totalrow=mybatis.selectOne("BoardDAO.firsttotalrow");
			Integer quotient=totalrow/10;
			Integer rest=totalrow%10;
			Integer nextpage=0;
			Integer backpage=-1;
			Integer startbtn=0;
			Integer endbtn=0;
			Boolean flagendpage;
			System.out.println("목은 "+quotient+"  나머지는 "+rest);
			
			if(quotient==0) {		
				nextpage=0;
				startbtn=0;
				flagendpage=true;
				
			}else {
				flagendpage=false;
				if(quotient>5) {
					nextpage=50;
					startbtn=0;
					endbtn=startbtn+4;
					totalrow=totalrow-50;
				}else {
					
					//1 그리고 3+1 
					startbtn=0;
					endbtn=startbtn+quotient;
					flagendpage=true;
				}
				
			}
			
			
			
			System.out.println("---- ----------------최초페이지 진입 연산후---------------------------");
			System.out.println(
					
					"다음페이지 값"+nextpage+
					" 이전페이지 값"+backpage+
					" 시작 btn"+startbtn+
					" 종료btn "+endbtn+
					" 토탈로우 "+totalrow				
					);	
			
			
		
			//---추가코드 구분선-----
			//빌더 패턴을 적용하지 않아 이렇게라도 한다.
			vo.setBtncounting(btncounting(vo));	
			
			List<BoardVO> list=mybatis.selectList("BoardDAO.getBoard",startpage);
			list.get(0).setNextpage(nextpage);
			list.get(0).setBackpage(backpage);
			list.get(0).setStartbtn(startbtn);
			list.get(0).setEndbtn(endbtn);
			list.get(0).setTotalrow(totalrow);
			list.get(0).setFlagendpage(flagendpage);
			return list;
			
		}catch(Exception e) {
			System.out.println(e);
			return null;
		}
		

	}
	
	
	//각 버튼에 대한
	
	public List<BoardVO> geteachbtnBoard(BoardVO vo){
		System.out.println(
				"버튼값 "+vo.getStartpage()
				+"다음페이지 값"+vo.getNextpage()
				+" 이전페이지 값"+vo.getBackpage()
				+" 시작 btn"+vo.getStartbtn()
				+" 종료btn "+vo.getEndbtn()
				+"검색조건페이지니 "+vo.getIsserch()
		);
		
		// 리밋절은 0 행부터 계산한다. 따라서
		//select * from board limit (버튼값-1)*10, 10; 이렇게 하자.
		vo.setStartpage((vo.getStartpage()-1)*10);
		Integer startpage=vo.getStartpage();
		Boolean flagendpage=vo.getFlagendpage();
		List<BoardVO> list=mybatis.selectList("BoardDAO.getBoard",vo);
		//유저는 빌더패턴 미적용으로 마이바티스에서 받은후 세팅을 이렇게 해줘야한다.
		list.get(0).setNextpage(vo.getNextpage());
		list.get(0).setBackpage(vo.getBackpage());
		list.get(0).setEndbtn(vo.getEndbtn());
		list.get(0).setStartbtn(vo.getStartbtn());
		list.get(0).setTotalrow(vo.getTotalrow());
		if(vo.getIsserch()!=null) {
			list.get(0).setIsserch("isserch");
			list.get(0).setKeyword(vo.getKeyword());
			list.get(0).setSerchvalue(vo.getSerchvalue());
		}
		list.get(0).setFlagendpage(flagendpage);
		return list;
	};
	
	
	
	public List<BoardVO> getnextBoard(BoardVO vo){
		System.out.println(
				
				"버튼값 "+vo.getStartpage()+
				"다음페이지 값"+vo.getNextpage()+
				" 이전페이지 값"+vo.getBackpage()+
				" 시작 btn"+vo.getStartbtn()+
				" 종료btn "+vo.getEndbtn()+
				" isSerch  "+vo.getIsserch()+
				" keyword "+vo.getKeyword()+
				" Serchvalue "+vo.getSerchvalue()+
				" 토탈로우 "+vo.getTotalrow()				
				);
	
		//리미트 절이 버그가 있어서 마지막개시글 값을 가져오자.	
		//SELECT MIN(seq) FROM (SELECT * FROM board LIMIT #{nextpage},10) AS si;
		Integer minseq=mybatis.selectOne("BoardDAO.minseq",vo);
		System.out.println("minseq->>"+minseq);
		
		vo.setSeq(minseq);
		//그다음 행수를 받아온다. 지금 서브쿼리문으로 count 값을 못가져 와서 이럼 ㅅㅂ
		System.out.println("vo.segSeq>>"+vo.getSeq());
		//SELECT  COUNT(*) FROM board where seq>=#{seq};
		Integer	totalrow=mybatis.selectOne("BoardDAO.nexttotalrow",vo);
		
		Integer nextpage=vo.getNextpage();
		List<BoardVO> list=mybatis.selectList("BoardDAO.getnextBoard",nextpage);
		//내일 수정 지금 변수 nextpage 와 startpage 와 혼용되어서 코드가 꼬여버림 mapping xml도 봐라..
		
		Integer quotient=totalrow/10;
		Integer rest=totalrow%10;		
		Integer backpage=vo.getBackpage();
		Integer startbtn;
		Integer endbtn;
		Integer startpage=vo.getNextpage();
		Boolean flagendpage=false;
		
		System.out.println("목은 "+quotient+"  나머지는 "+rest);
		
		//즉 버튼이 한개만 있는경우
		if(quotient==0) {
			
			//거 뭐냐.. 다시 첫 페이지로 오면 backpage 가 음수갑이라 판단용임 
			if(backpage<0) {
				backpage=0;
			}
			
			backpage=nextpage-50;
			nextpage=nextpage+50;
			startbtn=vo.getEndbtn()+1;
			endbtn=0;
			flagendpage=true;
			
		}else {
			
			//버튼이 최소 5개이상 있는경우 
			if(quotient>=5) {
				flagendpage=false;
				
				//거 뭐냐.. 다시 첫 페이지로 오면 backpage 가 음수갑이라 판단용임 
				if(backpage<0) {
					backpage=0;
				}
				
				
				backpage=nextpage-50;
				nextpage=vo.getNextpage()+50;
				startbtn=vo.getEndbtn()+1;
				
				endbtn=startbtn+4;
				
				totalrow=totalrow-50;
				
				// 버튼이 최소 5개 미만 인경우
			}else {				
				//1 그리고 3+1 
				
		
				if(backpage<0) {
					backpage=0;
				}
				backpage=nextpage-50;
				nextpage=nextpage+50;				
				startbtn=vo.getEndbtn()+1;
				endbtn=startbtn+quotient;
				flagendpage=true;
				
			}
			
		}	
		
		System.out.println("---- ----------------다음 페이지연산후---------------------------");
		System.out.println(
				
				"다음페이지값 :"+nextpage+
				" 이전페이지값:"+backpage+
				" 시작btn :"+startbtn+
				" 종료btn :"+endbtn+
				" 마지막깃발 :"+flagendpage				
				);		
		
		//유저는 빌더패턴 미적용으로 마이바티스에서 받은후 세팅을 이렇게 해줘야한다.
		list.get(0).setNextpage(nextpage);
		list.get(0).setBackpage(backpage);
		list.get(0).setEndbtn(endbtn);
		list.get(0).setStartbtn(startbtn);
		list.get(0).setStartpage(startpage);
		list.get(0).setTotalrow(totalrow);
		list.get(0).setFlagendpage(flagendpage);
		if(vo.getIsserch()!=null) {
			list.get(0).setIsserch("isserch");
			list.get(0).setKeyword(vo.getKeyword());
			list.get(0).setSerchvalue(vo.getSerchvalue());
		}
		return list;
	};
		
	public List<BoardVO> getbackBoard(BoardVO vo){
		System.out.println(
				"버튼값 "+vo.getStartpage()+
				"다음페이지 값"+vo.getNextpage()+
				" 이전페이지 값"+vo.getBackpage()+
				" 시작 btn"+vo.getStartbtn()+
				" 종료btn "+vo.getEndbtn()+
				" isSerch  "+vo.getIsserch()+
				" keyword "+vo.getKeyword()+
				" Serchvalue "+vo.getSerchvalue()+
				" 토탈로우 "+vo.getTotalrow()				
				);		
		
		

		
		Integer backpage=vo.getBackpage();
		
		List<BoardVO> list=mybatis.selectList("BoardDAO.getbackBoard",backpage);
		
		Integer nextpage=vo.getNextpage();
		Integer startbtn=vo.getStartbtn();
		Integer endbtn=vo.getEndbtn();
		backpage=backpage-50;
		nextpage=nextpage-50;
		startbtn=startbtn-5;
		
		//마지막 페이지에선 endbtn 값이 0 이 되어 아래처럼 처리
		endbtn=startbtn+4;
				
		
		System.out.println("---- ----------------이전 페이지연산후---------------------------");
		System.out.println(
				
				"다음페이지값: "+nextpage+
				" 이전페이지값: "+backpage+
				" 시작btn: "+startbtn+
				" 종료btn: "+endbtn	
				);	

		
		//유저는 빌더패턴 미적용으로 마이바티스에서 받은후 세팅을 이렇게 해줘야한다.
		list.get(0).setNextpage(nextpage);
		list.get(0).setBackpage(backpage);
		list.get(0).setEndbtn(endbtn);
		list.get(0).setStartbtn(startbtn);
		list.get(0).setFlagendpage(false);
		if(vo.getIsserch()!=null) {
			list.get(0).setIsserch("isserch");
			list.get(0).setKeyword(vo.getKeyword());
			list.get(0).setSerchvalue(vo.getSerchvalue());
		}
		return list;
	};
	
	
	public List<BoardVO> getboardsearch(BoardVO vo,HttpServletRequest req){
		
		HashMap<String, Object> map = new HashMap(); 
		String keyword=req.getParameter("keyword");
		String serchvalue= req.getParameter("serchvalue");
		Integer nextpage=Integer.parseInt(req.getParameter("nextpage"));
		map.put("keyword", keyword);
		map.put("serchvalue", serchvalue);
		map.put("nextpage", nextpage );
		List<BoardVO> list=mybatis.selectList("BoardDAO.getboardsearchrow",map);
		List<BoardVO> firstpagelist=mybatis.selectList("BoardDAO.getboardsearch",map);
		Integer totalrow=list.size();		
		Integer quotient=totalrow/10;
		Integer rest=totalrow%10;
		
		Integer backpage=0;;
		Integer startbtn;
		Integer endbtn=0;
		Boolean flagendpage;
		System.out.println("목은 "+quotient+"  나머지는 "+rest);
		
		if(quotient==0) {		
			nextpage=0;
			startbtn=0;
			flagendpage=true;
			backpage=-1;
			
		}else {
			flagendpage=false;
			if(quotient>=5) {
				nextpage=50;
				startbtn=0;
				endbtn=startbtn+4;
			
			}else {				
				//1 그리고 3+1 
				nextpage=0;
				startbtn=0;
				endbtn=startbtn+quotient;
				flagendpage=true;
				System.out.println("이걸타나??");
			}
			
		}	
		
		System.out.println("---- ----------------검색 페이지 첫진입 페이지연산후---------------------------");
		System.out.println(
				
				"다음페이지값: "+nextpage+
				" 이전페이지값: "+backpage+
				" 시작btn: "+startbtn+
				" 종료btn: "+endbtn	
				);	
		
		
		firstpagelist.get(0).setNextpage(nextpage);
		firstpagelist.get(0).setBackpage(backpage);
		firstpagelist.get(0).setEndbtn(endbtn);
		firstpagelist.get(0).setStartbtn(startbtn);
		firstpagelist.get(0).setIsserch("isserch");
		firstpagelist.get(0).setFlagendpage(flagendpage);
		firstpagelist.get(0).setKeyword(keyword);
		firstpagelist.get(0).setSerchvalue(serchvalue);		
		return firstpagelist;
	}
	
	
	
	public int btncounting(BoardVO vo) {
		System.out.println("마이베티스속 seq는->>" + vo.getSeq());
		return mybatis.selectOne("BoardDAO.btncounting", vo);

	}
	
	
	
	public BoardVO showBoard(BoardVO vo) {
		
		return mybatis.selectOne("BoardDAO.showBoard", vo);
	}
	
	

	//온리 텍스트 사입 메서드
	public int insertBoard(BoardVO vo) {
		System.out.println("마이베티스속 커맨드객체 ");
		System.out.println(vo);
		return mybatis.insert("BoardDAO.inserttextBoard", vo);
		
	}
	
	//텍스트 게시물 보여주는 메서드
	public BoardVO getOneViewBoard(BoardVO vo) {
		System.out.println("마이베티스속 커맨드객체 ");
		System.out.println(vo);
		return mybatis.selectOne("BoardDAO.getOneViewBoard", vo);
		
	}
	
	
	
	//그림과 텍스트 삽입 메서드
//	public int insertBoard(BoardVO vo) {
//		System.out.println("마이베티스속 커맨드객체 ");
//		System.out.println(vo);
//		return mybatis.insert("BoardDAO.insertBoard", vo);
//		inserttextBoard
//	}
	
	
	
	public int updateCntBoard(BoardVO vo) {
		System.out.println("마이베티스속 조회수 cnt는->>" + vo.getCnt());
		return mybatis.update("BoardDAO.updateCntBoard", vo);

	}

}
