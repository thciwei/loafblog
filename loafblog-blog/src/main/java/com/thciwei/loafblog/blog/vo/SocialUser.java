package com.thciwei.loafblog.blog.vo;

import lombok.Data;

@Data
public class SocialUser {
    private String access_token;
    private String remind_in;
    private String expires_in;
    private String uid;
    private String isRealName;
}
