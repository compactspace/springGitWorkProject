package com.spring.finall.reqDto.orderRequest;

public class OrderPersonDTO {
    private String name;
    private String email;
    private String phone;

    // ⭐ 새로 추가
    private String zipcode;
    private String address;
    private String address_detail;

    // 기존 getter/setter
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    // ⭐ 새로 추가 getter/setter
    public String getZipcode() { return zipcode; }
    public void setZipcode(String zipcode) { this.zipcode = zipcode; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getAddress_detail() { return address_detail; }
    public void setAddress_detail(String address_detail) { this.address_detail = address_detail; }
}
