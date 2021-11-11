package com.thciwei.loafblog.picture.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.picture.dao.FastdfsfileDao;
import com.thciwei.loafblog.picture.entity.FastdfsfileEntity;
import com.thciwei.loafblog.picture.service.FastdfsfileService;


@Service("fastdfsfileService")
public class FastdfsfileServiceImpl extends ServiceImpl<FastdfsfileDao, FastdfsfileEntity> implements FastdfsfileService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<FastdfsfileEntity> page = this.page(
                new Query<FastdfsfileEntity>().getPage(params),
                new QueryWrapper<FastdfsfileEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public Integer upload(String url, String fieldId) {
        FastdfsfileEntity fastdfsfileEntity = new FastdfsfileEntity();
        fastdfsfileEntity.setFastname(fieldId);
        fastdfsfileEntity.setUrl(url);
        return this.baseMapper.insert(fastdfsfileEntity);

    }

    @Override
    public List<FastdfsfileEntity> getFileList() {

        List<FastdfsfileEntity> list = this.baseMapper.selectList(null);
        return list;

    }

}