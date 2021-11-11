package com.thciwei.loafblog.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.constant.MailConstants;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.Query;
import com.thciwei.loafblog.blog.dao.MailSendLogDao;
import com.thciwei.loafblog.blog.dao.WebsiteinfoDao;
import com.thciwei.loafblog.blog.entity.MailSendLogEntity;
import com.thciwei.loafblog.blog.entity.WebsiteinfoEntity;
import com.thciwei.loafblog.blog.service.MailSendLogService;
import com.thciwei.loafblog.blog.service.WebsiteinfoService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service("WebsiteinfoService")
public class WebsiteinfoServiceImpl extends ServiceImpl<WebsiteinfoDao, WebsiteinfoEntity> implements WebsiteinfoService {
    @Autowired
    WebsiteinfoDao websiteinfoDao;
    @Autowired
    RabbitTemplate rabbitTemplate;
    @Autowired
    MailSendLogDao mailSendLogDao;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {

        String key = (String) params.get("key");
        QueryWrapper<WebsiteinfoEntity> wrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(key)) {
            wrapper.eq("id", key).or().like("name", key);
        }
        IPage<WebsiteinfoEntity> page = this.page(
                new Query<WebsiteinfoEntity>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }

    @Transactional
    @Override
    public Integer saveAndMail(WebsiteinfoEntity websiteinfo) {

        Integer result = websiteinfoDao.insertGetId(websiteinfo);
        if (result == 1) {
            WebsiteinfoEntity websiteinfoEntity = this.baseMapper.selectById(websiteinfo.getId());
            //打印student对象，作为检查
            log.info(websiteinfoEntity.toString());
            //生成消息唯一id
            String msgId = UUID.randomUUID().toString();
            System.out.println(msgId);
            MailSendLogEntity mailSendLog = new MailSendLogEntity();
            mailSendLog.setMsgId(msgId);
            mailSendLog.setCreateTime(new Date());
            mailSendLog.setExchange(MailConstants.MAIL_EXCHANGE_NAME);
            mailSendLog.setRouteKey(MailConstants.MAIL_ROUTING_KEY_NAME);
            mailSendLog.setWebsiteId(websiteinfoEntity.getId());
            mailSendLog.setTryTime(new Date(System.currentTimeMillis() + 1000 * 60 * MailConstants.MSG_TIMEOUT));
            mailSendLogDao.insertMail(mailSendLog);
            rabbitTemplate.convertAndSend(MailConstants.MAIL_EXCHANGE_NAME, MailConstants.MAIL_ROUTING_KEY_NAME, websiteinfoEntity, new CorrelationData(msgId));
            //查看消息是否被消费
            rabbitTemplate.convertAndSend(MailConstants.MAIL_EXCHANGE_NAME, MailConstants.MAIL_ROUTING_KEY_NAME, websiteinfoEntity, new CorrelationData(msgId));


        }
        return result;


    }
}
