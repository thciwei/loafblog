package com.thciwei.loafblog.picture.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.picture.entity.SysUserEntity;

import java.util.Map;

/**
 * 系统用户
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-12 16:22:55
 */
public interface SysUserService extends IService<SysUserEntity> {

    PageUtils queryPage(Map<String, Object> params);

    Integer getUserNumber();
}

