package com.thciwei.loafblog.blog.app;

import java.util.Arrays;
import java.util.Map;

import com.thciwei.common.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.thciwei.loafblog.blog.entity.ArticleCategoryEntity;
import com.thciwei.loafblog.blog.service.ArticleCategoryService;
import com.thciwei.common.utils.PageUtils;


/**
 * 博客所在的分类
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@RestController
@RequestMapping("blog/articlecategory")
public class ArticleCategoryController {
    @Autowired
    private ArticleCategoryService articleCategoryService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = articleCategoryService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		ArticleCategoryEntity articleCategory = articleCategoryService.getById(id);

        return R.ok().put("articleCategory", articleCategory);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ArticleCategoryEntity articleCategory){
		articleCategoryService.save(articleCategory);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ArticleCategoryEntity articleCategory){
		articleCategoryService.updateById(articleCategory);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		articleCategoryService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
