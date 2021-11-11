package com.thciwei.loafblog.picture.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.picture.dao.SysUserDao;
import com.thciwei.loafblog.picture.entity.SysUserEntity;
import com.thciwei.loafblog.picture.service.SysUserService;


@Service("sysUserService")
public class SysUserServiceImpl extends ServiceImpl<SysUserDao, SysUserEntity> implements SysUserService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<SysUserEntity> page = this.page(
                new Query<SysUserEntity>().getPage(params),
                new QueryWrapper<SysUserEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public Integer getUserNumber() {

        return this.baseMapper.selectCount(null);
    }

}