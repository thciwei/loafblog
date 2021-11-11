package com.thciwei.loafblog.search.controller;

import com.thciwei.common.utils.R;
import com.thciwei.loafblog.search.service.BlogSearchService;
import com.thciwei.loafblog.search.vo.SearchParam;
import com.thciwei.loafblog.search.vo.SearchResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("search/save")
public class SearchController {
    @Autowired
    BlogSearchService blogSearchService;

    @GetMapping("/search")
    public R sarchPage( SearchParam param) {

        SearchResult searchResult = blogSearchService.search(param);

        return R.ok().put("data", searchResult);
    }

}
