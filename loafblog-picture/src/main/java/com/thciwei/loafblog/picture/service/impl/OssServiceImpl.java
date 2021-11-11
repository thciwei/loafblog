package com.thciwei.loafblog.picture.service.impl;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.OSSObjectSummary;
import com.aliyun.oss.model.ObjectListing;
import com.thciwei.loafblog.picture.entity.OssEntity;
import com.thciwei.loafblog.picture.service.OssService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class OssServiceImpl implements OssService {
    @Value("${spring.cloud.alicloud.oss.endpoint}")
    private String endpoint1;
    @Value("${spring.cloud.alicloud.oss.bucket}")
    private String bucketName;
    @Value("${spring.cloud.alicloud.access-key}")
    private String accessKeyId;
    @Value("${spring.cloud.alicloud.secret-key}")
    private String accessKeySecret;

    @Override
    public List<OssEntity> getOssList() {
        String endpoint = "http://" + endpoint1;
        String prefix = "http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/";

        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

       // 列举文件。如果不设置KeyPrefix，则列举存储空间下的所有文件。如果设置KeyPrefix，则列举包含指定前缀的文件。
        ObjectListing objectListing = ossClient.listObjects(bucketName);
        List<OSSObjectSummary> sums = objectListing.getObjectSummaries();
        List<OssEntity> collect = sums.stream().map(item -> {
            OssEntity ossEntity = new OssEntity();
            ossEntity.setUrl(prefix + item.getKey());
            ossEntity.setName(item.getKey());
            return ossEntity;
        }).collect(Collectors.toList());


        // 关闭OSSClient。
        ossClient.shutdown();
        return collect;
    }

}
