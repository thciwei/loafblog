package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.CommentEntity;
import com.thciwei.loafblog.blog.vo.CommentVo;

import java.util.List;
import java.util.Map;

/**
 *
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-25 13:50:49
 */
public interface CommentService extends IService<CommentEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<CommentVo> getComments(Integer postId);

}