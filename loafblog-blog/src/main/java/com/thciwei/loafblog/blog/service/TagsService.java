package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.TagsEntity;

import java.util.List;
import java.util.Map;

/**
 * 标签属性
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
public interface TagsService extends IService<TagsEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<String> getTagNames();
}

