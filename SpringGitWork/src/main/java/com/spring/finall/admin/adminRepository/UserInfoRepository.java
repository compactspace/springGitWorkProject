package com.spring.finall.admin.adminRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.finall.admin.admindomain.UserEntity;

public interface UserInfoRepository extends JpaRepository<UserEntity,Long> {

}
