package com.thciwei.loafblog.blog.exception;

public class PhoneExistException extends RuntimeException {
    public PhoneExistException() {
        super("手机号已存在");
    }

}
