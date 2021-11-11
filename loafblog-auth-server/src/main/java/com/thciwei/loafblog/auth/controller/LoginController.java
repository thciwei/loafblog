package com.thciwei.loafblog.auth.controller;

import com.alibaba.fastjson.TypeReference;
import com.thciwei.common.constant.AuthServerConstant;
import com.thciwei.common.exception.BizCodeEnum;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.auth.feign.BlogFeignService;
import com.thciwei.loafblog.auth.feign.ThirdPartyFeignService;
import com.thciwei.loafblog.auth.vo.UserLoginVo;
import com.thciwei.loafblog.auth.vo.UserRegistVo;
import io.swagger.annotations.Api;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
@Api(value = "用户登录")
@Controller
@RequestMapping("auth")
public class LoginController {

    @Autowired
    ThirdPartyFeignService thirdPartyFeignService;
    @Autowired
    StringRedisTemplate redisTemplate;
    @Autowired
    BlogFeignService blogFeignService;

    @ResponseBody
    @GetMapping("/sendcode")
    public R sendCode(@RequestParam("phone") String phone) {
        //1、接口防刷
        String redisCode = redisTemplate.opsForValue().get(AuthServerConstant.SMS_CODE_CACHE_PREFIX + phone);
        //由于第一次redis中没有数据，所以判空防止空指针
        if (!StringUtils.isEmpty(redisCode)) {
            //发送第一次验证码的系统时间
            long sysOldTime = Long.parseLong(redisCode.split("_")[1]);

            if (System.currentTimeMillis() - sysOldTime < 60000) {
                //60s内不能再发送
                return R.error(BizCodeEnum.SMS_CODE_EXCEPTION.getCode(), BizCodeEnum.SMS_CODE_EXCEPTION.getMsg());

            }
        }


        //2、注册时验证码再次校验 暂时存入redis key-phone value-code sms:code:15032289043 ->45672
        String code = UUID.randomUUID().toString().substring(0, 5);
        String codeNum = code + "_" + System.currentTimeMillis();
        //redis缓存验证码缓存时间   、 防止同一个phone在60s内再发送验证码(给验证码一个系统时间)
        redisTemplate.opsForValue().set(AuthServerConstant.SMS_CODE_CACHE_PREFIX + phone, codeNum, 10, TimeUnit.MINUTES);

        thirdPartyFeignService.sendCode(phone, code);
        return R.ok();
    }


    @ResponseBody
    @PostMapping("/regist")
    public R regist(@Valid @RequestBody UserRegistVo vo, BindingResult result,
                    RedirectAttributes redirectAttributes, HttpSession httpSession) {

        if (result.hasErrors()) {
            Map<String, String> errors = result.getFieldErrors().stream()
                    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));

            return R.error().put("errors", errors);
        }

        String code = vo.getCode();
        String s = redisTemplate.opsForValue().get(AuthServerConstant.SMS_CODE_CACHE_PREFIX + vo.getPhone());
        //真正注册逻辑
        //检查redis是否有验证码kv
        if (!StringUtils.isEmpty(s)) {

            //比较code与redis中是否相等
            if (code.equals(s.split("_")[0])) {

                //删掉key-v
                redisTemplate.delete(AuthServerConstant.SMS_CODE_CACHE_PREFIX + vo.getPhone());


                R r = blogFeignService.regist(vo);
                if (r.getCode() == 0) {
                    return R.ok("注册成功");

                } else {
                    HashMap<String, String> errors = new HashMap<>();
                    errors.put("msg", r.getData("msg", new TypeReference<String>() {
                    }));
                    return R.error().put("errors", errors);

                }


            } else {
                HashMap<String, String> errors = new HashMap<>();
                errors.put("code", "验证码错误");
                return R.error().put("errors", errors);
            }
        } else {
            HashMap<String, String> errors = new HashMap<>();
            errors.put("code", "验证码错误");
            return R.error().put("errors", errors);
        }


    }

    @ResponseBody
    @PostMapping("/login")
    public R login(@RequestBody UserLoginVo vo) {
        R r = blogFeignService.login(vo);
        if(r.getCode()==0){
            return R.ok("登陆成功");
        }else {
            HashMap<String, String> errors = new HashMap<>();
            errors.put("msg",r.getData("msg",new TypeReference<String>(){}));
            return R.error().put("errors",errors);
        }
    }


}
