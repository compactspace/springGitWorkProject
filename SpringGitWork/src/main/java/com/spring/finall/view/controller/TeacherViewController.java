package com.spring.finall.view.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.FormSecurity.teacher.UserTeacherDetail;
import com.spring.finall.service.TeacherMemberService;
import com.spring.finall.user.OneDayClassVO;

@Controller
@RequestMapping("/teacher")
public class TeacherViewController {

	@Autowired
	private RedisTemplate<String, String> redisTemplate;

	@Autowired
	private TeacherMemberService teacherMemberService;

	@GetMapping("/login-page") // 실제 요청 경로: /users/login
	public String showTeacherLoginPage() {

		return "teacherLogin/teacherLogin"; // 뷰리졸버에 의해 /WEB-INF/views/login.jsp로 매핑됨

	}

	@GetMapping("/signup-page") // 실제 요청 경로: /users/login
	public String showSignUpPage(@AuthenticationPrincipal UserTeacherDetail userTeacherDetails,
			HttpServletRequest req) {

		if (userTeacherDetails != null && userTeacherDetails.getUsername() != null) {
			return "mainPage/mainhome";
		}
		// 1. 현재 사용자의 HttpSession 객체 획득
		HttpSession session = req.getSession();

		// 2. 이 사용자의 고유 세션 ID 확인
		String sessionId = session.getId();

		String verifiedKey = "signup:verified:session:" + sessionId;

		if (redisTemplate.hasKey(verifiedKey)) {

			return "teacherSignUpPage/teacherSignUpPage";

		}

		return "teachersignupSmsAuthPage/teachersignupSmsAuthPage";

	}

	@GetMapping("/teacher-my-info")
	public String teacherMyInfo() {
		return "teacherMyPage/teacherMyPage";
	}

	@GetMapping("/teacher-payinfo")
	public String teacherPayInfo() {
		return "teacherPayInfo/teacherPayInfo";
	}



	@GetMapping("/teacher-manage-onedayclass-schedule")
	public String teacherManageOnedayclass() {
		return "teacherManageOnedyclass/teacherManageOnedyclass";
	}

	@GetMapping("/teacher-manage-onedayclassinfo")
	public String teacherManageOnedayclassIfno(@AuthenticationPrincipal UserTeacherDetail userTeacherDetails,
			Model model) {

		OneDayClassVO myOneDayClassInfo = userTeacherDetails.getMyOneDayClassInfo();
		if (myOneDayClassInfo != null) {
			model.addAttribute("myOneDayClassInfo", myOneDayClassInfo);
			return "teacherMyOnedyclassInfoUpdate/teacherMyOnedyclassInfoUpdate";
		}

		return "teacherManageOnedyclass/teacherManageOnedyclass";
	}

	@GetMapping("/teacher-manage-onedayclass-month-register")
	public String teacherManageOneDayclassMonthRegister(@AuthenticationPrincipal UserTeacherDetail userTeacherDetails,
			Model model) {

		LocalDate today = LocalDate.now();
		int year = today.getYear();
		int currentMonth = today.getMonthValue();

		Long teacherId = userTeacherDetails.getTeacher_id();

		List<Map<String, Object>> activeMonthList = userTeacherDetails.getActiveMonthList();
		if (activeMonthList == null) {
			activeMonthList = new ArrayList<>();
		}

		List<Map<String, Object>> monthListForFront = new ArrayList<>();

		for (int month = currentMonth; month <= 12; month++) {
			String yyyyMM = String.format("%04d-%02d", year, month);
			boolean found = false;
			Map<String, Object> monthMapForFront = new HashMap<>();

			// activeMonthList에 있는지 확인
			for (Map<String, Object> monthMap : activeMonthList) {
				if (yyyyMM.equals(monthMap.get("reg_month"))) { // 키를 reg_month로 변경
					monthMapForFront.put("yyyyMM", yyyyMM);
					monthMapForFront.put("status", "alreadyOpen");
					monthMapForFront.put("displayText", month + "월 수업 관리");
					monthMapForFront.put("actionUrl",
							"/teacher/teacher-manage-onedayclass-month-schedule?yyyyMM=" + yyyyMM);
					found = true;
					break;
				}
			}

			if (!found) {
				monthMapForFront.put("yyyyMM", yyyyMM);
				monthMapForFront.put("status", "possibleOpen");
				monthMapForFront.put("displayText", month + "월 수업 추가");
				monthMapForFront.put("actionUrl",
						"/teacher/teacher-manage-onedayclass-month-register?yyyyMM=" + yyyyMM);
			}

			monthListForFront.add(monthMapForFront);
		}

		model.addAttribute("monthList", monthListForFront);

		return "teacherManageOneDayclassMonthRegister/teacherManageOneDayclassMonthRegister";
	}

	
	@GetMapping("/teacher-applicant-status")
	public String teacherApplicantStatus(@AuthenticationPrincipal UserTeacherDetail userTeacherDetails, Model model) {

		Long teacher_id = userTeacherDetails.getTeacher_id();
		List<Map<String,Object>> currentMyDocuments = teacherMemberService.currentMyDocuments(teacher_id);
		model.addAttribute("currentMyDocuments", currentMyDocuments);
		return "teacherApplicantStatus/teacherApplicantStatus";
	}

}
