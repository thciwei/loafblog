package com.thciwei.loafblog.blog.service.impl;

import com.thciwei.loafblog.blog.vo.CommentVo;
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

import com.thciwei.loafblog.blog.dao.CommentDao;
import com.thciwei.loafblog.blog.entity.CommentEntity;
import com.thciwei.loafblog.blog.service.CommentService;


@Service("CommentService")
public class CommentServiceImpl extends ServiceImpl<CommentDao, CommentEntity> implements CommentService {

    @Autowired
    CommentDao commentDao;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<CommentEntity> page = this.page(
                new Query<CommentEntity>().getPage(params),
                new QueryWrapper<CommentEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<CommentVo> getComments(Integer postId) {

        List<CommentEntity> commentEntities = commentDao.getParentComments(postId);
        List<CommentVo> collect = commentEntities.stream().map(item -> {
            CommentVo commentVo = new CommentVo();

            commentVo.setComment(item);

            List<CommentEntity> replayList = commentDao.selectList(new QueryWrapper<CommentEntity>().eq("parentId", item.getId()).eq("postId",postId));
            List<CommentEntity> reply = replayList.stream().map(rep -> {
                CommentEntity entity = new CommentEntity();
                BeanUtils.copyProperties(rep, entity);
                return entity;
            }).collect(Collectors.toList());

            commentVo.setReply(reply);
            return commentVo;

        }).collect(Collectors.toList());
        return collect;

    }

}