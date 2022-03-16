package com.thciwei.loafblog.blog;

import com.thciwei.loafblog.blog.dao.ArticleDao;
import com.thciwei.loafblog.blog.entity.ArticleEntity;
import com.thciwei.loafblog.blog.vo.ArticleVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;

import java.awt.*;
import java.util.Random;

@RunWith(SpringRunner.class)
@SpringBootTest
public class LoafblogBlogApplicationTests {

    @Autowired
    ArticleDao articleDao;

    @Test
    public void one() {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encode = passwordEncoder.encode("thciwei");
        System.out.println(encode);
    }

    @Test
    public void contextLoads() {

        ArticleEntity articleEntity = articleDao.selectById(3);
        ArticleVo articleVo = new ArticleVo();
        BeanUtils.copyProperties(articleEntity, articleVo);
        System.out.println(articleVo.toString());
    }

    @Test
    public void color() {
        Random mRandom = new Random();
        StringBuilder mBuilder = new StringBuilder(); //使用之前首先清空内容
        String haxString;
        for (int i = 0; i < 3; i++) {
            haxString = Integer.toHexString(mRandom.nextInt(0xFF));
            if (haxString.length() == 1) {
                haxString = "0" + haxString;
            }
            mBuilder.append(haxString);
        }

        Color color = Color.decode("#" + mBuilder.toString());
        System.out.println(color.toString());
        System.out.println('#' + Integer.toHexString(color.getRGB() & 0xffffff));
        String s = '#' + Integer.toHexString(color.getRGB() & 0xffffff);


    }

}
