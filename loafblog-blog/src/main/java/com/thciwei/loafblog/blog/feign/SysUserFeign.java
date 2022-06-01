package com.thciwei.loafblog.blog.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;



@FeignClient("loafblog-picture")
public interface SysUserFeign {
    @GetMapping("picture/sysuser/userNumber")
    public Integer getUserNumber();

}
