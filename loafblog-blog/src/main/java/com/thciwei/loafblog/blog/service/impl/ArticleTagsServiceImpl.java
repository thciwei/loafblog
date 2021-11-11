package com.thciwei.loafblog.blog.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.blog.dao.ArticleTagsDao;
import com.thciwei.loafblog.blog.entity.ArticleTagsEntity;
import com.thciwei.loafblog.blog.service.ArticleTagsService;


@Service("ArticleTagsService")
public class ArticleTagsServiceImpl extends ServiceImpl<ArticleTagsDao, ArticleTagsEntity> implements ArticleTagsService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ArticleTagsEntity> page = this.page(
                new Query<ArticleTagsEntity>().getPage(params),
                new QueryWrapper<ArticleTagsEntity>()
        );

        return new PageUtils(page);
    }

}