package com.gtz.config;

import com.gtz.controller.interceptor.LoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

/**
 * @author 葛天助
 * @version 1.0
 */

@Configuration
public class SpringMvcSupport extends WebMvcConfigurationSupport {
    @Autowired
    private LoginInterceptor loginInterceptor;

    @Override
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/image/**").addResourceLocations("/image/");
        registry.addResourceHandler("/jquery/**").addResourceLocations("/jquery/");
    }


    @Override
    protected void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor).addPathPatterns
                ("/settings/**","/workbench/**").
                excludePathPatterns("/settings/qx/user/login","/settings/qx/user/toLogin");
    }
}
