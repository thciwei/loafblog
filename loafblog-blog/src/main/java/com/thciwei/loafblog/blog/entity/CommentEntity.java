package com.thciwei.loafblog.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 *
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-25 13:50:49
 */
@Data
@TableName("comment")
public class CommentEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 评论内容
     */
    private String content;
    /**
     * 评论时间
     */
    @JsonFormat(timezone = "GMT+8")
    private Date createtime;
    /**
     * 评论者头像
     */
    private String fromuseravatar;
    /**
     * 评论用户id
     */
    private Integer fromuserid;
    /**
     * 评论者名字
     */
    private String fromusername;
    /**
     * 评论id
     */
    @TableId
    private Integer id;
    /**
     *
     */
    private Integer parentid;
    /**
     * 文章id
     */
    private Integer postid;
    /**
     * 被评论者头像
     */
    private String touseravatar;
    /**
     * 被评论者id
     */
    private Integer touserid;
    /**
     * 被评论者姓名
     */
    private String tousername;

}

