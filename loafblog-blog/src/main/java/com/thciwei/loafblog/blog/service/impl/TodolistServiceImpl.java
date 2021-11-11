package com.thciwei.loafblog.blog.service.impl;

import com.thciwei.loafblog.blog.entity.TodolistEntity;
import com.thciwei.loafblog.blog.vo.TodoVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.blog.dao.TodolistDao;
import com.thciwei.loafblog.blog.service.TodolistService;


@Service("TodolistService")
public class TodolistServiceImpl extends ServiceImpl<TodolistDao, TodolistEntity> implements TodolistService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<TodolistEntity> page = this.page(
                new Query<TodolistEntity>().getPage(params),
                new QueryWrapper<TodolistEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<TodoVo> getTodoList() {

        List<TodoVo> collect = this.baseMapper.selectList(null).stream().map(item -> {
            TodoVo todoVo = new TodoVo();
            todoVo.setText(item.getText());
            todoVo.setDone(item.getDone());
            return todoVo;
        }).collect(Collectors.toList());
        return collect;
    }

}