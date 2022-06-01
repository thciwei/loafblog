package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.ArticleEntity;
import com.thciwei.loafblog.blog.entity.CategoryEntity;
import com.thciwei.loafblog.blog.entity.TagsEntity;
import com.thciwei.loafblog.blog.vo.ArticleFileVo;
import com.thciwei.loafblog.blog.vo.ArticleVo;
import com.thciwei.loafblog.blog.vo.TagsCloudVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.IOException;
import java.util.Date;
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


    List<CategoryEntity> getCategorys();

    List<TagsEntity> getTags();


    void saveArticle(ArticleEntity article) throws IOException;

    ArticleVo getArticleById(Integer id);

    PageUtils queryPage2(Map<String, Object> params);

    List<ArticleFileVo> getArticleByTime();

    List<TagsCloudVo> getTagsCloud();


    List<ArticleVo> getArticleByCid(Integer cid);

    List<String> getArticleTimes();

    List<ArticleEntity> getByYearMonth(@Param("year") String year, @Param("month") String month);

    void deleteByIds(List<Integer> asList);

    PageUtils queryPage3(Map<String, Object> params);
}

