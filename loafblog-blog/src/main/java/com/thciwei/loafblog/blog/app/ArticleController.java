package com.thciwei.loafblog.blog.app;

import java.io.IOException;
import java.util.*;

//import org.apache.shiro.authz.annotation.RequiresPermissions;
import com.thciwei.loafblog.blog.entity.CategoryEntity;
import com.thciwei.loafblog.blog.entity.TagsEntity;
import com.thciwei.loafblog.blog.vo.ArticleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.thciwei.loafblog.blog.entity.ArticleEntity;
import com.thciwei.loafblog.blog.service.ArticleService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;


/**
 * 博客内容和属性
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@RestController
@RequestMapping("blog/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;

    @GetMapping("/getByYearMonth/{year}/{month}")
    public R getByYearMonth(@PathVariable("year") String year, @PathVariable("month") String month) {

        List<ArticleEntity> data = articleService.getByYearMonth(year, month);
        return R.ok().put("data", data);
    }


    /**
     * 获取去重且格式化的时间 y年 m月
     *
     * @return
     */
    @GetMapping("/gettimes")
    public R getArticleTimes() {
        List<String> data = articleService.getArticleTimes();
        return R.ok().put("data", data);
    }

    /**
     * 移动端分类获取文章
     *
     * @param cid
     * @return
     */
    @GetMapping("/uni/{cid}")
    public R getArticleByCid(@PathVariable("cid") Integer cid) {
        List<ArticleVo> data = articleService.getArticleByCid(cid);
        return R.ok().put("data", data);
    }

    /**
     * 门户由首页跳转文章页
     *
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public R getArticleById(@PathVariable("id") Integer id) {
        ArticleVo data = articleService.getArticleById(id);
        return R.ok().put("data", data);
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = articleService.queryPage(params);


        return R.ok().put("page", page);
    }


    /**
     * 后台展示文章信息
     *
     * @param params
     * @return
     */
    @GetMapping("/tagCate")
    public R datalist(@RequestParam Map<String, Object> params) {
        PageUtils page = articleService.queryPage3(params);

        return R.ok().put("page", page);
    }

    /**
     * 获取文章所有分类
     *
     * @return
     */
    @GetMapping("/categorys")
    public R getCategorys() {
        List<CategoryEntity> data = articleService.getCategorys();
        return R.ok().put("data", data);
    }

    /**
     * 获取文章所有标签
     *
     * @return
     */
    @GetMapping("/tags")
    public R getTags() {
        List<TagsEntity> data = articleService.getTags();
        return R.ok().put("data", data);
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id) {
        ArticleEntity article = articleService.getById(id);

        return R.ok().put("article", article);
    }

    /**
     * 新增博客
     */
    @RequestMapping("/save")
    public R save(@RequestBody ArticleEntity article) throws IOException {
        article.setPublishdate(new Date());

        // articleService.save(article);
        articleService.saveArticle(article);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ArticleEntity article) {
        articleService.updateById(article);

        return R.ok();
    }

    /**
     * 删除-逻辑删除，仍保留在数据库
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids) {
        articleService.deleteByIds(Arrays.asList(ids));
        //articleService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }


//废弃自定义sql方法
    @GetMapping("/tagAndCate")
    public R list2() {
        List<ArticleVo> data = articleService.getTagAndCategory();
        return R.ok().put("data", data);

    }

}
