package com.thciwei.loafblog.auth.feign;

import com.thciwei.common.utils.R;
import com.thciwei.loafblog.auth.vo.SocialUser;
import com.thciwei.loafblog.auth.vo.UserLoginVo;
import com.thciwei.loafblog.auth.vo.UserRegistVo;
import feign.Param;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient("loafblog-blog")
public interface BlogFeignService {

    @PostMapping("/blog/userauth/regist")
    public R regist(@RequestBody UserRegistVo vo) ;

    @PostMapping("/blog/userauth/login")
    public R login(@RequestBody UserLoginVo vo) ;

    @PostMapping("/blog/userauth/oauth2/login")
    public R oauthlogin(@RequestBody SocialUser socialUser, @RequestParam("token") String token ) throws Exception ;
}
