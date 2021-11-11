package com.thciwei.loafblog.search.service.impl;

import com.alibaba.fastjson.JSON;
import com.thciwei.common.to.es.ArticleEsModel;
import com.thciwei.loafblog.search.config.LoafblogEsConfig;
import com.thciwei.loafblog.search.constant.EsConstant;
import com.thciwei.loafblog.search.service.BlogSearchService;
import com.thciwei.loafblog.search.vo.SearchParam;
import com.thciwei.loafblog.search.vo.SearchResult;
import org.apache.commons.lang.StringUtils;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.MultiMatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service("blogSearchService")
public class BlogSearchServiceImpl implements BlogSearchService {
    @Autowired
    RestHighLevelClient client;

    @Override
    public SearchResult search(SearchParam param) {
        //1、动态构建出查询需要的DSL语句
        SearchResult result = null;
        //1、准备检索请求
        SearchRequest searchRequest = buildSearchRequest(param);
        try {
            //2、执行检索请求
            SearchResponse response = client.search(searchRequest, LoafblogEsConfig.COMMON_OPTIONS);

            //3、分析响应数据封装成我们需要的格式
            result = buildSearchResult(response, param);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;

    }

    /**
     * 准备es检索请求
     *
     * @param param
     * @return
     */
    private SearchRequest buildSearchRequest(SearchParam param) {

        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
        //1、构建bool查询
        BoolQueryBuilder boolQuery = QueryBuilders.boolQuery();
        //1.1、bool-must 模糊匹配
        if (!StringUtils.isEmpty(param.getKeyword())) {

            boolQuery.must(QueryBuilders.multiMatchQuery(param.getKeyword(), "title", "summary", "mdcontent"));
        }

        //1.2、bool-filter
        if (!StringUtils.isEmpty(param.getKeyword())) {
            boolQuery.filter(QueryBuilders.termQuery("state", 0));
        }
        sourceBuilder.query(boolQuery);
        /**
         * 分页、高亮
         */
        //2.1、分页
        sourceBuilder.from((param.getPageNum() - 1) * EsConstant.ARTICLE_PAGESIZE);
        sourceBuilder.size(EsConstant.ARTICLE_PAGESIZE);
        //2.2、高亮
        if (!StringUtils.isEmpty(param.getKeyword())) {
            HighlightBuilder builder = new HighlightBuilder();
//            HighlightBuilder.Field field1 = new HighlightBuilder.Field("title");
//            HighlightBuilder.Field field2 = new HighlightBuilder.Field("summary");
//            List<HighlightBuilder.Field> fieldList = new ArrayList<>();
//            fieldList.add(field1);
//            fieldList.add(field2);
            builder.field("title").preTags("<b style='color:#b4251d'>").postTags("</b>");
//            builder.fields().addAll(fieldList);
            builder.field("summary").preTags("<b style='color:#b4251d'>").postTags("</b>");
            sourceBuilder.highlighter(builder);
        }

        /**
         * 获得 DSL 便于测试
         */
        String s = sourceBuilder.toString();
        System.out.println("构建的DSL>>" + s);


        SearchRequest searchRequest = new SearchRequest(new String[]{
                EsConstant.ARTICLE_INDEX
        }, sourceBuilder);
        return searchRequest;
    }


    /**
     * 构建数据结果
     *
     * @param response
     * @return
     */
    private SearchResult buildSearchResult(SearchResponse response, SearchParam param) {
        SearchResult result = new SearchResult();
        SearchHits hits = response.getHits();
        List<ArticleEsModel> esModels = new ArrayList<>();
        if (hits.getHits() != null && hits.getHits().length > 0) {
            for (SearchHit hit : hits) {
                String sourceAsString = hit.getSourceAsString();
                ArticleEsModel articleEsModel = JSON.parseObject(sourceAsString, ArticleEsModel.class);
                if (!StringUtils.isEmpty(param.getKeyword())) {
                    HighlightField title = hit.getHighlightFields().get("title");
                    //TODO 1、探究为什么不判空就会报空指针错误
                    if(title!=null){
                        String stringTitle = title.getFragments()[0].string();
                        articleEsModel.setTitle(stringTitle);
                    }
                    HighlightField summary = hit.getHighlightFields().get("summary");
                    if(summary!=null){
                        String stringSummary = summary.getFragments()[0].string();
                        articleEsModel.setSummary(stringSummary);
                    }

                }
                esModels.add(articleEsModel);

            }
        }
        result.setArticles(esModels);

        //<========分页等信息=======>
        result.setPageNum(param.getPageNum());
        long total = hits.getTotalHits().value;
        result.setTotal(total);
        int totalPages = (int) total % EsConstant.ARTICLE_PAGESIZE == 0 ? (int) total / EsConstant.ARTICLE_PAGESIZE : ((int) total / EsConstant.ARTICLE_PAGESIZE + 1);
        result.setTotalPages(totalPages);
        List<Integer> pageNavs = new ArrayList<>();
        for (int i = 1; i < totalPages; i++) {
            pageNavs.add(i);
        }
        result.setPageNavs(pageNavs);
        return result;
    }
}
