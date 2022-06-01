package com.thciwei.loafblog.search.service.impl;

import com.thciwei.common.utils.R;
import com.thciwei.loafblog.search.constant.EsConstant;
import com.thciwei.loafblog.search.service.BlogService;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.delete.DeleteResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Slf4j
@Service("BlogService")
public class BlogServiceImpl implements BlogService {
    @Autowired
    RestHighLevelClient restHighLevelClient;

    @Override
    public Integer deleteEsById(Integer id) throws IOException {
        DeleteRequest deleteRequest = new DeleteRequest(EsConstant.ARTICLE_INDEX, id.toString());
        DeleteResponse deleteResponse = restHighLevelClient.delete(deleteRequest, RequestOptions.DEFAULT);

        log.info(id + "状态：{}", deleteResponse.status());
        return R.ok().getCode();
    }
}
