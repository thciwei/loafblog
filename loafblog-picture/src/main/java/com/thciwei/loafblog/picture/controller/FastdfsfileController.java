package com.thciwei.loafblog.picture.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.thciwei.loafblog.picture.utils.FastDFSUtils;
import org.csource.common.MyException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import com.thciwei.loafblog.picture.entity.FastdfsfileEntity;
import com.thciwei.loafblog.picture.service.FastdfsfileService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.common.utils.R;
import org.springframework.web.multipart.MultipartFile;


/**
 * fastdfs存储文件
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-13 23:09:02
 */
@RestController
@RequestMapping("picture/fastdfsfile")
public class FastdfsfileController {
    @Autowired
    private FastdfsfileService fastdfsfileService;

    @Value("${fastdfs.nginx.host}")
    String nginxHost;

    @GetMapping("/fileList")
    public R getFileList() {
        List<FastdfsfileEntity> data = fastdfsfileService.getFileList();
        return R.ok().put("data", data);
    }


    /**
     * 上传文件到 fastDFS
     *
     * @param file
     * @return
     * @throws MyException
     * @throws IOException
     */
    @PostMapping("/upload")
    public R upload(MultipartFile file) throws MyException, IOException {

        String fileId = FastDFSUtils.upload(file);
        String url = nginxHost + fileId;
        if (fastdfsfileService.upload(url, fileId) == 1) {
            return R.ok("上传成功").put("url", url).put("code", 200);
        }
        return R.error("上传失败");
    }


    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = fastdfsfileService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id) {
        FastdfsfileEntity fastdfsfile = fastdfsfileService.getById(id);

        return R.ok().put("fastdfsfile", fastdfsfile);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody FastdfsfileEntity fastdfsfile) {
        fastdfsfileService.save(fastdfsfile);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody FastdfsfileEntity fastdfsfile) {
        fastdfsfileService.updateById(fastdfsfile);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids) {
        fastdfsfileService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
