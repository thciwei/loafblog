package com.thciwei.common.exception;

public enum BizCodeEnum {
    VAILD_EXCEPTION(10001, "参数格式检验失败"),
    UNKNOW_EXCEPTION(10000, "系统未知异常"),
    ARTICLE_ADD_EXCEPTION(11000,"文章添加异常"),
    SMS_CODE_EXCEPTION(10002, "验证码获取频率太高,请稍后再试"),
    USER_EXIST_EXCEPTION(15001,"用户已经存在"),
    PHONE_EXIST_EXCEPTION(15002,"手机号已经存在"),
    LOGINACCT_PASSWORD_EXCEPTION(15003,"账号密码错误");

    private int code;
    private String msg;

    BizCodeEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

}
