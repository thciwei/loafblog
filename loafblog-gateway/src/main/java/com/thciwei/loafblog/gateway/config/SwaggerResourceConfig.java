package com.thciwei.loafblog.gateway.config;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.config.GatewayProperties;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.support.NameUtils;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.swagger.web.SwaggerResource;
import springfox.documentation.swagger.web.SwaggerResourcesProvider;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Primary
@Component
@Slf4j
@AllArgsConstructor
public class SwaggerResourceConfig implements SwaggerResourcesProvider {
//    /**
//     * RouteLocator，GatewayProperties这两个类都是springcloud提供的springbean对象直接注入即可
//     */
//    private final RouteLocator routeLocator;
//    //gateway配置文件
//    private final GatewayProperties gatewayProperties;
//
//
//    @Override
//    public List<SwaggerResource> get() {
//        List<SwaggerResource> resources = new ArrayList<>();
//        List<String> routes = new ArrayList<>();
//        routeLocator.getRoutes().subscribe(route -> routes.add(route.getId()));
//        //从配置文件中获取并配置SwaggerResource
//        gatewayProperties.getRoutes().stream()
//                //过滤路由
//                .filter(routeDefinition -> routes.contains(routeDefinition.getId()))
//                //循环添加，从路由的断言中获取，一般来说路由都会配置断言Path信息，这就不多说了
//                .forEach(route -> {
//                    route.getPredicates().stream()
//                            //获取Path信息
//                            .filter(predicateDefinition -> ("Path").equalsIgnoreCase(predicateDefinition.getName()))
//                            //开始添加SwaggerResource
//                            .forEach(predicateDefinition -> resources.add(swaggerResource(route.getId(),
//                                    predicateDefinition.getArgs().get(NameUtils.GENERATED_NAME_PREFIX + "0")
//                                            .replace("**", "v2/api-docs" ))));
//                });
//
//        return resources;
//    }
//
//    private SwaggerResource swaggerResource(String name, String location) {
//        SwaggerResource swaggerResource = new SwaggerResource();
//        swaggerResource.setName(name);
//        swaggerResource.setLocation(location);
//        swaggerResource.setSwaggerVersion(DocumentationType.OAS_30.getVersion());
//        return swaggerResource;
//    }
//
//    @Autowired
//    public SwaggerResourceConfig(RouteLocator routeLocator, GatewayProperties gatewayProperties) {
//        this.routeLocator = routeLocator;
//        this.gatewayProperties = gatewayProperties;
//    }

    public static final String API_URI = "v2/api-docs";

    private final RouteLocator routeLocator;

    private final GatewayProperties gatewayProperties;

    @Override
    public List<SwaggerResource> get() {
        List<SwaggerResource> resources = new ArrayList<>();
        List<String> routes = new ArrayList<>();
        routeLocator.getRoutes().subscribe(route -> routes.add(route.getId()));
        gatewayProperties.getRoutes().stream().filter(routeDefinition -> routes.contains(routeDefinition.getId())).forEach(route -> {
            route.getPredicates().stream()
                    .filter(predicateDefinition -> ("Path").equalsIgnoreCase(predicateDefinition.getName()))
                    .forEach(predicateDefinition -> resources.add(swaggerResource(route.getId(),
                            predicateDefinition.getArgs().get(NameUtils.GENERATED_NAME_PREFIX + "0")
                                    .replace("**", API_URI))));
        });
        return resources;
    }

    private SwaggerResource swaggerResource(String name, String location) {
        log.info("name:{},location:{}", name, location);
        SwaggerResource swaggerResource = new SwaggerResource();
        swaggerResource.setName(name);
        swaggerResource.setLocation(location);
        swaggerResource.setSwaggerVersion("3.0");
        return swaggerResource;
    }
}
