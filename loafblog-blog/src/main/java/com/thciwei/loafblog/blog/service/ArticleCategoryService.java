package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.ArticleCategoryEntity;

import java.util.Map;

/**
 * 博客所在的分类
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
public interface ArticleCategoryService extends IService<ArticleCategoryEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

