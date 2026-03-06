package com.spring.finall.constroller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.FormSecurity.teacher.UserTeacherDetail;
import com.spring.finall.apiResponseController.ApiResponse;
import com.spring.finall.common.util.MapToVOConverter;
import com.spring.finall.reqDto.createOpendayOneDayCLassRequestDTO.OpenDayAndRestDTO;
import com.spring.finall.reqDto.manageonedayclass.AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO;
import com.spring.finall.service.ManageOnedayClassService;
import com.spring.finall.service.TeacherMemberService;
import com.spring.finall.user.OneDayClassVO;

@Controller
@RequestMapping("/api/teacher")
public class TeacherController {

	private static final Map<String, String> POSSIBLE_CHANGEABLE_ACTIONS_Map = Map.of("open", "closed_by_teacher_user",
			"closed_by_teacher_user", "open");

	@Autowired
	private TeacherMemberService teacherMemberService;

	@Autowired
	private ManageOnedayClassService manageOnedayClassService;

	@RequestMapping(value = "/teacher-current-myinfo")
	@ResponseBody
	public Map<String, Object> teacherMyInfo(@AuthenticationPrincipal UserTeacherDetail userTeacherDetail) {

		String username = userTeacherDetail.getUsername();
		Map<String, Object> map = teacherMemberService.currentMyinfo(username);

		return map;
	}

	// teacher_id
	@RequestMapping(value = "/get-my-activeonedayclass")
	@ResponseBody
	public Map<String, Object> getMyActiveOnedayclassList(@AuthenticationPrincipal UserTeacherDetail userTeacherDetail,
			@RequestParam("yearMonth") String yearMonth

	) {

		Long teacher_id = userTeacherDetail.getTeacher_id();
		LocalDate now = null;
		if (yearMonth == null) {

			// 이번 달 년-월 문자열 생성
			now = LocalDate.now();

			yearMonth = now.format(DateTimeFormatter.ofPattern("yyyy-MM"));
		}

		List<Map<String, Object>> activeMonthList = userTeacherDetail.getActiveMonthList();

		Map<String, Object> redMap = new HashMap<String, Object>();

		List<Map<String, Object>> list = null;
		if (activeMonthList == null || activeMonthList.isEmpty()) {
			redMap.put("activeMonthList", activeMonthList);
			redMap.put("list", null);
			return redMap;
		}
		list = manageOnedayClassService.getMyActiveOnedayclassList(teacher_id, yearMonth);

		redMap.put("activeMonthList", activeMonthList);
		redMap.put("list", list);

		return redMap;
	}

	@RequestMapping(value = "/open-month-onedyaclass", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> openMonthOnedyaclass(@AuthenticationPrincipal UserTeacherDetail userTeacherDetail,
			@RequestBody Map<String, Object> bodyParam) {

		Long teacher_id = userTeacherDetail.getTeacher_id();

		// 1️⃣ onedayclass_num 안전하게 읽기
		Integer onedayclassNum = null;
		Object onedayObj = bodyParam.get("onedayclass_num");
		if (onedayObj instanceof Number) {
			onedayclassNum = ((Number) onedayObj).intValue();
		} else if (onedayObj instanceof String) {
			onedayclassNum = Integer.parseInt((String) onedayObj);
		}

		// 2️⃣ openday 배열 안전하게 읽기
		// 2️⃣ openday 배열 안전하게 읽기
		List<String> opendayArr = new ArrayList<>();
		Object opendayObj = bodyParam.get("openday");
		String openYYYYMM = null;

		if (opendayObj instanceof List<?>) {
			List<?> list = (List<?>) opendayObj;

			for (Object o : list) {
				opendayArr.add(o.toString());
			}

			// 대표월 지정 (첫 번째 요소에서 yyyy-MM 추출)
			if (!list.isEmpty()) {
				String firstDate = list.get(0).toString(); // 예: "2025-12-03"
				if (firstDate.length() >= 7) {
					openYYYYMM = firstDate.substring(0, 7); // "2025-12"
				}
			}
		}

		// 3️⃣ DB 작업 예시
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("onedayclass_num", onedayclassNum);
		paramMap.put("opendayArr", opendayArr);
		paramMap.put("teacher_id", (Object) teacher_id);

		List<Map<String, Object>> asyncActiveMonthList = manageOnedayClassService.openMonthOnedayClass(paramMap);

		List<Map<String, Object>> activeMonthList = userTeacherDetail.getActiveMonthList();
		if (activeMonthList == null) {
			activeMonthList = new ArrayList<Map<String, Object>>();
		}
		if (asyncActiveMonthList.size() > 0) {
			Map<String, Object> addactiveMonth = new HashMap<>();
			addactiveMonth.put("reg_month", openYYYYMM);

			activeMonthList.add(addactiveMonth);

			userTeacherDetail.setActiveMonthList(asyncActiveMonthList);
		}

		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		return result;
	}

	// 이미 개강된 월에서의 날짜를 다수 추가
	@RequestMapping(value = "/open-selectday-onedyaclass", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> openSelectdayOnedyaclass(@AuthenticationPrincipal UserTeacherDetail userTeacherDetail,
			@RequestBody List<OpenDayAndRestDTO> requestList) {

		Long teacher_id = userTeacherDetail.getTeacher_id();
		List<Map<String, Object>> findAsyncList = null;
		if (ShorOpenSelectdayOnedyaclassValid(requestList)) {

			manageOnedayClassService.openSelectdayOnedyaclass(requestList);

			AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO asyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO = findMinAndMaxYYYYMMDD(requestList, teacher_id);

			findAsyncList = manageOnedayClassService.getAsyncCurrentMonthOpenningOnedyaClassBySelectOpenList(asyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO);

		}

		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("status", "success");
		result.put("findAsyncFlatList", findAsyncList);
		return result;
	}


	public AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO findMinAndMaxYYYYMMDD(
			List<OpenDayAndRestDTO> requestList, Long teacher_id) {
		if (requestList == null || requestList.isEmpty()) {

		}

		LocalDate minDate = null;
		LocalDate maxDate = null;

		for (OpenDayAndRestDTO dto : requestList) {
			LocalDate date = LocalDate.parse(dto.getOpenday());

			if (minDate == null || date.isBefore(minDate)) {
				minDate = date;
			}
			if (maxDate == null || date.isAfter(maxDate)) {
				maxDate = date;
			}
		}

		List<String> result = new ArrayList<>();
		result.add(minDate.toString()); // yyyy-MM-dd 형식
		result.add(maxDate.toString());

		AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO asyncCurrentMonthOpenningOnedyaClassBySelectOpen = new AsyncCurrentMonthOpenningOnedyaClassBySelectOpenDTO(
				minDate.toString(), maxDate.toString(), teacher_id);

		return asyncCurrentMonthOpenningOnedyaClassBySelectOpen;

	}

	public boolean ShorOpenSelectdayOnedyaclassValid(List<OpenDayAndRestDTO> requestList) {

		LocalDate today = LocalDate.now();
		LocalDate lastDay = today.withDayOfMonth(today.lengthOfMonth());

		boolean isVali = false;

		for (OpenDayAndRestDTO dto : requestList) {

			String openDayStr = dto.getOpenday(); // "yyyy-MM-dd"

			LocalDate openDay = LocalDate.parse(openDayStr);

			try {
				openDay = LocalDate.parse(openDayStr); // yyyy-MM-dd 아니면 예외 발생
			} catch (DateTimeParseException e) {
				return false; // 형식이 잘못됐으면 바로 false
			}

			// 오늘 이상 && 이번달 마지막날 이하
			if (!openDay.isBefore(today) && !openDay.isAfter(lastDay)) {
				isVali = true;
				break;
			}

		}

		return isVali;
	}

	@RequestMapping(value = "/update-manage-onedayclass-status")
	@ResponseBody
	public ResponseEntity<ApiResponse<Map<String, Object>>> updateManageOnedayclassStatus(
			@AuthenticationPrincipal UserTeacherDetail userTeacherDetail, @RequestParam("openday") String openday,
			@RequestParam("nowStatus") String nowStatus, @RequestParam("manageStatus") String manageStatus

	) {
		ApiResponse<Map<String, Object>> apiRes = null;
		Map<String, Object> resBodyData = new HashMap<>();

		if (!shortValiCheck(openday, manageStatus, nowStatus)) {

			resBodyData.put("error_code", 403);

			apiRes = ApiResponse.<Map<String, Object>>builder().code(4003).success(true).message("잘못된 요청입니다.")
					.data(resBodyData).build();
			return ResponseEntity.status(400).body(apiRes);

		}

		resBodyData.put("success", 200);

		final Map<String, String> NOW_ACTIONS = Map.of("open", "개강", "closed_by_teacher_user", "마감");

		Long teacher_id = userTeacherDetail.getTeacher_id();

		manageOnedayClassService.updateManageOnedayclassStatus(teacher_id, openday, manageStatus, nowStatus);

		String before = NOW_ACTIONS.get(nowStatus);
		String after = NOW_ACTIONS.get(manageStatus);

		apiRes = ApiResponse.<Map<String, Object>>builder().code(4003).success(true)
				.message("선택하신 날짜의 상태를 " + before + "에서 " + after + "로 변경하였습니다.").data(resBodyData).build();
		return ResponseEntity.status(200).body(apiRes);

	}

	public boolean shortValiCheck(String openday, String manageStatus, String nowStatus) {
		if (openday == null || manageStatus == null || nowStatus == null) {
			return false;
		}

		String next = POSSIBLE_CHANGEABLE_ACTIONS_Map.get(nowStatus);
		if (next == null || !next.equals(manageStatus)) {
			return false;
		}

		return true;
	}

	@RequestMapping(value = "/update-onedayclassinfo")
	@ResponseBody
	public Map<String, Object> updateOneDayClassInfo(@AuthenticationPrincipal UserTeacherDetail userTeacherDetail,
			@RequestBody OneDayClassVO oneDayClassVO) {

		Long teacher_id = userTeacherDetail.getTeacher_id();

		// 1. 동적 UPDATE 컬럼 생성
		String updateColumns = updateColumnBuilder(oneDayClassVO);

		// 2. DB 업데이트 실행
		int affectedRow = manageOnedayClassService.updateOneDayClassInfo(teacher_id, oneDayClassVO, updateColumns);

		// 3. 결과 Map 준비
		Map<String, Object> res = new HashMap<>();
		res.put("affectedRow", affectedRow);

		if (affectedRow > 0) {
			OneDayClassVO vo = MapToVOConverter.convert(oneDayClassVO.toFieldMap(), OneDayClassVO.class);
			// 5. 업데이트된 정보 반영
			userTeacherDetail.setMyOneDayClassInfo(vo);
		}

		return res;
	}

	public String updateColumnBuilder(OneDayClassVO oneDayClassVO) {
		StringBuilder update절 = new StringBuilder();
		Map<String, Object> map = oneDayClassVO.toFieldMap();

		for (Map.Entry<String, Object> entry : map.entrySet()) {
			Object value = entry.getValue();

			if (value instanceof Integer) {
				Integer intValue = (Integer) value;
				if (intValue != null && intValue > 0) { // 0보다 큰 값만
					if (update절.length() > 0) {
						update절.append(", ");
					}
					update절.append(entry.getKey()).append("=#{").append(entry.getKey()).append("}");
				}
			} else if (value instanceof String) {
				String strValue = (String) value;
				if (strValue != null && !strValue.isEmpty()) { // null 또는 빈 문자열 제외
					if (update절.length() > 0) {
						update절.append(", ");
					}
					update절.append(entry.getKey()).append("=#{").append(entry.getKey()).append("}");
				}
			}
			// 다른 타입은 필요에 따라 추가 처리 가능
		}

		return update절.length() > 0 ? update절.toString() : null;
	}

}
