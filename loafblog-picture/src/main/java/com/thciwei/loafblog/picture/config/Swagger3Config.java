package com.thciwei.loafblog.picture.config;


import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.RequestParameterBuilder;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;


@Configuration
public class Swagger3Config {

    @Bean
    public Docket docket() {
        return new Docket(DocumentationType.OAS_30).apiInfo(
                new ApiInfoBuilder()
                        .title("面包博客Picture接口文档")
                        .description("简单优雅的Restful风格")
                        .build()
        );
    }

//    @Bean
//    public Docket api() {
//        return new Docket(DocumentationType.OAS_30)
//                //资源
//                .globalResponses(HttpMethod.GET, new ArrayList<>())
//                .globalResponses(HttpMethod.PUT, new ArrayList<>())
//                .globalResponses(HttpMethod.POST, new ArrayList<>())
//                .globalResponses(HttpMethod.DELETE, new ArrayList<>())
//                //是否启动
//                .enable(true)
//                //头部信息
//                .apiInfo(apiInfo())
//                .select()
//
//                .apis(RequestHandlerSelectors.any())
//                //过滤某个路径
//                .paths(PathSelectors.any())
//                .build()
//                //协议
//                .protocols(newHashSet("https", "http"))
//                .securitySchemes(securitySchemes())
//                .securityContexts(securityContexts());
//    }
//
//
//    /**
//     * API 页面上半部分展示信息
//     */
//    private ApiInfo apiInfo() {
//        return new ApiInfoBuilder()
//                .title("面包博客Picture接口文档")
//                .description("简单优雅的restful风格")
//                .version("1.0")
//                .build();
//    }
//
//    /**
//     * 设置接口单独的授权信息
//     */
//    private List<SecurityScheme> securitySchemes() {
//        return Collections.singletonList(new ApiKey("BASE_TOKEN", "token", "header"));
//    }
//
//    /**
//     * 授权信息全局应用
//     */
//    private List<SecurityContext> securityContexts() {
//        return Collections.singletonList(
//                SecurityContext.builder()
//                        .securityReferences(
//                                Collections.singletonList(new SecurityReference("BASE_TOKEN",
//                                        new AuthorizationScope[]{new AuthorizationScope("global", "")}
//                                )))
//                        //.forPaths(PathSelectors.any())
//                        .build()
//        );
//    }
//
//    @SafeVarargs
//    private final <T> Set<T> newHashSet(T... ts) {
//        if (ts.length > 0) {
//            return new LinkedHashSet<>(Arrays.asList(ts));
//        }
//        return null;
//    }
}
