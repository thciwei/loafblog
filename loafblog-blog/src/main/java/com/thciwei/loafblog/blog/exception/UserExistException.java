package com.thciwei.loafblog.blog.exception;

public class UserExistException extends RuntimeException{
    public UserExistException(){super("用户名已存在");}
}
