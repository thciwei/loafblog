package com.thciwei.loafblog.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.thciwei.loafblog.blog.entity.WebsiteinfoEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WebsiteinfoDao extends BaseMapper<WebsiteinfoEntity> {


    Integer insertGetId(WebsiteinfoEntity websiteinfo);
}
