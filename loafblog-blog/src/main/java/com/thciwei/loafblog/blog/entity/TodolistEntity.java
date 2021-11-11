package com.thciwei.loafblog.blog.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName("todoList")
public class TodolistEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     *
     */
    @TableId
    private Integer id;
    /**
     * todo事件
     */
    private String text;
    /**
     * 是否完成
     */
    private Integer done;
}
