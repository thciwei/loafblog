package com.thciwei.loafblog.search.controller;

import com.thciwei.common.exception.BizCodeEnum;
import com.thciwei.common.to.es.ArticleEsModel;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.search.service.ArticleAddService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("search/save")
@Slf4j
public class ElasticSaveController {
    @Autowired
    ArticleAddService articleAddService;

    @PostMapping("/article")
    public R addArticle(@RequestBody ArticleEsModel articleEsModel) {
        Boolean b = false;
        try {

            b = articleAddService.addArticle(articleEsModel);
            log.info("es存入文章:{}",articleEsModel.toString());
        } catch (Exception e) {
            log.error("ElasticSaveController文章添加异常:{}", e);
            return R.error(BizCodeEnum.ARTICLE_ADD_EXCEPTION.getCode(), BizCodeEnum.ARTICLE_ADD_EXCEPTION.getMsg());

        }


        if (!b) {
            return R.ok();
        } else {
            return R.error(BizCodeEnum.ARTICLE_ADD_EXCEPTION.getCode(), BizCodeEnum.ARTICLE_ADD_EXCEPTION.getMsg());

        }
    }



}
