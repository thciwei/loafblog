package com.thciwei.loafblog.auth.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.thciwei.common.utils.HttpUtils;
import com.thciwei.common.utils.JwtUtil;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.auth.cache.AuthStateRedisCache;
import com.thciwei.loafblog.auth.feign.BlogFeignService;
import com.thciwei.common.vo.MemberRespVo;
import com.thciwei.loafblog.auth.vo.SocialUser;
import com.xkcoding.http.config.HttpConfig;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;


import me.zhyd.oauth.config.AuthConfig;
import me.zhyd.oauth.enums.scope.*;
import me.zhyd.oauth.exception.AuthException;
import me.zhyd.oauth.model.AuthCallback;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.model.AuthToken;
import me.zhyd.oauth.model.AuthUser;
import me.zhyd.oauth.request.*;
import me.zhyd.oauth.utils.AuthScopeUtils;
import me.zhyd.oauth.utils.AuthStateUtils;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import java.util.Arrays;


@Slf4j
@Api(value = "第三方登录", tags = {"用户操作接口"})
@RestController
@RequestMapping("auth")
public class RestAuthController {
    @Autowired
    BlogFeignService blogFeignService;

    @Autowired
    AuthStateRedisCache stateRedisCache;


    /**
     *
     */
    @RequestMapping(value = "/render/{source}")
    @ResponseBody
    public R renderAuth(@PathVariable("source") String source, HttpServletResponse response) throws IOException {
        log.info("进入render：" + source);
        AuthRequest authRequest = getAuthRequest(source);
        String authorizeUrl = authRequest.authorize(AuthStateUtils.createState());
        log.info(authorizeUrl);
        //response.sendRedirect(authorizeUrl);
        return R.ok().put("url", authorizeUrl);
    }

    /**
     * oauth平台中配置的授权回调地址，以本项目为例，在创建github授权应用时的回调地址应为：http://127.0.0.1:8443/oauth/callback/github
     */
    @RequestMapping("/{source}/success")
    public R login(@PathVariable("source") String source, AuthCallback callback, HttpServletRequest request, HttpServletResponse servletResponse, HttpSession session) throws Exception {

        log.info("进入callback：" + source + " callback params：" + JSONObject.toJSONString(callback));
        AuthRequest authRequest = getAuthRequest(source);
        AuthResponse<AuthUser> response = authRequest.login(callback);
        log.info("JSONObject:{}", JSONObject.toJSONString(response.getData()));
        AuthUser data = response.getData();
        String token = JwtUtil.createToken(data.getUsername(), data.getAvatar(), data.getUuid());
        log.info("token为:{}", token);
        SocialUser socialUser = new SocialUser();
        socialUser.setUid(data.getUuid());
        socialUser.setAccess_token(data.getToken().getAccessToken());
        socialUser.setExpires_in(data.getToken().getExpireIn());
        R r = blogFeignService.oauthlogin(socialUser, token);
        if (r.getCode() == 0) {
            servletResponse.sendRedirect("http://loafblog.com" + "?accessToken=" + token);
            return R.ok();
        } else {
            return R.error();
        }


    }

    @GetMapping("/{token}")
    public R getOauthUserInfo(@PathVariable("token") String token) {
        R r = JwtUtil.parse(token);
        return r;
    }


    /**
     * 根据具体的授权来源，获取授权请求工具类
     *
     * @param source
     * @return
     */
    private AuthRequest getAuthRequest(String source) {
        AuthRequest authRequest = null;
        switch (source.toLowerCase()) {
            case "github":
                authRequest = new AuthGithubRequest(AuthConfig.builder()
                        .clientId("7a08e63c9ee67f3e9f2c")
                        .clientSecret("9b45256ec8e375c22e396d941e438b741590e3ac")
                        .redirectUri("http://loafblog.com/auth/github/success")
                        .scopes(AuthScopeUtils.getScopes(AuthGithubScope.values()))
                        // 针对国外平台配置代理
//                        .httpConfig(HttpConfig.builder()
//                                .timeout(15000)
//                                .proxy(new Proxy(Proxy.Type.HTTP, new InetSocketAddress("127.0.0.1", 10080)))
//                                .build())
                        .build(), stateRedisCache);
                break;
            case "gitee":
                authRequest = new AuthGiteeRequest(AuthConfig.builder()
                        .clientId("ee4e80ad0c820be2eae90d3fbfe8b6cf63a243bcff62b2b939ebaa0d0842a0b4")
                        .clientSecret("b69b6a62360073bc861ed1721166cc203d77c71f395c2eba8966a61c56e3d39b")
                        .redirectUri("http://loafblog.com/auth/gitee/success")
//                        .scopes(AuthScopeUtils.getScopes(AuthGiteeScope.values()))
                        .build(), stateRedisCache);
                break;
            case "weibo":
                authRequest = new AuthWeiboRequest(AuthConfig.builder()
                        .clientId("1571070261")
                        .clientSecret("b5404b6639bd14d2517e5834e3af0a3b")
                        .redirectUri("http://loafblog.com/auth/weibo/success")
                        .scopes(Arrays.asList(
                                AuthWeiboScope.EMAIL.getScope(),
                                AuthWeiboScope.FRIENDSHIPS_GROUPS_READ.getScope(),
                                AuthWeiboScope.STATUSES_TO_ME_READ.getScope()
                        ))
                        .build());
                break;
            case "qq":
                authRequest = new AuthQqRequest(AuthConfig.builder()
                        .clientId("")
                        .clientSecret("")
                        .redirectUri("http://localhost:8443/oauth/callback/qq")
                        .build());
                break;
            case "wechat_open":
                authRequest = new AuthWeChatOpenRequest(AuthConfig.builder()
                        .clientId("")
                        .clientSecret("")
                        .redirectUri("http://www.zhyd.me/oauth/callback/wechat")
                        .build());
                break;
            default:
                break;
        }
        if (null == authRequest) {
            throw new AuthException("未获取到有效的Auth配置");
        }
        return authRequest;
    }

//
//    @GetMapping("/weibo/success")
//    public R weibo(@RequestParam("code") String code, HttpServletResponse httpServletResponse, HttpSession session) throws Exception {
//        HashMap<String, String> header = new HashMap<>();
//        HashMap<String, String> body = new HashMap<>();
//        HashMap<String, String> map = new HashMap<>();
//        map.put("client_id", "1571070261");
//        map.put("client_secret", "b5404b6639bd14d2517e5834e3af0a3b");
//        map.put("grant_type", "authorization_code");
//        map.put("redirect_uri", "http://loafblog.com/auth/weibo/success");
//        map.put("code", code);
//        //1、根据code换取accessToken
//        HttpResponse response = HttpUtils.doPost("https://api.weibo.com", "/oauth2/access_token", "post", header, map, body);
//        //2、换取token是否成功
//        if (response.getStatusLine().getStatusCode() == 200) {
//            String json = EntityUtils.toString(response.getEntity());
//            SocialUser socialUser = JSON.parseObject(json, SocialUser.class);
//            //知道当前哪个是社交用户
//            //1）、如果用户第一次登入，那么就注册进来(为当前社交用户生成一个会员信息账号)
//            //登录或者注册这个用户
//
//            R oauthlogin = blogFeignService.oauthlogin(socialUser);
//            if (oauthlogin.getCode() == 0) {
//                MemberRespVo data = oauthlogin.getData("data", new TypeReference<MemberRespVo>() {
//                });
//                log.info("登录成功:用户:{}", data.toString());
//                session.setAttribute("loginUser",data);
//                //登录成功
//                httpServletResponse.sendRedirect("http://loafblog.com");
//
//                return R.ok().put("loginUser",data);
//            } else {
//                return R.error();
//            }
//
//
//        } else {
//            return R.error();
//        }
//
//
//    }
}