package com.thciwei.loafblog.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName("info")
public class InfoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId
    private Integer id;
    /**
     * 邮箱
     */
    private String mail;
    /**
     * 内容
     */
    private String content;
    /**
     * 是否读消息【0-未读1-已读】
     */
    private Boolean isview;


}
