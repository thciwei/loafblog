package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.ArticleEntity;
import com.thciwei.loafblog.blog.entity.CategoryEntity;
import com.thciwei.loafblog.blog.entity.TagsEntity;
import com.thciwei.loafblog.blog.vo.ArticleFileVo;
import com.thciwei.loafblog.blog.vo.ArticleVo;
import com.thciwei.loafblog.blog.vo.TagsCloudVo;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 博客内容和属性
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
public interface ArticleService extends IService<ArticleEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<ArticleVo> getTagAndCategory();

    List<ArticleVo> getBlog(String title);

    List<CategoryEntity> getCategorys();

    List<TagsEntity> getTags();


    void saveArticle(ArticleEntity article) throws IOException;

    ArticleVo getArticleById(Integer id);

    PageUtils queryPage2(Map<String, Object> params);

    List<ArticleFileVo> getArticleByTime();

    List<TagsCloudVo> getTagsCloud();

}

