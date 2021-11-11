package com.thciwei.loafblog.picture.component;

import com.apistd.uni.Uni;
import com.apistd.uni.UniException;
import com.apistd.uni.UniResponse;
import com.apistd.uni.sms.UniMessage;
import com.apistd.uni.sms.UniSMS;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@ConfigurationProperties(prefix = "unisms")
@Data
@Component
public class SmsComponent {

    private String ACCESS_KEY_ID;
    private String ACCESS_KEY_SECRET;
    private String signature;
    private String templateId;

    public void sendmsg(String phone, String code) {

        // 初始化
        Uni.init(ACCESS_KEY_ID); // 若使用简易验签模式仅传入第一个参数即可

        // 设置自定义参数 (变量短信)
        Map<String, String> templateData = new HashMap<String, String>();
        templateData.put("code", code);
        templateData.put("ttl", "0");
        System.out.println(templateData);
        // 构建信息
        UniMessage message = UniSMS.buildMessage()
                .setTo(phone)
                .setSignature(signature)
                .setTemplateId(templateId)
                .setTemplateData(templateData);
        // 发送短信
        try {
            UniResponse res = message.send();
            System.out.println(res.toString());
        } catch (UniException e) {
            System.out.println("Error: " + e);
            System.out.println("RequestId: " + e.requestId);
        }

    }


}
