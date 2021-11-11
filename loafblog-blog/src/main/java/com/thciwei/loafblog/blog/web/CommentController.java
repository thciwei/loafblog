package com.thciwei.loafblog.blog.web;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.thciwei.loafblog.blog.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.thciwei.loafblog.blog.entity.CommentEntity;
import com.thciwei.loafblog.blog.service.CommentService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;


/**
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-25 13:50:49
 */
@RestController
@RequestMapping("blog/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    /**
     * 获取评论与被评论信息
     */
    @GetMapping("/commentList/{postId}")
    public R getComments(@PathVariable("postId") Integer postId) {
        List<CommentVo> data = commentService.getComments(postId);
        return R.ok().put("data", data);
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = commentService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id) {
        CommentEntity comment = commentService.getById(id);

        return R.ok().put("comment", comment);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody CommentEntity comment) {
        comment.setCreatetime(new Date());
        commentService.save(comment);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody CommentEntity comment) {
        commentService.updateById(comment);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids) {
        commentService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}

