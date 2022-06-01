package com.thciwei.loafblog.search.controller;

import com.thciwei.common.utils.R;
import com.thciwei.loafblog.search.service.BlogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("search/article")
@Slf4j
public class ElasticController {
    @Autowired
    BlogService blogService;

    @PostMapping("/deleteById")
    public R deleteArticle(@RequestParam("id") Integer id) throws IOException {
        Integer res = blogService.deleteEsById(id);
        if (res == 0) {
            return R.ok();
        } else {
            return R.error();
        }
    }
}
