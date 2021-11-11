package com.thciwei.loafblog.blog.feign;

import com.thciwei.common.to.es.ArticleEsModel;
import com.thciwei.common.utils.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;




@FeignClient("loafblog-search")
public interface SearchFeignService {
    @PostMapping("search/save/article")
    public R addArticle(ArticleEsModel articleEsModel);
}
