package com.spring.finall.security;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserDetailsVO2 implements UserDetails, Serializable {
	private static final long serialVersionUID = 1L;
    private int user_code;  
    private String user_where;
    private String id; // username
    private String password;
    private String user_tell;
    private String user_name;
    private long userEntity_user_code;
    private Timestamp create_signup;
    private String email;
    private String user_role;

    // 권한 리스트
   
    private List<GrantedAuthority> authorities = new ArrayList<>();
    public UserDetailsVO2() {}

    public UserDetailsVO2(String id, String password, List<GrantedAuthority> authorities) {
        this.id = id;
        this.password = password;
        this.authorities = authorities;
    }
    public UserDetailsVO2(String id, String password, String user_role, String user_name, String email, List<GrantedAuthority> authorities) {
        this.id = id;
        this.password = password;
        this.user_role = user_role;
        this.user_name = user_name;
        this.email = email;
        this.authorities = authorities;
    }
    public UserDetailsVO2(
    	    int user_code,
    	    String user_where,
    	    String id,
    	    String password,
    	    String user_tell,
    	    String user_name,
    	    long userEntity_user_code,
    	    Timestamp create_signup,
    	    String email,
    	    String user_role,
    	    List<GrantedAuthority> authorities
    	) {
    	    this.user_code = user_code;
    	    this.user_where = user_where;
    	    this.id = id;
    	    this.password = password;
    	    this.user_tell = user_tell;
    	    this.user_name = user_name;
    	    this.userEntity_user_code = userEntity_user_code;
    	    this.create_signup = create_signup;
    	    this.email = email;
    	    this.user_role = user_role;
    	    this.authorities = authorities;
    	}


    // ✅ UserDetails 필수 메서드 구현
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return id; // ID 컬럼을 username 으로 사용
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
        return true;
    }

    // ✅ Getter/Setter 추가 (필요한 항목만 사용 가능)

    public int getUser_code() {
        return user_code;
    }

    public void setUser_code(int user_code) {
        this.user_code = user_code;
    }

    public String getUser_where() {
        return user_where;
    }

    public void setUser_where(String user_where) {
        this.user_where = user_where;
    }

    public String getUser_tell() {
        return user_tell;
    }

    public void setUser_tell(String user_tell) {
        this.user_tell = user_tell;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public long getUserEntity_user_code() {
        return userEntity_user_code;
    }

    public void setUserEntity_user_code(long userEntity_user_code) {
        this.userEntity_user_code = userEntity_user_code;
    }

    public Timestamp getCreate_signup() {
        return create_signup;
    }

    public void setCreate_signup(Timestamp create_signup) {
        this.create_signup = create_signup;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUser_role() {
        return user_role;
    }

    public void setUser_role(String user_role) {
        this.user_role = user_role;
    }

    public void setAuthorities(List<GrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    

    public void setPassword(String password) {
        this.password = password;
    }
    
    @Override
    public String toString() {
        return "UserDetailsVO2{" +
               "id='" + id + '\'' +
               ", password='" + password + '\'' +
               ", user_role='" + user_role + '\'' +
               ", user_name='" + user_name + '\'' +
               ", email='" + email + '\'' +
               '}';
    }

}
