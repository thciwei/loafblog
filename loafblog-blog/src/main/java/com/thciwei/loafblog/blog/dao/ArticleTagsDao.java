package com.thciwei.loafblog.blog.dao;

import com.thciwei.loafblog.blog.entity.ArticleTagsEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 博客和标签的对应关系
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@Mapper
public interface ArticleTagsDao extends BaseMapper<ArticleTagsEntity> {
	
}
