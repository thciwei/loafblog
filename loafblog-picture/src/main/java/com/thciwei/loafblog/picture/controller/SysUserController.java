package com.thciwei.loafblog.picture.controller;

import java.util.Arrays;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.thciwei.loafblog.picture.entity.SysUserEntity;
import com.thciwei.loafblog.picture.service.SysUserService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;



/**
 * 系统用户
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-12 16:22:55
 */
@RestController
@RequestMapping("picture/sysuser")
public class SysUserController {
    @Autowired
    private SysUserService sysUserService;


    @GetMapping("/userNumber")
    public Integer getUserNumber(){
        return sysUserService.getUserNumber();
    }
    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = sysUserService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{userId}")
    public R info(@PathVariable("userId") Long userId){
		SysUserEntity sysUser = sysUserService.getById(userId);

        return R.ok().put("sysUser", sysUser);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody SysUserEntity sysUser){
		sysUserService.save(sysUser);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody SysUserEntity sysUser){
		sysUserService.updateById(sysUser);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] userIds){
		sysUserService.removeByIds(Arrays.asList(userIds));

        return R.ok();
    }

}
