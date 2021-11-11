package com.thciwei.loafblog.picture.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.picture.entity.FastdfsfileEntity;

import java.util.List;
import java.util.Map;

/**
 * fastdfs存储文件
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-13 23:09:02
 */
public interface FastdfsfileService extends IService<FastdfsfileEntity> {

    PageUtils queryPage(Map<String, Object> params);

    Integer upload(String url,String fileId);

    List<FastdfsfileEntity> getFileList();
}

