package com.spring.finall.ErrorController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {

    @GetMapping("/teacher-overreach")
    public String teacherOverreachPage() {
        return "error/teacherOverreachPage"; 
    }
    
    @GetMapping("/not-logged-in")
    public String notLoggedInPage() {
        return "error/notLoggedInPage"; 
    }
}