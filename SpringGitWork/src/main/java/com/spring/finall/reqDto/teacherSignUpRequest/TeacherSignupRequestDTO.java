package com.spring.finall.reqDto.teacherSignUpRequest;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.web.bind.annotation.RequestParam;

public class TeacherSignupRequestDTO {


	
	
    @NotBlank(message = "아이디를 입력해주세요")
    private String id;

    @NotBlank(message = "비밀번호를 입력해주세요")
    @Pattern(regexp = "^(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,16}$", message="비밀번호 조건 불일치")
    private String password;

    @NotBlank(message = "회사명을 입력해주세요")
    private String company_name;

    @NotBlank(message = "사업자등록번호를 입력해주세요")
    private String registration_number;

    @NotBlank(message = "대표자명을 입력해주세요")
    private String representative_name;

    @NotBlank(message = "전화번호를 입력해주세요")
    private String company_phone;

    @NotBlank(message = "주소를 입력해주세요")
    private String address;

    @NotBlank(message = "이메일을 입력해주세요")
    @Email(message = "올바른 이메일 형식이어야 합니다")
    private String email;

    // Getter / Setter
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCompany_name() {
        return company_name;
    }

    public void setCompany_name(String company_name) {
        this.company_name = company_name;
    }

    public String getRegistration_number() {
        return registration_number;
    }

    public void setRegistration_number(String registration_number) {
        this.registration_number = registration_number;
    }

    public String getRepresentative_name() {
        return representative_name;
    }

    public void setRepresentative_name(String representative_name) {
        this.representative_name = representative_name;
    }

    public String getCompany_phone() {
        return company_phone;
    }

    public void setCompany_phone(String company_phone) {
        this.company_phone = company_phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    
    
    
    
}