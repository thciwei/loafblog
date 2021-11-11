package com.thciwei.loafblog.blog.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.blog.dao.ArticleCategoryDao;
import com.thciwei.loafblog.blog.entity.ArticleCategoryEntity;
import com.thciwei.loafblog.blog.service.ArticleCategoryService;


@Service("ArticleCategoryService")
public class ArticleCategoryServiceImpl extends ServiceImpl<ArticleCategoryDao, ArticleCategoryEntity> implements ArticleCategoryService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ArticleCategoryEntity> page = this.page(
                new Query<ArticleCategoryEntity>().getPage(params),
                new QueryWrapper<ArticleCategoryEntity>()
        );

        return new PageUtils(page);
    }

}