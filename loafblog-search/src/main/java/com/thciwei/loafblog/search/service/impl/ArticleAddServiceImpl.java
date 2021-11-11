package com.thciwei.loafblog.search.service.impl;

import com.alibaba.fastjson.JSON;
import com.thciwei.common.to.es.ArticleEsModel;
import com.thciwei.loafblog.search.config.LoafblogEsConfig;
import com.thciwei.loafblog.search.constant.EsConstant;
import com.thciwei.loafblog.search.service.ArticleAddService;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Service("articleAddService")
@Slf4j
public class ArticleAddServiceImpl implements ArticleAddService {
    @Autowired
    RestHighLevelClient restHighLevelClient;

    @Override
    public Boolean addArticle(ArticleEsModel articleEsModel) throws IOException {
        //保存到es，1、put构建一个es索引,字段相映射

        // 2.构造保存请求
        BulkRequest bulkRequest = new BulkRequest();

        // 设置es索引
        IndexRequest indexRequest = new IndexRequest(EsConstant.ARTICLE_INDEX);
        // 设置索引id
        //System.out.println(articleEsModel.getId().toString());
        indexRequest.id(articleEsModel.getId().toString());
        // json格式
        String s = JSON.toJSONString(articleEsModel);
        indexRequest.source(s, XContentType.JSON);
        // 添加到文档
        bulkRequest.add(indexRequest);
        BulkResponse bulk = restHighLevelClient.bulk(bulkRequest, LoafblogEsConfig.COMMON_OPTIONS);

        //确定bulk是否完成
        boolean hasFailures = bulk.hasFailures();
        System.out.println(hasFailures);

        List<String> collect = Arrays.stream(bulk.getItems()).map(item -> {
            return item.getId();
        }).collect(Collectors.toList());

        log.info("文章添加完成:{},返回数据:{}", collect, bulk.toString());

        //有问题返回true
        return hasFailures;
    }
}
