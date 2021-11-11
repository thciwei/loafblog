package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.TodolistEntity;
import com.thciwei.loafblog.blog.vo.TodoVo;

import java.util.List;
import java.util.Map;

/**
 * 事件清单
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-12 23:12:00
 */
public interface TodolistService extends IService<TodolistEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<TodoVo> getTodoList();
}

