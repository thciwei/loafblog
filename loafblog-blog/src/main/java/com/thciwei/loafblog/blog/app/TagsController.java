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

import com.thciwei.loafblog.blog.entity.TagsEntity;
import com.thciwei.loafblog.blog.service.TagsService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;



/**
 * 标签属性
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-04 10:29:57
 */
@RestController
@RequestMapping("blog/tags")
public class TagsController {
    @Autowired
    private TagsService tagsService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("blog:tags:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = tagsService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("blog:tags:info")
    public R info(@PathVariable("id") Integer id){
		TagsEntity tags = tagsService.getById(id);

        return R.ok().put("tags", tags);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("blog:tags:save")
    public R save(@RequestBody TagsEntity tags){
		tagsService.save(tags);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
   // @RequiresPermissions("blog:tags:update")
    public R update(@RequestBody TagsEntity tags){
		tagsService.updateById(tags);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("blog:tags:delete")
    public R delete(@RequestBody Integer[] ids){
		tagsService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
