package com.thciwei.loafblog.search.service;

import com.thciwei.loafblog.search.vo.SearchParam;
import com.thciwei.loafblog.search.vo.SearchResult;

public interface BlogSearchService {
    SearchResult search(SearchParam param);
}
