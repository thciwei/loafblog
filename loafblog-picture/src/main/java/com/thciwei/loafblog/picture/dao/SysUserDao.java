package com.thciwei.loafblog.picture.dao;

import com.thciwei.loafblog.picture.entity.SysUserEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统用户
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-12 16:22:55
 */
@Mapper
public interface SysUserDao extends BaseMapper<SysUserEntity> {
	
}
