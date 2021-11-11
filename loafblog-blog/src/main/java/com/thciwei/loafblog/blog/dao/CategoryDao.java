package com.thciwei.loafblog.blog.dao;

import com.thciwei.loafblog.blog.entity.CategoryEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thciwei.loafblog.blog.vo.DataVo;
import com.thciwei.loafblog.blog.vo.PieVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 分类属性
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@Mapper
public interface CategoryDao extends BaseMapper<CategoryEntity> {

    List<DataVo> getValues();

    List<String> getNames();
}
