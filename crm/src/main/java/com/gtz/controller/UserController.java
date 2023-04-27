package com.gtz.controller;

import com.gtz.commons.contants.Code;
import com.gtz.commons.domain.Result;
import com.gtz.commons.utils.DateUtils;
import com.gtz.domain.User;
import com.gtz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 葛天助
 * @version 1.0
 */

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/settings/qx/user/toLogin")
    public String toLogin() {
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login")
    @ResponseBody
    public Result login(String loginAct, String pwd, String isRemPwd, HttpServletResponse resp, HttpServletRequest req, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("pwd", pwd);
        User user = userService.queryUserByNameAndPwd(map);
        Result result = new Result();
        if (user == null) {
            //登录失败,用户名或密码错误
            System.out.println("UserController.user");
            result.setCode(Code.RETURN_CODE_ERR);
            result.setMsg("用户名或密码错误");
            return result;
        }

        if (DateUtils.formateDateTime(new Date()).compareTo(user.getExpireTime()) > 0){
            //登录失败,账号已过期
            System.out.println("UserController.------");
            result.setCode(Code.RETURN_CODE_ERR);
            result.setMsg("账号已过期");
            return result;
        }

        if ("0".equals(user.getLockState())){
            //登录失败,状态被锁定
            System.out.println("UserController.status");
            result.setCode(Code.RETURN_CODE_ERR);
            result.setMsg("状态被锁定");
            return result;
        }
        if (!user.getAllowIps().contains(req.getRemoteAddr())){
            //登录失败,ip受限
            result.setCode(Code.RETURN_CODE_ERR);
            result.setMsg("ip受限");
            return result;
        }
        result.setCode(Code.RETURN_CODE_OK);
        user.setLoginPwd(pwd);
        result.setData(user);
        if (session.getAttribute(Code.SESSION_USER) == null){
            session.setAttribute(Code.SESSION_USER,user);
        }
        System.out.println("isRemPwd = " + isRemPwd);
        if ("true".equals(isRemPwd)){
            Cookie loginAct1 = new Cookie("loginAct", user.getLoginAct());
            loginAct1.setMaxAge(10 * 24 * 60 * 60);
            resp.addCookie(loginAct1);
            Cookie pwd1 = new Cookie("loginPwd", user.getLoginPwd());
            pwd1.setMaxAge(10 * 24 * 60 * 60);
            resp.addCookie(pwd1);
        }else{
            Cookie cookie = new Cookie("loginAct", "");
            cookie.setMaxAge(0);
            Cookie loginPwd = new Cookie("loginPwd", "");
            loginPwd.setMaxAge(0);
            resp.addCookie(cookie);
            resp.addCookie(loginPwd);
        }
        return result;
    }

    @RequestMapping("/settings/qx/user/off")
    public String off(HttpServletResponse resp,HttpSession session){
        //销毁session
        session.invalidate();
        Cookie loginAct = new Cookie("loginAct", "");
        loginAct.setMaxAge(0);
        Cookie loginPwd = new Cookie("loginPwd", "");
        loginPwd.setMaxAge(0);
        resp.addCookie(loginAct);
        resp.addCookie(loginPwd);

        return "redirect:/";
    }
}
