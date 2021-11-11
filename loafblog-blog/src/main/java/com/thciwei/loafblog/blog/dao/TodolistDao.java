package com.thciwei.loafblog.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thciwei.loafblog.blog.entity.TodolistEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 事件清单
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-12 23:12:00
 */
@Mapper
public interface TodolistDao extends BaseMapper<TodolistEntity> {
	
}
