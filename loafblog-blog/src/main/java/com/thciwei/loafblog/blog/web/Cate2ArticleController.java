package com.thciwei.loafblog.blog.web;

import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.blog.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("blog/web")
public class Cate2ArticleController {
    @Autowired
    ArticleService articleService;

    /**
     * web端进入不同分类
     */
    @RequestMapping("/catearticle")
    public R listCate(@RequestParam Map<String, Object> params) {
        PageUtils page = articleService.queryPage2(params);
        return R.ok().put("page", page);
    }
    @GetMapping("/getB")
    public R getB(@RequestParam Map<String, Object> params) {
        PageUtils page = articleService.queryPage(params);


        return R.ok().put("page", page);
    }



}
