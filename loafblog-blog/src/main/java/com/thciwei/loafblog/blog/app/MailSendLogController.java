package com.thciwei.loafblog.blog.app;

import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.blog.entity.MailSendLogEntity;
import com.thciwei.loafblog.blog.service.MailSendLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

@RestController
@RequestMapping("blog/mailsendlog")
public class MailSendLogController {
    @Autowired
    private MailSendLogService mailSendLogService;



    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = mailSendLogService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{msgid}")
    public R info(@PathVariable("msgid") String msgid){
        MailSendLogEntity mailSendLog = mailSendLogService.getById(msgid);

        return R.ok().put("mailSendLog", mailSendLog);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody MailSendLogEntity mailSendLog){
        mailSendLogService.save(mailSendLog);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody MailSendLogEntity mailSendLog){
        mailSendLogService.updateById(mailSendLog);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody String[] msgids){
        mailSendLogService.removeByIds(Arrays.asList(msgids));

        return R.ok();
    }

}
