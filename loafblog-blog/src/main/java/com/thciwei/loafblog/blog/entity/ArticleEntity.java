package com.thciwei.loafblog.blog.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 * 博客内容和属性
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@Data
@TableName("article")
public class ArticleEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	//TODO 1、JSR303后端校验
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
	 * 标签id
	 */

	private Integer tid;
	/**
	 * 分类id
	 */

	private Integer cid;
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
	@TableLogic
	private Integer state;



}
