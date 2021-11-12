package com.thciwei.loafblog.mail.receiver;

import com.rabbitmq.client.Channel;
import com.thciwei.common.constant.MailConstants;
import com.thciwei.common.entity.WebsiteinfoEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.stereotype.Component;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Date;

@Slf4j
@Component
public class MailReceiver {

    //注入三大件，消息创造，邮件信息，模板引擎
    @Autowired
    JavaMailSender javaMailSender;
    //根据我们配置的yml/properties反射取值
    @Autowired
    MailProperties mailProperties;
    @Autowired
    SpringTemplateEngine templateEngine;

    @Autowired
    StringRedisTemplate redisTemplate;

    /**
     * redis保证消费可靠性
     */
    @RabbitListener(queues = MailConstants.MAIL_QUEUE_NAME)
    public void handler(Message message, Channel channel) throws IOException {
        WebsiteinfoEntity websiteinfoEntity = (WebsiteinfoEntity) message.getPayload();
        MessageHeaders headers = message.getHeaders();
        Long tag = (Long) headers.get(AmqpHeaders.DELIVERY_TAG);
        String msgId = (String) headers.get("spring_returned_message_correlation");
        if (redisTemplate.opsForHash().entries("mail_log").containsKey(msgId)) {
            //redis包含key，说明消息已经被消费过
            log.info(msgId + ":消息已经被消费");
            //手动确认消息被消费
            channel.basicAck(tag, false);
            return;
        }
        log.info(websiteinfoEntity.toString());
        //收到消息，发送邮件
        MimeMessage msg = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg);
        try {
            helper.setTo(websiteinfoEntity.getMail());
            helper.setFrom(mailProperties.getUsername());
            helper.setSubject("友链欢迎");
            helper.setSentDate(new Date());
            Context context = new Context();
            context.setVariable("name", websiteinfoEntity.getName());
            context.setVariable("link", websiteinfoEntity.getLink());
            context.setVariable("descp", websiteinfoEntity.getDescp());
            String mail = templateEngine.process("mail", context);
            helper.setText(mail, true);
            javaMailSender.send(msg);
            redisTemplate.opsForHash().put("mail_log", msgId, "thciwei");
            channel.basicAck(tag, false);
            log.info(msgId + "邮件发送成功");
        } catch (MessagingException e) {
            //发送失败丢弃 true
            channel.basicNack(tag, false, true);
            e.printStackTrace();
            log.error("邮件发送失败:" + e.getMessage());
        }

    }
//    //监听器，监听邮件队列
//    @RabbitListener(queues = "com.thciwei.friend")
//    public void handler(WebsiteinfoEntity websiteinfoEntity) {
//
//        log.info(websiteinfoEntity.toString());
//        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
//        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);
//        try {
//            helper.setTo(websiteinfoEntity.getMail());
//            //这里获取的是username
//            helper.setFrom(mailProperties.getUsername());
//            helper.setSubject("友链欢迎");
//            helper.setSentDate(new Date());
//            //获取thymeleaf 对象
//            Context context = new Context();
//            //用student的name赋值html中的name
//            context.setVariable("name", websiteinfoEntity.getName());
//            context.setVariable("link", websiteinfoEntity.getLink());
//            context.setVariable("descp", websiteinfoEntity.getDescp());
//            String mail = templateEngine.process("mail", context);
//            helper.setText(mail, true);
//            javaMailSender.send(mimeMessage);
//            System.out.println(helper.toString());
//            System.out.println("消息发送成功");
//            log.info(helper.toString());
//            log.info("邮件发送成功");
//        } catch (MessagingException e) {
//            e.printStackTrace();
//            //失败同样打印日志
//            log.error("邮件发送失败" + e.getMessage());
//        }


}

