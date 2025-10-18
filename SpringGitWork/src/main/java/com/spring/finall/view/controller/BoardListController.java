//package com.spring.finall.view.controller;
//
//import java.io.File;
//import java.io.IOException;
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.spring.finall.BoardVO;
//import com.spring.finall.service.BoardService;
//
//@Controller
//public class BoardListController {
//	String savespace = "c:/swork/finall/src/main/webapp/img_board/";
//	@Autowired
//	private BoardService boardservice;
//
//	//메뉴 바로 타고오는 최초 게시글 
//	@RequestMapping(value = "/firstgetboad.do")
//	public String getBoard(BoardVO vo, Model model, HttpServletRequest req) {
//		
//		
//		Integer page = (Integer) Integer.parseInt(req.getParameter("page"));
//		if(page==0) {
//			page=0;
//		}	
//		
//	
//		List<BoardVO> firstboardlist = boardservice.getBoard(vo);
//		model.addAttribute("firstboardlist", firstboardlist);
//		model.addAttribute("page", 1);
//		
//	
//		String[] btncounting=new String[(vo.getBtncounting()/10)+1];
//		model.addAttribute("btncounting",btncounting);
//		model.addAttribute("next",10);
//		return "getboardlist.jsp";
//
//	}
//
//}
