package com.thciwei.loafblog.blog.dao;

import com.thciwei.loafblog.blog.entity.ArticleEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thciwei.loafblog.blog.vo.ArticleVo;
import com.thciwei.loafblog.blog.vo.DataVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.Date;
import java.util.List;

/**
 * 博客内容和属性
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@Mapper
public interface ArticleDao extends BaseMapper<ArticleEntity> {

    List<ArticleVo> getTagAndCategory();


    List<ArticleVo> getBlog(String title);

    void saveArticle(ArticleEntity article);


    List<String> getArticleTimes();

}
