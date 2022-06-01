package com.thciwei.loafblog.blog;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.server.ConfigurableWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.scheduling.annotation.EnableScheduling;
import springfox.documentation.oas.annotations.EnableOpenApi;


//@EnableSwagger2
@EnableOpenApi
@EnableScheduling
@EnableFeignClients(basePackages = "com.thciwei.loafblog.blog.feign")
@EnableDiscoveryClient
@SpringBootApplication
public class LoafblogBlogApplication {

    public static void main(String[] args) {
        SpringApplication.run(LoafblogBlogApplication.class, args);
    }


}
