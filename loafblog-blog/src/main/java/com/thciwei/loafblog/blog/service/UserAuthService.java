package com.thciwei.loafblog.blog.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.thciwei.common.utils.PageUtils;
import com.thciwei.loafblog.blog.entity.UserAuthEntity;
import com.thciwei.loafblog.blog.exception.PhoneExistException;
import com.thciwei.loafblog.blog.exception.UserExistException;
import com.thciwei.loafblog.blog.vo.SocialUser;
import com.thciwei.loafblog.blog.vo.UserLoginVo;
import com.thciwei.loafblog.blog.vo.UserRegistVo;
import org.apache.ibatis.annotations.Param;

import java.io.IOException;
import java.util.Map;

/**
 *
 *
 * @author wangqiaosong
 * @email wangqiaosong@gmail.com
 * @date 2021-10-05 17:10:35
 */
public interface UserAuthService extends IService<UserAuthEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void regist(UserRegistVo vo);

    void checkPhoneExist(String phone) throws PhoneExistException;

    void checkUserExist(String username) throws UserExistException;

    UserAuthEntity login(UserLoginVo vo);

    UserAuthEntity login(@Param("socialUser") SocialUser socialUser, @Param("token") String token) throws Exception;
}

