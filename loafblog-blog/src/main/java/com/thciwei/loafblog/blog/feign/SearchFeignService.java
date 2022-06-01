package com.thciwei.loafblog.blog.feign;

import com.thciwei.common.to.es.ArticleEsModel;
import com.thciwei.common.utils.R;
import org.apache.ibatis.annotations.Param;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


@FeignClient("loafblog-search")
public interface SearchFeignService {
    @PostMapping("search/save/article")
    public R addArticle(ArticleEsModel articleEsModel);

    @PostMapping("search/article/deleteById")
    public R deleteArticle(@RequestParam("id") Integer id);
}
