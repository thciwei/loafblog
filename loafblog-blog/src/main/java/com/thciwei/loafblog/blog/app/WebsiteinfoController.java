package com.thciwei.loafblog.blog.app;

import java.util.Arrays;
import java.util.Map;

import com.thciwei.loafblog.blog.service.WebsiteinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.thciwei.loafblog.blog.entity.WebsiteinfoEntity;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;


/**
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-16 19:05:42
 */
@RestController
@RequestMapping("blog/websiteinfo")
public class    WebsiteinfoController {
    @Autowired
    private WebsiteinfoService websiteinfoService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = websiteinfoService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id) {
        WebsiteinfoEntity websiteinfo = websiteinfoService.getById(id);

        return R.ok().put("websiteinfo", websiteinfo);
    }

    @PostMapping("/savemail")
    public R save2(@RequestBody WebsiteinfoEntity websiteinfo) {
        // websiteinfoService.save(websiteinfo);
        if (websiteinfoService.saveAndMail(websiteinfo) == 1) {

            return R.ok("修改成功");
        }
        return R.error("修改失败");
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody WebsiteinfoEntity websiteinfo) {
        //websiteinfoService.save(websiteinfo);
        if (websiteinfoService.saveAndMail(websiteinfo) == 1) {

            return R.ok("添加成功");
        }
        return R.error("添加失败");
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody WebsiteinfoEntity websiteinfo) {
        websiteinfoService.updateById(websiteinfo);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids) {
        websiteinfoService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
