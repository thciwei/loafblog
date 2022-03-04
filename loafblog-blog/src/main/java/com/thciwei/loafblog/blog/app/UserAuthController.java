package com.thciwei.loafblog.blog.app;


import com.thciwei.common.exception.BizCodeEnum;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.blog.entity.UserAuthEntity;
import com.thciwei.loafblog.blog.exception.PhoneExistException;
import com.thciwei.loafblog.blog.exception.UserExistException;
import com.thciwei.loafblog.blog.service.UserAuthService;
import com.thciwei.loafblog.blog.vo.SocialUser;
import com.thciwei.loafblog.blog.vo.UserLoginVo;
import com.thciwei.loafblog.blog.vo.UserRegistVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

/**
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-10-05 17:10:35
 */
@RestController
@RequestMapping("blog/userauth")
public class UserAuthController {
    @Autowired
    private UserAuthService userAuthService;


    /**
     * 微博登录注册合并
     * @param socialUser
     * @return
     * @throws Exception
     */
    @PostMapping("/oauth2/login")
    public R oauthlogin(@RequestBody SocialUser socialUser,@RequestParam("token") String token ) throws Exception {
        UserAuthEntity entity = userAuthService.login(socialUser, token);
        if (entity != null) {
            return R.ok().setData(entity);
        } else {
            return R.error(BizCodeEnum.LOGINACCT_PASSWORD_EXCEPTION.getCode(), BizCodeEnum.LOGINACCT_PASSWORD_EXCEPTION.getMsg());
        }
    }

    @PostMapping("/login")
    public R login(@RequestBody UserLoginVo vo) {
        UserAuthEntity entity = userAuthService.login(vo);
        if (entity != null) {
            return R.ok();
        } else {
            return R.error(BizCodeEnum.LOGINACCT_PASSWORD_EXCEPTION.getCode(), BizCodeEnum.LOGINACCT_PASSWORD_EXCEPTION.getMsg());
        }

    }

    /**
     * 小程序登录测试
     * @param vo
     * @return
     */
    @PostMapping("/unilogin")
    public R unilogin(@RequestBody UserLoginVo vo) {
        // TODO 小程序端登录
        String token = userAuthService.uniLogin(vo);
        if (token != null) {
            return R.ok().put("token",token);
        } else {
            return R.error(BizCodeEnum.LOGINACCT_PASSWORD_EXCEPTION.getCode(), BizCodeEnum.LOGINACCT_PASSWORD_EXCEPTION.getMsg());
        }

    }

    /**
     * 注册账号
     *
     * @param vo
     * @return
     */
    @PostMapping("/regist")
    public R regist(@RequestBody UserRegistVo vo) {
        try {
            userAuthService.regist(vo);
        } catch (PhoneExistException e) {
            return R.error(BizCodeEnum.PHONE_EXIST_EXCEPTION.getCode(), BizCodeEnum.PHONE_EXIST_EXCEPTION.getMsg());
        } catch (UserExistException e) {
            return R.error(BizCodeEnum.USER_EXIST_EXCEPTION.getCode(), BizCodeEnum.USER_EXIST_EXCEPTION.getMsg());
        }

        return R.ok();

    }


    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = userAuthService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id) {
        UserAuthEntity userAuth = userAuthService.getById(id);

        return R.ok().put("userAuth", userAuth);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody UserAuthEntity userAuth) {
        userAuthService.save(userAuth);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody UserAuthEntity userAuth) {
        userAuthService.updateById(userAuth);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids) {
        userAuthService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}

