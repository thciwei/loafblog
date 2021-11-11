package com.thciwei.loafblog.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
@TableName("mail_send_log")
public class MailSendLogEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId
    private String msgId;
    /**
     *
     */
    private Integer websiteId;
    /**
     * 0发送中，1发送成功，2发送失败
     */
    private Integer status;
    /**
     * 绑定key
     */
    private String routeKey;
    /**
     * 交换机
     */
    private String exchange;
    /**
     * 重试次数
     */
    private Integer count;
    /**
     * 第一次重试时间
     */
    private Date tryTime;
    /**
     *
     */
    private Date createTime;
    /**
     *
     */
    private Date updateTime;
}
