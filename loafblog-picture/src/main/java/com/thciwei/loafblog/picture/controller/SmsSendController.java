package com.thciwei.loafblog.picture.controller;

import com.thciwei.common.utils.R;
import com.thciwei.loafblog.picture.component.SmsComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/sms")
public class SmsSendController {
    @Autowired
    SmsComponent smsComponent;

    /**
     * 提供给别的服务调用
     *
     * @param phone
     * @param code
     * @return
     */
    @GetMapping("/sendCode")
    @ResponseBody
    public R sendCode(@RequestParam("phone") String phone, @RequestParam("code") String code) {
        smsComponent.sendmsg(phone, code);
        return R.ok();
    }
}
