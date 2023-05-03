package com.thciwei.loafblog.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-16 19:05:42
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
@TableName("websiteInfo")
public class WebsiteinfoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId
    private Integer id;
    /**
     * 友链名称
     */
    private String name;
    /**
     * 友链path
     */
    private String link;
    /**
     * 站点描述
     */
    private String descp;
    /**
     * 友站邮箱
     */
    private String mail;

}
