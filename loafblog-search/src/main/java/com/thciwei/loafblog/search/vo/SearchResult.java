package com.thciwei.loafblog.search.vo;

import com.thciwei.common.to.es.ArticleEsModel;
import lombok.Data;

import java.util.List;
@Data
public class SearchResult {
    //查询到的商品信息
    private List<ArticleEsModel> articles;
    /**
     * 以下是分页信息
     */
    //当前页码
    private Integer pageNum;
    //总记录数
    private Long total;
    //总页码
    private Integer totalPages;

    private List<CategoryVo> categorys;
    //查到的结果分类
    private List<TagVo> tags;

    private List<Integer> pageNavs;


//========以下是所有分类信息=================//

    @Data
    public static class CategoryVo {
        private Integer id;
        private String cateName;
    }

    @Data
    public static class TagVo {
        private Integer id;
        private String tagName;
    }



}
