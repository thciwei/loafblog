package com.thciwei.loafblog.picture.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * fastdfs存储文件
 * 
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-09-13 23:09:02
 */
@Data
@TableName("fastdfsFile")
public class FastdfsfileEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private Integer id;
	/**
	 * 文件url
	 */
	private String url;
	/**
	 * 文件名
	 */
	private String fastname;

}
