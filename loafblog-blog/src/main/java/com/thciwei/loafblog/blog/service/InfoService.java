package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.InfoEntity;

import java.util.List;
import java.util.Map;

/**
 * 友链邮箱和信息
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-16 20:56:33
 */
public interface InfoService extends IService<InfoEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<InfoEntity> getList();


    Integer updateView(Integer id);

    Integer getMessageNoViewCount();
}

