package com.spring.finall.security;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;



@Service("userDetailsServiceImpl2") // 빈 이름 명확히!
public class UserDetailsServiceImpl2 implements UserDetailsService {

    @Autowired
    private SqlSessionTemplate mybatis;

    @Override
    public UserDetails loadUserByUsername(String user_id) {
        List<UserDetailsVO2> result = mybatis.selectList("UserVO.userSecuritylogin", user_id);
        if (result == null || result.isEmpty()) {
            throw new UsernameNotFoundException("❌ 사용자 정보 없음: " + user_id);
        }

        UserDetailsVO2 user = result.get(0);
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(user.getUser_role()));
        user.setAuthorities(authorities);

        return user;
    }

}
