package com.thciwei.loafblog.blog.app;

import java.util.Arrays;
import java.util.Map;

//import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.thciwei.loafblog.blog.entity.ArticleTagsEntity;
import com.thciwei.loafblog.blog.service.ArticleTagsService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;



/**
 * 博客和标签的对应关系
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@RestController
@RequestMapping("blog/articletags")
public class ArticleTagsController {
    @Autowired
    private ArticleTagsService articleTagsService;

    /**
     * 列表
     */
    @RequestMapping("/list")
  //  @RequiresPermissions("blog:articletags:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = articleTagsService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
   // @RequiresPermissions("blog:articletags:info")
    public R info(@PathVariable("id") Integer id){
		ArticleTagsEntity articleTags = articleTagsService.getById(id);

        return R.ok().put("articleTags", articleTags);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
   // @RequiresPermissions("blog:articletags:save")
    public R save(@RequestBody ArticleTagsEntity articleTags){
		articleTagsService.save(articleTags);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
   // @RequiresPermissions("blog:articletags:update")
    public R update(@RequestBody ArticleTagsEntity articleTags){
		articleTagsService.updateById(articleTags);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
   // @RequiresPermissions("blog:articletags:delete")
    public R delete(@RequestBody Integer[] ids){
		articleTagsService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
