package com.thciwei.common.vo;

import lombok.Data;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

@ToString
@Data
public class MemberRespVo implements Serializable {
    /**
     * 因为 SpringSession，把数据存入 redis需要转为二进制流，所以需要序列化
     */
    private Integer id;
    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 昵称
     */
    private String nickname;
    /**
     * 手机号码
     */
    private String mobile;
    /**
     * 头像
     */
    private String header;
    /**
     * 性别【1-男0-女】
     */
    private Integer gender;
    /**
     * 生日
     */
    private Date birthday;
    /**
     * 城市
     */
    private String city;
    /**
     * 邮箱
     */
    private String email;
    /**
     * 个性签名
     */
    private String sign;
    /**
     * 用户来源
     */
    private Integer sourceType;
    /**
     * 启用状态【0-存在1-不存在】
     */
    private Integer state;
    /**
     * 注册时间
     */
    private Date createTime;
    /**
     * 社交账号ID
     */
    private String socialUid;
    /**
     * 社交账号Token
     */
    private String accessToken;
    /**
     * 社交账号Token过期时间
     */
    private String expiresIn;

}
