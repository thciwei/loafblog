package com.thciwei.loafblog.blog.app;

import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;
import com.thciwei.loafblog.blog.entity.InfoEntity;
import com.thciwei.loafblog.blog.service.InfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("blog/info")
public class InfoController {
    @Autowired
    private InfoService infoService;

    /**
     * 获取未读的信息数量
     */
    @GetMapping("/noview")
    public R getMessageNoViewCount() {
      Integer count=  infoService.getMessageNoViewCount();
        return R.ok("").put("count",count);
    }

    /**
     * message更新已读
     *
     * @return
     */
    @PostMapping("/updateview/{id}")
    public R updateView(@PathVariable("id") Integer id) {
        if (infoService.updateView(id) == 1) {
            return R.ok("修改成功");
        }
        return R.error("修改失败");
    }

    @GetMapping("/list2")
    public R List2() {
        List<InfoEntity> data = infoService.getList();
        return R.ok().put("data", data);
    }


    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = infoService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id) {
        InfoEntity info = infoService.getById(id);

        return R.ok().put("info", info);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody InfoEntity info) {
        if (infoService.save(info)) {
            return R.ok();
        }
        return R.error("失败");
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody InfoEntity info) {
        infoService.updateById(info);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids) {
        infoService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
