package com.thciwei.loafblog.blog.dao;

import com.thciwei.loafblog.blog.entity.TagsEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thciwei.loafblog.blog.vo.DataVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 标签属性
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@Mapper
public interface TagsDao extends BaseMapper<TagsEntity> {

    List<String> getNames();

    List<DataVo> getValues();
}
