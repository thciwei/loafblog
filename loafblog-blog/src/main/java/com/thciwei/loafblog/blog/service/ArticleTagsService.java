package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.ArticleTagsEntity;

import java.util.Map;

/**
 * 博客和标签的对应关系
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
public interface ArticleTagsService extends IService<ArticleTagsEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

