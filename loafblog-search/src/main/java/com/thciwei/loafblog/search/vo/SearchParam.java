package com.thciwei.loafblog.search.vo;

import lombok.Data;

@Data
public class SearchParam {
    private String keyword;
    private Integer pageNum = 1;

}
