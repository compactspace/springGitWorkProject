package com.spring.finall.view.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeViewController {

    @GetMapping("/")
    public String showMainHome(HttpServletResponse response) {
    	  response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    	    response.setHeader("Pragma", "no-cache");
    	    response.setHeader("Expires", "0");
        return "mainPage/mainhome";
    }
}