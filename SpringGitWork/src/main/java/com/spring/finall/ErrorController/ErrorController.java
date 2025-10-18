package com.spring.finall.ErrorController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/err")
public class ErrorController {

    @GetMapping("/notfound")
    public String notFound() {
        return "notfoundPage/notfound"; 
    }
}