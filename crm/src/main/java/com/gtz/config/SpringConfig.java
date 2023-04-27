package com.gtz.config;

import org.springframework.context.annotation.*;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

/**
 * @author 葛天助
 * @version 1.0
 */
@ComponentScan("com.gtz.service.impl")
@PropertySource({"classpath:jdbc.properties"})
@Import({JdbcConfig.class,MybatisConfig.class})
@Configuration
@EnableTransactionManagement
public class SpringConfig {

    @Bean
    public InternalResourceViewResolver resourceViewResolver(){
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/pages/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

}
