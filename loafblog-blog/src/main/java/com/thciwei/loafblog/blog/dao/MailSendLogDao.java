package com.thciwei.loafblog.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thciwei.loafblog.blog.entity.MailSendLogEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface MailSendLogDao extends BaseMapper<MailSendLogEntity> {
    Integer insertMail(MailSendLogEntity mailSendLogEntity);

    Integer updateMailSendLogStatus(@Param("msgId") String msgId, @Param("status") Integer status);

    List<MailSendLogEntity> getMailSendLogsByStatus();

    Integer updateCount(@Param("msgId") String msgId, @Param("date") Date date);
}
