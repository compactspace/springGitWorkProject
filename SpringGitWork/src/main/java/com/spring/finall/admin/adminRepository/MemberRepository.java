package com.spring.finall.admin.adminRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.finall.admin.admindomain.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

}
