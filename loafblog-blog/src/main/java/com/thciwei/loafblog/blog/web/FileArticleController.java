package com.thciwei.loafblog.blog.web;

import com.thciwei.common.utils.R;
import com.thciwei.loafblog.blog.service.ArticleService;
import com.thciwei.loafblog.blog.vo.ArticleFileVo;
import com.thciwei.loafblog.blog.vo.TagsCloudVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("blog/web")
public class FileArticleController {
    @Autowired
    ArticleService articleService;

    /**
     * 获得归档的文章数据
     *
     * @return
     */
    @GetMapping("/file")
    public R getArticleByTime() {
        List<ArticleFileVo> data = articleService.getArticleByTime();
        return R.ok().put("data", data);
    }

    /**
     * 归档处标签云
     */
    @GetMapping("/tags")
    public R getTags() {
        List<TagsCloudVo> data = articleService.getTagsCloud();
        return R.ok().put("data", data);
    }


}
