package com.thciwei.loafblog.blog.dao;

import com.thciwei.loafblog.blog.entity.ArticleCategoryEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 博客所在的分类
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@Mapper
public interface ArticleCategoryDao extends BaseMapper<ArticleCategoryEntity> {
	
}
