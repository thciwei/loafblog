package com.thciwei.loafblog.blog.dao;

import com.thciwei.loafblog.blog.entity.CommentEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-25 13:50:49
 */
@Mapper
public interface CommentDao extends BaseMapper<CommentEntity> {

    List<CommentEntity> getParentComments(Integer postId);
}
