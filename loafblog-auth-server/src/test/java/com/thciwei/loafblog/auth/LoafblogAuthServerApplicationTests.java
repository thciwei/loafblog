package com.thciwei.loafblog.auth;

import com.thciwei.loafblog.auth.feign.ThirdPartyFeignService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class LoafblogAuthServerApplicationTests {
@Autowired
    ThirdPartyFeignService thirdPartyFeignService;

    @Test
    public void contextLoads() {
        thirdPartyFeignService.sendCode("15032289043","1234545");
    }

}
