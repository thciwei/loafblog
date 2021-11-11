package com.thciwei.loafblog.blog.task;

import com.thciwei.common.constant.MailConstants;
import com.thciwei.loafblog.blog.dao.MailSendLogDao;
import com.thciwei.loafblog.blog.entity.MailSendLogEntity;
import com.thciwei.loafblog.blog.entity.WebsiteinfoEntity;
import com.thciwei.loafblog.blog.service.MailSendLogService;
import com.thciwei.loafblog.blog.service.WebsiteinfoService;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
public class MailSendTask {
    @Autowired
    MailSendLogDao mailSendLogDao;
    @Autowired
    RabbitTemplate rabbitTemplate;
    @Autowired
    WebsiteinfoService websiteinfoService;

    @Scheduled(cron = "0/10 * * * * ?")
    public void mailResendTask() {
        List<MailSendLogEntity> logs = mailSendLogDao.getMailSendLogsByStatus();
        if (logs == null || logs.size() == 0) {
            return;
        }
        logs.forEach(mailSendLog -> {
            if (mailSendLog.getCount() >= 3) {
                mailSendLogDao.updateMailSendLogStatus(mailSendLog.getMsgId(), 2);
            } else {
                mailSendLogDao.updateCount(mailSendLog.getMsgId(), new Date());
                WebsiteinfoEntity websiteinfo = websiteinfoService.getById(mailSendLog.getWebsiteId());
                rabbitTemplate.convertAndSend(MailConstants.MAIL_EXCHANGE_NAME, MailConstants.MAIL_ROUTING_KEY_NAME, websiteinfo, new CorrelationData(mailSendLog.getMsgId()));
            }
        });
    }
}
