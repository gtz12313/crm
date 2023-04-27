package com.gtz.controller.interceptor;

import com.gtz.commons.contants.Code;
import com.gtz.domain.User;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author 葛天助
 * @version 1.0
 */

@Component
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(Code.SESSION_USER);
        if (user == null){
            response.sendRedirect(request.getContextPath());
            return false;
        }
        return true;
    }
}
