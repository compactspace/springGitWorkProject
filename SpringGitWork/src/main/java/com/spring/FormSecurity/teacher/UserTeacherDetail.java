package com.spring.FormSecurity.teacher;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.spring.finall.user.OneDayClassVO;

public class UserTeacherDetail implements UserDetails {

	// 주의 해라 이건 teacher테이블의 로그인시 입력하는 아이디 컬럼의미
    private String username;
    private String password;
    private boolean enabled;
    private boolean approved; // 클래스 등록 승인 여부
    private Long teacher_id;
    
    
    
    // 이건 로그인시 수업을 등록한 선생인지 여부
    
    private OneDayClassVO myOneDayClassInfo;
    
    //이건 로그인시 현재 개강중인 달 리스트를의미
    private List<Map<String,Object>> activeMonthList=null;
    
    
    
    public UserTeacherDetail(String username, String password, boolean enabled, boolean approved) {
        this.username = username;
        this.password = password;
        this.enabled = enabled;
        this.approved = approved;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_TEACHER"));
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        // 로그인 허용 여부만 체크
        return enabled;
    }

    // 원데이 클래스 개설 여부 판단
    public boolean isApproved() {
        return approved;
    }

    
	public Long getTeacher_id() {
		return teacher_id;
	}

	public void setTeacher_id(Long teacher_id) {
		this.teacher_id = teacher_id;
	}

	public List<Map<String, Object>> getActiveMonthList() {
		return activeMonthList;
	}

	public void setActiveMonthList(List<Map<String, Object>> activeMonthList) {
		this.activeMonthList = activeMonthList;
	}

	public OneDayClassVO getMyOneDayClassInfo() {
		return myOneDayClassInfo;
	}

	public void setMyOneDayClassInfo(OneDayClassVO myOneDayClassInfo) {
		this.myOneDayClassInfo = myOneDayClassInfo;
	}
    
    
    
    
}
