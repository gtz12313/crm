package com.gtz.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

/**
 * @author 葛天助
 * @version 1.0
 */

@Configuration
@EnableWebMvc
@ComponentScan({"com.gtz.controller", "com.gtz.config"})
public class SpringMvcConfig {

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        //上传文件最大值 (bit)
        multipartResolver.setMaxUploadSize(1024 * 1024 * 5);
        multipartResolver.setDefaultEncoding("utf-8");
        return multipartResolver;
    }
}
