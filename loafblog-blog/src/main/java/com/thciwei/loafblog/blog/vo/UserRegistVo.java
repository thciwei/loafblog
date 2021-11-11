package com.thciwei.loafblog.blog.vo;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

@Data
public class UserRegistVo {
    @NotEmpty(message = "用户名必须提交")
    @Length(min = 3, max = 18, message = "用户名必须是3-18位字符")
    private String username;
    @NotEmpty(message = "密码必须填写")
    @Length(min = 6, max = 18, message = "密码必须是6-18位字符")
    private String password;
    @NotEmpty(message = "验证码必须填写")
    private String code;

    @Pattern(regexp = "^[1]([3-9])[0-9]{9}$", message = "手机格式不正确")
    @NotEmpty(message = "手机号格式不正确")
    private String phone;
}
