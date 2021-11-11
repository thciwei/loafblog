package com.thciwei.loafblog.blog.vo;

import lombok.Data;

import java.util.List;


@Data
public class PieVo {
    private List<String> names;
    private List<DataVo> values;
}
