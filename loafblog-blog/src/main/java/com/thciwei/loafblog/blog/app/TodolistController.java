package com.thciwei.loafblog.blog.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.thciwei.loafblog.blog.entity.TodolistEntity;
import com.thciwei.loafblog.blog.vo.TodoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


import com.thciwei.loafblog.blog.service.TodolistService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;



/**
 * 事件清单
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-12 23:12:00
 */
@RestController
@RequestMapping("blog/todolist")
public class TodolistController {
    @Autowired
    private TodolistService todolistService;

    @GetMapping("/todo")
    public R getTodoList(){
      List<TodoVo> data=  todolistService.getTodoList();

        return R.ok().put("data",data);
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = todolistService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		TodolistEntity todolist = todolistService.getById(id);

        return R.ok().put("todolist", todolist);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody TodolistEntity todolist){
		todolistService.save(todolist);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody TodolistEntity todolist){
		todolistService.updateById(todolist);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		todolistService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
