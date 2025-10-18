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
			
			
//	@RequestMapping(value = "/onepagegetboad.do")
//	@ResponseBody
//	public List<BoardVO> getBoard(@RequestParam(value = "page", required = true) int page, BoardVO vo,
//			HttpServletRequest req, Model model) {
//		System.out.println("page->>>"+page);
//	// 리밋절 에서 10단위로 갈것이기에 십의 배수로 가는것일뿐임
//		int seq = (page-1) * 10;
//		vo.setSeq(seq);
//		List<BoardVO> boardlist = boardservice.getBoard(vo);
//		
//		/* req.setAttribute("boardlist", boardlist); */
//
//		return boardlist;
//
//	}
//	
//	
//	@RequestMapping(value = "/getboadnoajax.do")
//	public String getBoardnoajax(@RequestParam(value = "page", required = true) int page, BoardVO vo, Model model) {
//		System.out.println("page->>>"+page);
//	// 리밋절 에서 10단위로 갈것이기에 십의 배수로 가는것일뿐임
//		int seq = (page-1) * 10;
//		vo.setSeq(seq);
//		List<BoardVO> boardlist = boardservice.getBoard(vo);		
//
//		System.out.println("내가 누른 버튼이 10의 배수?"+(page%10 == 0));
//		if(page%10 == 0) {
//			model.addAttribute("next",page+10);
//			model.addAttribute("page",page+1);
//		}
//		
//		model.addAttribute("boardlist",boardlist);
//
//		return "getboardlist.jsp";
//
//	}
//	
//	@RequestMapping(value = "/getboadnext.do")
//	public String getboadnext(@RequestParam(value = "page", required = true) int page, BoardVO vo, Model model) {
//		System.out.println("page->>>"+page);
//	// 리밋절 에서 10단위로 갈것이기에 십의 배수로 가는것일뿐임
//		int seq = (page-1) * 10;
//		vo.setSeq(seq);
//		List<BoardVO> boardlist = boardservice.getBoard(vo);		
//
//		System.out.println("내가 누른 버튼이 10의 배수?"+(page%10 == 0));
//		if(page%10 == 0) {
//			model.addAttribute("next",page+10);
//			model.addAttribute("page",page+1);
//		}
//		
//		model.addAttribute("boardlist",boardlist);
//
//		return "getboardlist.jsp";
//
//	}	
//	
//	
//	@RequestMapping(value = "/getboadbacklist.do")
//	public String getboadbacklist(@RequestParam(value = "page", required = true) int page, BoardVO vo, Model model) {
//		System.out.println("page->>>"+page);
//		
//		
//	// 리밋절 에서 10단위로 갈것이기에 십의 배수로 가는것일뿐임
//		int seq = (page-1) -10;
//		vo.setSeq(seq);
//		List<BoardVO> boardlist = boardservice.getBoard(vo);		
//
//		System.out.println("back 버튼이 10의 배수?"+((page-1)%10 == 0));
//		if((page-1)%10 == 0) {
//			model.addAttribute("next",seq+10);
//			//page 21 이면 seq = 10
//			model.addAttribute("page",seq+1);
//		}
//		
//		model.addAttribute("boardlist",boardlist);
//
//		return "getboardlist.jsp";
//
//	}
//	
//	
//	
//	
//	
//	//게시물 클릭시 게시물을 보여주는 메소드
//	@RequestMapping(value = "/showboard.do")	
//	public String showBoard(BoardVO vo, HttpServletRequest req, Model model) {	
//		vo.setWriter(req.getParameter("writer"));
//		vo.setSeq(Integer.parseInt(req.getParameter("seq")));
//		vo.setCnt(Integer.parseInt(req.getParameter("cnt"))+1);
//		int cnt=updateCntBoard(vo);
//		if(cnt>=1) {
//		BoardVO showboard = boardservice.showBoard(vo);
//		System.out.println("showboard 뭐여"+showboard);
//		model.addAttribute("showboard", showboard);
//
//		return "getboard.jsp";
//		} else {
//			
//			return "redirect:getboardlist.jsp";	
//		}
//
//	}
//	
//	//게시물 클릭시 조회수 올려주는 보조 메소드	
//	public int updateCntBoard(BoardVO vo) {
//	 
//		System.out.println("업데이트는 1행 이상이여야함->>"+boardservice.updateCntBoard(vo));
//   return boardservice.updateCntBoard(vo);
//    
//    
//    
//
//	}
//	
//	
//	
//	
//	// 주의! 간편 게시물 등록이아님 상세 게시물 등록이다잉
//	// 사용자들이 게시물을 등록하는 함수
//		@RequestMapping(value = "/insertboard.do")
//		public String insertBoard(BoardVO vo, HttpServletRequest req) throws IllegalStateException, IOException {
//			/* vo.setTitle(req.getParameter("")) */
//			System.out.println("게시판 리퀘스트매핑입니다.");
//			MultipartFile uploadFile = vo.getWorklist_img_upload();
//
//			File f = new File(savespace);
//			if (!f.exists()) {
//				f.mkdirs();
//			}
//
//			String fileName = uploadFile.getOriginalFilename();
//
//			if (!uploadFile.isEmpty()) {
//				vo.setFilename(fileName);
//				uploadFile.transferTo(new File(savespace + fileName));
//
//			}
//
//			boardservice.insertBoard(vo);
//			return "/firstgetboad.do";
//		}
//	
	
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
