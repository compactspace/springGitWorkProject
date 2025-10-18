package com.spring.finall.security;

public class CustomUserPrincipal {
    private String username;
    private String userName;
    private String email;
    private String role;

    public CustomUserPrincipal(String username, String userName, String email, String role) {
        this.username = username;
        this.userName = userName;
        this.email = email;
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public String getUserName() {
        return userName;
    }

    public String getEmail() {
        return email;
    }

    public String getRole() {
        return role;
    }

    @Override
    public String toString() {
        return "CustomUserPrincipal{" +
                "username='" + username + '\'' +
                ", userName='" + userName + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}