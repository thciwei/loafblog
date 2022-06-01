package com.thciwei.loafblog.blog.service.impl;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.thciwei.common.exception.BizCodeEnum;
import com.thciwei.common.to.es.ArticleEsModel;
import com.thciwei.common.utils.FileColorUtils;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.blog.dao.*;
import com.thciwei.loafblog.blog.entity.*;
import com.thciwei.loafblog.blog.feign.SearchFeignService;
import com.thciwei.loafblog.blog.vo.ArticleFileVo;
import com.thciwei.loafblog.blog.vo.ArticleVo;
import com.thciwei.loafblog.blog.vo.TagsCloudVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.blog.service.ArticleService;
import org.springframework.transaction.annotation.Transactional;


@Service("ArticleService")
@Slf4j
public class ArticleServiceImpl extends ServiceImpl<ArticleDao, ArticleEntity> implements ArticleService {

    @Autowired
    ArticleDao articleDao;
    @Autowired
    CategoryDao categoryDao;
    @Autowired
    TagsDao tagsDao;
    @Autowired
    ArticleCategoryDao articleCategoryDao;
    @Autowired
    ArticleTagsDao articleTagsDao;
    @Autowired
    SearchFeignService searchFeignService;
    @Autowired
    ArticleService articleService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String) params.get("key");
        QueryWrapper<ArticleEntity> wrapper = new QueryWrapper<>();

        if (!StringUtils.isEmpty(key)) {
            wrapper.eq("id", key).or().like("title", key);
        } else {
            wrapper.eq("state", 0);
        }

        IPage<ArticleEntity> page = this.page(
                new Query<ArticleEntity>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }

    @Override
    public List<ArticleVo> getTagAndCategory() {
        List<ArticleVo> data = articleDao.getTagAndCategory();

        return data;
    }


    @Override
    public List<CategoryEntity> getCategorys() {
        return categoryDao.selectList(new QueryWrapper<>());
    }

    @Override
    public List<TagsEntity> getTags() {
        return tagsDao.selectList(new QueryWrapper<>());
    }

    @Transactional
    @Override
    public void saveArticle(ArticleEntity article) {
        articleDao.saveArticle(article);
        ArticleCategoryEntity articleCategoryEntity = new ArticleCategoryEntity();
        articleCategoryEntity.setAid(article.getId());
        articleCategoryEntity.setCid(article.getCid());
        ArticleTagsEntity articleTagsEntity = new ArticleTagsEntity();
        articleTagsEntity.setAid(article.getId());
        articleTagsEntity.setTid(article.getTid());
        articleCategoryDao.insert(articleCategoryEntity);
        articleTagsDao.insert(articleTagsEntity);
        /**
         * 拷贝属性
         */
        ArticleEsModel articleEsModel = new ArticleEsModel();
        BeanUtils.copyProperties(article, articleEsModel);
        log.info(articleEsModel.toString());
        /**
         * 封装es对象剩余信息
         */
        CategoryEntity categoryEntity = categoryDao.selectById(article.getCid());
        articleEsModel.setCateName(categoryEntity.getCatename());
        TagsEntity tagsEntity = tagsDao.selectById(article.getTid());
        articleEsModel.setTagName(tagsEntity.getTagname());
        articleEsModel.setHotScore(0L);
        log.info(articleEsModel.toString());
        //  将数据发送给es进行保存 loafblog-search
        R r = searchFeignService.addArticle(articleEsModel);
        //检查远程调用是否成功
        if (r.getCode() == 0) {
            log.info("添加文章到es成功");
        } else {
            log.error(BizCodeEnum.ARTICLE_ADD_EXCEPTION.getMsg());
        }
    }

    @Override
    public ArticleVo getArticleById(Integer id) {
        ArticleEntity articleEntity = this.baseMapper.selectById(id);
        ArticleVo articleVo = new ArticleVo();
        BeanUtils.copyProperties(articleEntity, articleVo);
        String catename = categoryDao.selectById(articleEntity.getCid()).getCatename();
        String tagname = tagsDao.selectById(articleEntity.getTid()).getTagname();
        articleVo.setCateName(catename);
        articleVo.setTagName(tagname);
        return articleVo;
    }

    @Override
    public PageUtils queryPage2(Map<String, Object> params) {

        String key = (String) params.get("key");
        QueryWrapper<ArticleEntity> wrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(key)) {
            wrapper.eq("cid", key);
        }
        IPage<ArticleEntity> page = this.page(
                new Query<ArticleEntity>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }

    @Override
    public List<ArticleFileVo> getArticleByTime() {
        QueryWrapper<ArticleEntity> wrapper = new QueryWrapper<>();
        wrapper.orderBy(true, false, "publishDate");
        List<ArticleEntity> articleEntities = articleDao.selectList(wrapper);
        List<ArticleFileVo> collect = articleEntities.stream().map(item -> {
            ArticleFileVo fileVo = new ArticleFileVo();
            fileVo.setId(item.getId());
            fileVo.setTitle(item.getTitle());
            fileVo.setImage(item.getImage());
            fileVo.setPublishdate(item.getPublishdate());
            fileVo.setColor(FileColorUtils.getColor());
            return fileVo;
        }).collect(Collectors.toList());
        return collect;
    }

    @Override
    public List<TagsCloudVo> getTagsCloud() {
        List<TagsEntity> list = tagsDao.selectList(null);
        List<TagsCloudVo> collect = list.stream().map(item -> {
            TagsCloudVo cloudVo = new TagsCloudVo();
            cloudVo.setId(item.getId());
            cloudVo.setName(item.getTagname());
            return cloudVo;
        }).collect(Collectors.toList());
        return collect;
    }

    @Override
    public List<ArticleVo> getArticleByCid(Integer cid) {

        QueryWrapper<ArticleEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("cid", cid);
        List<ArticleEntity> entities = articleDao.selectList(wrapper);
        List<ArticleVo> collect = entities.stream().map(item -> {
            ArticleVo articleVo = new ArticleVo();
            BeanUtils.copyProperties(item, articleVo);
            CategoryEntity categoryEntity = categoryDao.selectById(item.getCid());
            TagsEntity tagsEntity = tagsDao.selectById(item.getTid());
            articleVo.setTagName(tagsEntity.getTagname());
            articleVo.setCateName(categoryEntity.getCatename());
            return articleVo;
        }).collect(Collectors.toList());
        return collect;

    }

    @Override
    public List<String> getArticleTimes() {
        return articleDao.getArticleTimes();

    }

    @Override
    public List<ArticleEntity> getByYearMonth(String year, String month) {
        QueryWrapper<ArticleEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("year(publishDate)", year).eq("month(publishDate)", month);
        List<ArticleEntity> entities = articleDao.selectList(wrapper);
        return entities;
    }

    @Override
    public void deleteByIds(List<Integer> asList) {
        Integer id = asList.get(0);
        R r = searchFeignService.deleteArticle(id);
        if (r.getCode() == 0) {
            articleService.removeById(id);
        } else {
            log.error("articleService.removeById删除失败");
        }

    }

    @Override
    public PageUtils queryPage3(Map<String, Object> params) {
        String key = (String) params.get("key");
        QueryWrapper<ArticleEntity> wrapper = new QueryWrapper<>();

        if (!StringUtils.isEmpty(key)) {
            wrapper.eq("id", key).or().like("title", key);
        } else {
            wrapper.eq("state", 0);
        }

        IPage<ArticleEntity> page = this.page(
                new Query<ArticleEntity>().getPage(params),
                wrapper
        );
        PageUtils pageUtils = new PageUtils(page);
        List<ArticleEntity> records = page.getRecords();
        List<ArticleVo> collect = records.stream().map(articleEntity -> {
            ArticleVo vo = new ArticleVo();
            BeanUtils.copyProperties(articleEntity, vo);
            CategoryEntity category = categoryDao.selectById(articleEntity.getCid());
            vo.setCateName(category.getCatename());
            TagsEntity tagsEntity = tagsDao.selectById(articleEntity.getTid());
            vo.setTagName(tagsEntity.getTagname());
            return vo;
        }).collect(Collectors.toList());

        pageUtils.setList(collect);
        return pageUtils;

    }


}