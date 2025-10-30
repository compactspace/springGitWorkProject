package com.spring.finall.constroller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.FormSecurity.teacher.UserTeacherDetail;
import com.spring.finall.common.util.MapToVOConverter;
import com.spring.finall.service.ManageOnedayClassService;
import com.spring.finall.service.TeacherMemberService;
import com.spring.finall.user.OneDayClassVO;

@Controller
@RequestMapping("/api/teacher")
public class TeacherController {

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
		if (yearMonth == null){

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
		list = manageOnedayClassService.getMyActiveOnedayclassList(teacher_id,yearMonth);

		redMap.put("activeMonthList", activeMonthList);
		redMap.put("list", list);

		return redMap;
	}

	
	
	@RequestMapping(value = "/update-onedayclassinfo")
	@ResponseBody
	public Map<String, Object> updateOneDayClassInfo(
	        @AuthenticationPrincipal UserTeacherDetail userTeacherDetail,
	        @RequestBody OneDayClassVO oneDayClassVO) {

	    Long teacher_id = userTeacherDetail.getTeacher_id();

	    // 1. 동적 UPDATE 컬럼 생성
	    String updateColumns = updateColumnBuilder(oneDayClassVO);

	    // 2. DB 업데이트 실행
	    int affectedRow = manageOnedayClassService.updateOneDayClassInfo(
	            teacher_id, oneDayClassVO, updateColumns);

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
