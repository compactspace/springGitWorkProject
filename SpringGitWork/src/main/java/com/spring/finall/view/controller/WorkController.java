package com.spring.finall.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.WorkImgVO;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.service.WorkService;
import com.spring.finall.user.OneDayClassVO;

@Controller
public class WorkController {
	// 서비스호출위해 자동주입
	@Autowired
	private WorkService workService;
	
	@Autowired
	private OneDayClassService oneDayClassService;

	String savespace = "c:/swork/finall/src/main/webapp/img/";

	//후기 페이지 최초 진입으로 함수를 바꾼다.
	@RequestMapping(value = "/getworklist.do")
	public String getworkimg(WorkImgVO vo,OneDayClassVO ovo ,Model model, HttpServletRequest req) {
		
		String onedayclass_name=req.getParameter("onedayclass_name");
		Integer nextpage=Integer.parseInt(req.getParameter("nextpage"));
		if(onedayclass_name==null) {
			onedayclass_name="취미만화반";
			ovo.setOnedayclass_name(onedayclass_name);
		}
		
		if(nextpage==0) {
			nextpage=0;
			ovo.setNextpage(nextpage);	
		}else {
			ovo.setNextpage(nextpage);	
		}	
		
		
		System.out.println("스크립트에서 받은 nextepage: "+ovo.getNextpage());
		HashMap<String,Object>	map =oneDayClassService.getReview(ovo);
		
		System.out.println("맵: "+map.get("onedayclass"));
		
		
		model.addAttribute("onedayclass",map.get("onedayclass"));
		model.addAttribute("joinToReview",map.get("joinToReview"));
		
		
//		model.addAttribute("worklist", workService.gettworkimg(vo));
//		System.out.println(workService.gettworkimg(vo));
//		System.out.println("행수를 받아와야함->"+vo.getNumfornextorback());
//		System.out.println("/ 연산->"+(vo.getNumfornextorback()/12));
//
////		vo.setNumfornextorback(vo.getNumfornextorback()%12);
//		String[] buttonnum=new String[(vo.getNumfornextorback()/12)+1];
//		
//		model.addAttribute("buttonnum",buttonnum);
//		return "worklist.jsp";
		
		return "drawinglist.jsp";
	}

	
		
		
		
	
	
	
	
		
	
	
	
	
	
	
	@RequestMapping(value = "/getpagingworkimg.do")
	@ResponseBody
	public List<WorkImgVO> getpagingworkimg(WorkImgVO vo, Model model, HttpServletRequest req) {
		
		System.out.println("아작스연결 환영합니다.");
		System.out.println("req.getParameter(\"pagebtn\")->>>"+req.getParameter("pagebtn"));
		if(req.getParameter("pagebtn").equals("1")) {
			
			System.out.println("버튼 1이 출력");
		
		
			
			return workService.gettworkimg(vo);
			
		} else {
			int graterthanonepage=Integer.parseInt(req.getParameter("pagebtn"));
			int pagingcheck_num=workService.numfornextorback(vo);
			
		
			System.out.println("버튼->>>"+ graterthanonepage+"가출력 출력");
			System.out.println("총 로우수 ->>>"+ pagingcheck_num);
			System.out.println("계산수 ->>>"+ graterthanonepage*12);
			
			vo.setGraterthanonepage((graterthanonepage-1)*12);
			return	graterthanonepage(vo,model,graterthanonepage);
	
//		
//			if(pagingcheck_num>(graterthanonepage*12))
//			{vo.setGraterthanonepage((graterthanonepage-1)*12);
//				return	graterthanonepage(vo,model,graterthanonepage);
//			
//			}
//			else {
//			
//				System.out.println("배수가 아닐시 출력되어야함");
//				vo.setGraterthanonepage(((graterthanonepage-1)*12)-pagingcheck_num);
//			
//				return		graterthanonepage(vo,model,graterthanonepage);
//				
//			}
			
		 
			
			
		}
	
	
	}
	
	

	
	
	public List<WorkImgVO> graterthanonepage(WorkImgVO vo, Model model, int graterthanonepage) {
//		model.addAttribute("worklist", workService.gettworkimg(vo));

		
	return  workService.graterthanonepage(vo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 사용자들이 그림을 올리는 함수
	@RequestMapping(value = "/insertimg.do")
	public String insertImg(WorkImgVO vo, HttpServletRequest req) throws IllegalStateException, IOException {
		req.setCharacterEncoding("utf-8");
		System.out.println("내가 지금호출이나 되나");
		MultipartFile uploadFile = vo.getWorklist_img_upload();

		File f = new File(savespace);
		if (!f.exists()) {
			f.mkdirs();
		}

		String fileName = uploadFile.getOriginalFilename();

		if (!uploadFile.isEmpty()) {
			vo.setWorklist_img(fileName);
			uploadFile.transferTo(new File(savespace + fileName));

		}

		workService.insertImg(vo);
		return "redirect:worklist.jsp";
	}

	
	
	

	
	
	
	
	
	
}
