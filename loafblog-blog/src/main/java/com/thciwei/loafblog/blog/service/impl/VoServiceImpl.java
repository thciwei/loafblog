package com.thciwei.loafblog.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.thciwei.loafblog.blog.dao.ArticleDao;
import com.thciwei.loafblog.blog.dao.CategoryDao;
import com.thciwei.loafblog.blog.dao.CommentDao;
import com.thciwei.loafblog.blog.dao.TagsDao;
import com.thciwei.loafblog.blog.entity.CategoryEntity;
import com.thciwei.loafblog.blog.feign.SysUserFeign;
import com.thciwei.loafblog.blog.service.VoService;
import com.thciwei.loafblog.blog.vo.PanelGroupVo;
import com.thciwei.loafblog.blog.vo.DataVo;
import com.thciwei.loafblog.blog.vo.PieVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("VoService")
public class VoServiceImpl implements VoService {
    @Autowired
    ArticleDao articleDao;
    @Autowired
    SysUserFeign sysUserFeign;
    @Autowired
    CategoryDao categoryDao;
    @Autowired
    TagsDao tagsDao;
    @Autowired
    CommentDao commentDao;

    @Override
    public PanelGroupVo getPanelGroup() {
        PanelGroupVo panelGroupVo = new PanelGroupVo();
        panelGroupVo.setCommentNumber(commentDao.selectCount(null));
        panelGroupVo.setArticleNumber(articleDao.selectCount(null));
        panelGroupVo.setUserNumber(sysUserFeign.getUserNumber());

        return panelGroupVo;
    }

    @Override
    public PieVo getCategoryPie() {
        PieVo pieVo = new PieVo();

        pieVo.setNames(categoryDao.getNames());
        pieVo.setValues(categoryDao.getValues());

        return pieVo;
    }

    @Override
    public PieVo getTagPie() {

        PieVo pieVo = new PieVo();

        pieVo.setNames(tagsDao.getNames());
        pieVo.setValues(tagsDao.getValues());

        return pieVo;
    }

}
