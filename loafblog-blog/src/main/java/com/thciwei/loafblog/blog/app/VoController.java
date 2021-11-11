package com.thciwei.loafblog.blog.app;

import com.thciwei.common.utils.R;
import com.thciwei.loafblog.blog.feign.SysUserFeign;
import com.thciwei.loafblog.blog.service.CategoryService;
import com.thciwei.loafblog.blog.service.TagsService;
import com.thciwei.loafblog.blog.service.VoService;
import com.thciwei.loafblog.blog.vo.PanelGroupVo;
import com.thciwei.loafblog.blog.vo.PieVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("blog/vo")
public class VoController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    TagsService tagsService;
    @Autowired
    VoService voService;
    @Autowired
    SysUserFeign sysUserFeign;


    @GetMapping("/category")
    public R getCateNames() {

        List<String> data = categoryService.getCateNames();

        return R.ok().put("data", data);
    }

    @GetMapping("/tags")
    public R getTagNames() {

        List<String> data = tagsService.getTagNames();

        return R.ok().put("data", data);
    }
    //TODO 1、完成首页评论和ip数的对接
    @GetMapping("/panelGroup")
    public R getPanelGroup() {

        PanelGroupVo data = voService.getPanelGroup();

        return R.ok().put("data", data);

    }

    @GetMapping("/catepie")
    public R getCategoryPie() {
        PieVo data = voService.getCategoryPie();
        return R.ok().put("data", data);

    }

    @GetMapping("/tagpie")
    public R getTagPie(){
        PieVo data = voService.getTagPie();
        return R.ok().put("data", data);
    }


}
