package com.thciwei.loafblog.blog.vo;

import com.thciwei.loafblog.blog.entity.CommentEntity;
import lombok.Data;

import java.util.List;

@Data
public class CommentVo {
    private CommentEntity comment;
    private List<CommentEntity> reply;
}
