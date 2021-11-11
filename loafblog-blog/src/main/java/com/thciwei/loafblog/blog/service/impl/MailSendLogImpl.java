package com.thciwei.loafblog.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;
import com.thciwei.loafblog.blog.dao.MailSendLogDao;
import com.thciwei.loafblog.blog.entity.MailSendLogEntity;
import com.thciwei.loafblog.blog.service.MailSendLogService;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("MailSendLogService")
public class MailSendLogImpl extends ServiceImpl<MailSendLogDao, MailSendLogEntity> implements MailSendLogService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<MailSendLogEntity> page = this.page(
                new Query<MailSendLogEntity>().getPage(params),
                new QueryWrapper<MailSendLogEntity>()
        );

        return new PageUtils(page);
    }
}
