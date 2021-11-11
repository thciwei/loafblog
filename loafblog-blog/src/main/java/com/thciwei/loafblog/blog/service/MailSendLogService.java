package com.thciwei.loafblog.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.MailSendLogEntity;

import java.util.Map;

public interface MailSendLogService extends IService<MailSendLogEntity> {


    PageUtils queryPage(Map<String, Object> params);


}
