package com.gtz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 葛天助
 * @version 1.0
 */

@Controller
public class MainController {

    @RequestMapping("/workbench/main/index")
    public String index(){
        return "workbench/main/index";
    }
}
