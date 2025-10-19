package com.spring.finall.view.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.finall.WorkImgVO;
import com.spring.finall.service.OneDayClassService;
import com.spring.finall.user.OneDayClassVO;


@Controller
@RequestMapping("/oneday")
public class OnedayClassController {


	@Autowired
	private OneDayClassService oneDayClassService;
	

	// 다른 후기 버튼 클릭시 호출된다.
	@RequestMapping(value = "/getOtherReview.do")
	public String getOtherReivew(WorkImgVO vo, OneDayClassVO ovo, Model model, HttpServletRequest req) {

		String onedayclass_name = req.getParameter("onedayclass_name");
		Integer nextpage = Integer.parseInt(req.getParameter("nextpage"));

		if (onedayclass_name == null) {
			onedayclass_name = "취미만화반";
			ovo.setOnedayclass_name(onedayclass_name);
		} else {

			ovo.setOnedayclass_name(onedayclass_name);
		}

		if (nextpage == 0) {
			nextpage = 0;
			ovo.setNextpage(nextpage);
		} else {
			ovo.setNextpage(nextpage);
		}

		HashMap<String, Object> map = oneDayClassService.getReview(ovo);

		model.addAttribute("onedayclass", map.get("onedayclass"));
		model.addAttribute("joinToReview", map.get("joinToReview"));
		model.addAttribute("isEmpty", map.get("isEmpty"));

		return "onedayclass/onedayclasssubmit2";
	}

	

}
