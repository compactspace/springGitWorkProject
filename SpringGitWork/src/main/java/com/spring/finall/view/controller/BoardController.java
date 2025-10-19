package com.spring.finall.view.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;


import com.spring.finall.BoardVO;
import com.spring.finall.service.BoardService;

@Controller
public class BoardController {
	String savespace = "c:/swork/finall/src/main/webapp/img_board/";
	@Autowired
	private BoardService boardservice;

	//메뉴 바로 타고오는 최초 게시글 
	@RequestMapping(value = "/firstgetboad.do")
	public String getBoard(BoardVO vo, Model model, HttpServletRequest req) {
		Integer startpage = Integer.parseInt(req.getParameter("startpage"));
		System.out.println("리밋 절의 시작페이지 변수 값"+startpage);

		List<BoardVO> firstboardlist = boardservice.getBoard(vo,startpage);
		
		
//		for(BoardVO bvo : firstboardlist) {			
//			System.out.println("bvo.getNextpage()->>"+bvo.getNextpage());			
//		}
		
		model.addAttribute("boardlist", firstboardlist);
	
		return "getboardlist2.jsp";

	}
	
	
	
		//각 버튼당 매핑
		@RequestMapping(value = "/eachbtn.do")
		public String geteachbtnBoard(BoardVO vo,Model model, HttpServletRequest req) {
			Integer startpage = Integer.parseInt(req.getParameter("startpage"));
			Integer nextpage = Integer.parseInt(req.getParameter("nextpage"));
			Integer backpage = Integer.parseInt(req.getParameter("backpage"));
		
			List<BoardVO> eachboardlist = boardservice.geteachbtnBoard(vo);
			
			model.addAttribute("boardlist", eachboardlist);	

		
			return "getboardlist2.jsp";

		}
		
	//다음 페이지 보드		
			@RequestMapping(value = "/nextpageboard.do")
			public String getnextBoard(BoardVO vo,Model model, HttpServletRequest req) {	
				
				List<BoardVO> eachboardlist = boardservice.getnextBoard(vo);
				
//				for(BoardVO b :eachboardlist) {
//					System.out.println("게시번호 "+b.getSeq());
//					System.out.println("넥스트 "+b.getNextpage());
//					
//				}
				
				
				
				model.addAttribute("boardlist", eachboardlist);	

			
				return "getboardlist2.jsp";

			}
			
//이전 페이지 보드
			
			@RequestMapping(value = "/backpageboard.do")
			public String getbackBoard(BoardVO vo,Model model, HttpServletRequest req) {	
				
				List<BoardVO> eachboardlist = boardservice.getbackBoard(vo);
				
				model.addAttribute("boardlist", eachboardlist);	

			
				return "getboardlist2.jsp";

			}
			
			
			@RequestMapping(value = "/boardsearch.do")
			public String getboardsearch(BoardVO vo,Model model, HttpServletRequest req) {	
				
				System.out.println("keyword->"+req.getParameter("keyword"));
				System.out.println("serchvalue->"+req.getParameter("serchvalue"));
				System.out.println("nextpage->"+req.getParameter("nextpage"));
				
				List<BoardVO> eachboardlist = boardservice.getboardsearch(vo,req);
				
				model.addAttribute("boardlist", eachboardlist);	

			
				return "getboardlist2.jsp";

			}
			
			

			//텍스트 전용 게시판
			@RequestMapping(value = "/inserttextboard.do")
			public String insertBoard(BoardVO vo, HttpServletRequest req) throws IllegalStateException, IOException {
				/* vo.setTitle(req.getParameter("")) */
				System.out.println("게시판 리퀘스트매핑입니다.");				
	
				boardservice.insertBoard(vo);
				return "firstgetboad.do?startpage=0";
			}
		
			//텍스트 게시물 글릭후 보여주는 함수
			
			@RequestMapping(value = "/getOneViewBoard.do")
			@ResponseBody
			public BoardVO  getOneViewBoard(BoardVO vo, HttpServletRequest req) throws IllegalStateException, IOException {
				/* vo.setTitle(req.getParameter("")) */
				System.out.println("게시물 클릭후 게시물 보여주는 매핑");			
				
				BoardVO getOneViewBoard =boardservice.getOneViewBoard(vo);
				return getOneViewBoard;
			}
			
			
			
}
