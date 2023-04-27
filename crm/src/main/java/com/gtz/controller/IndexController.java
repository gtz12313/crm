package com.gtz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 葛天助
 * @version 1.0
 */

@Controller
public class IndexController {

    @RequestMapping("/")
    public String index(){

        return "index";
    }

    @RequestMapping("/crm/login")
    public String login(){

        return "forward:/WEB-INF/settings/qx/user/login.jsp";
    }
}
