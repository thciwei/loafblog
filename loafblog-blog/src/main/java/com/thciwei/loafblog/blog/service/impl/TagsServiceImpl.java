package com.thciwei.loafblog.blog.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;

import com.thciwei.loafblog.blog.dao.TagsDao;
import com.thciwei.loafblog.blog.entity.TagsEntity;
import com.thciwei.loafblog.blog.service.TagsService;


@Service("TagsService")
public class TagsServiceImpl extends ServiceImpl<TagsDao, TagsEntity> implements TagsService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String) params.get("key");
        QueryWrapper<TagsEntity> wrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(key)) {
            wrapper.eq("id", key).or().like("tagName", key);
        }
        IPage<TagsEntity> page = this.page(
                new Query<TagsEntity>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }

    @Override
    public List<String> getTagNames() {

        List<String> collect = this.baseMapper.selectList(null).stream().map(item -> {
            String tagname = item.getTagname();
            return tagname;
        }).collect(Collectors.toList());
        return collect;
    }

}