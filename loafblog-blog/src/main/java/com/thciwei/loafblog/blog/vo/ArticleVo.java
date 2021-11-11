package com.thciwei.loafblog.blog.vo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class ArticleVo implements Serializable {
    /**
     * 博客id
     */
    @TableId
    private Integer id;
    /**
     * 标题
     */
    private String title;

    /**
     * md格式内容
     */
    private String mdcontent;
    /**
     * html格式内容
     */
    private String htmlcontent;
    /**
     * 梗概
     */
    private String summary;
    /**
     * 博客封面
     */
    private String image;
    /**
     * 发布时间
     */
    @JsonFormat(timezone = "GMT+8")
    private Date publishdate;
    /**
     * 是否原创【0-否,1-是】
     */
    private Boolean isoriginal;
    /**
     * 是否评论【0-否,1-是】
     */
    private Boolean iscomment;
    /**
     * 文章字数
     */
    private Integer number;
    /**
     * 状态【0-存在,1-已删除】
     */
    private Integer state;

    private String cateName;

    private String tagName;


}
