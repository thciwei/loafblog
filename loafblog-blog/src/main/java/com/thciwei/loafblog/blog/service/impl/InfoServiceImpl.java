package com.thciwei.loafblog.blog.service.impl;

import com.thciwei.loafblog.blog.entity.InfoEntity;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.blog.dao.InfoDao;
import com.thciwei.loafblog.blog.service.InfoService;


@Service("InfoService")
public class InfoServiceImpl extends ServiceImpl<InfoDao, InfoEntity> implements InfoService {
    @Autowired
    InfoDao infoDao;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String) params.get("key");
        QueryWrapper<InfoEntity> wrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(key)) {
            wrapper.eq("id", key).or().like("content", key);
        }
        IPage<InfoEntity> page = this.page(
                new Query<InfoEntity>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }

    @Override
    public List<InfoEntity> getList() {
        return this.baseMapper.selectList(null);
    }

    @Override
    public Integer updateView(Integer id) {
        InfoEntity infoEntity = this.getById(id);
        System.out.println(infoEntity);
        infoEntity.setIsview(true);
        return this.baseMapper.updateById(infoEntity);


    }

    @Override
    public Integer getMessageNoViewCount() {

        Integer count = infoDao.getNoViewCount();
        return count;
    }


}