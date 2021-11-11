package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.WebsiteinfoEntity;

import java.util.Map;

public interface WebsiteinfoService extends IService<WebsiteinfoEntity> {
    PageUtils queryPage(Map<String, Object> params);

    Integer saveAndMail(WebsiteinfoEntity websiteinfo);

}
