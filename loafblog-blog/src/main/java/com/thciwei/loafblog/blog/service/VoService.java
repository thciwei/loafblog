package com.thciwei.loafblog.blog.service;

import com.thciwei.loafblog.blog.vo.PanelGroupVo;
import com.thciwei.loafblog.blog.vo.DataVo;
import com.thciwei.loafblog.blog.vo.PieVo;

import java.util.List;

public interface VoService {

    PanelGroupVo getPanelGroup();


    PieVo getCategoryPie();

    PieVo getTagPie();
}
