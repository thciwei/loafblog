package com.thciwei.loafblog.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thciwei.loafblog.blog.entity.InfoEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 友链邮箱和信息
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-16 20:44:04
 */
@Mapper
public interface InfoDao extends BaseMapper<InfoEntity> {

    Integer getNoViewCount();
}
