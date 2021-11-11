package com.thciwei.loafblog.blog.vo;

import lombok.Data;

import java.util.Date;

@Data
public class ArticleFileVo {

    private Integer id;
    private String title;
    private String image;
    private Date publishdate;
    private String color;
}
