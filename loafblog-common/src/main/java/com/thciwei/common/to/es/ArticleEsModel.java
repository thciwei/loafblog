package com.thciwei.common.to.es;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
public class ArticleEsModel implements Serializable {

    private Integer id;
    private String title;
    private Integer tid;
    private Integer cid;
    private String mdcontent;
    private String htmlcontent;
    private String summary;
    private String image;
    @JsonFormat(timezone = "GMT+8")
    private Date publishdate;
    private Boolean isoriginal;
    private Boolean iscomment;
    private Integer number;
    private Integer state;
    private String cateName;
    private String tagName;
    private Long hotScore; //es热度评分
}
