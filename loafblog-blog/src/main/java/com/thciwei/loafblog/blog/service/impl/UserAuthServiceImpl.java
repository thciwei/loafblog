package com.thciwei.loafblog.blog.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.thciwei.common.utils.*;
import com.thciwei.loafblog.blog.dao.UserAuthDao;
import com.thciwei.loafblog.blog.entity.UserAuthEntity;
import com.thciwei.loafblog.blog.exception.PhoneExistException;
import com.thciwei.loafblog.blog.exception.UserExistException;
import com.thciwei.loafblog.blog.service.UserAuthService;
import com.thciwei.loafblog.blog.vo.SocialUser;
import com.thciwei.loafblog.blog.vo.UserLoginVo;
import com.thciwei.loafblog.blog.vo.UserRegistVo;
import io.jsonwebtoken.Claims;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Service("UserAuthService")
public class UserAuthServiceImpl extends ServiceImpl<UserAuthDao, UserAuthEntity> implements UserAuthService {


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<UserAuthEntity> page = this.page(
                new Query<UserAuthEntity>().getPage(params),
                new QueryWrapper<UserAuthEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public void regist(UserRegistVo vo) {
        UserAuthDao userAuthDao = this.baseMapper;

        UserAuthEntity userAuthEntity = new UserAuthEntity();

        //检查用户名和电话是否存在,不存在抛出异常
        checkPhoneExist(vo.getPhone());
        checkUserExist(vo.getUsername());

        userAuthEntity.setMobile(vo.getPhone());
        userAuthEntity.setUsername(vo.getUsername());

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String password = passwordEncoder.encode(vo.getPassword());
        userAuthEntity.setPassword(password);

        userAuthDao.insert(userAuthEntity);
    }

    @Override
    public void checkPhoneExist(String phone) throws PhoneExistException {
        UserAuthDao userAuthDao = this.baseMapper;
        Integer entity = userAuthDao.selectCount(new QueryWrapper<UserAuthEntity>().eq("mobile", phone));
        if (entity > 0) {
            throw new PhoneExistException();
        }

    }

    @Override
    public void checkUserExist(String username) throws UserExistException {
        UserAuthDao userAuthDao = this.baseMapper;
        Integer entity = userAuthDao.selectCount(new QueryWrapper<UserAuthEntity>().eq("username", username));
        if (entity > 0) {
            throw new UserExistException();
        }

    }

    @Override
    public UserAuthEntity login(UserLoginVo vo) {

        String loginacct = vo.getLoginacct();
        String password = vo.getPassword();
        UserAuthEntity entity = this.baseMapper.selectOne(new QueryWrapper<UserAuthEntity>().eq("username", loginacct).or().eq("mobile", loginacct));
        if (entity == null) {
            return null;
        } else {
            String passwordDB = entity.getPassword();
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            boolean matches = passwordEncoder.matches(password, passwordDB);
            if (matches) {
                return entity;
            } else {
                return null;
            }
        }
    }

    @Override
    public UserAuthEntity login(SocialUser socialUser, String token) throws Exception {

        String uid = socialUser.getUid();

        UserAuthEntity userAuthEntity = this.baseMapper.selectOne(new QueryWrapper<UserAuthEntity>().eq("social_uid", uid));
        if (userAuthEntity != null) {
            //更新token
            UserAuthEntity authEntity = new UserAuthEntity();
            authEntity.setId(userAuthEntity.getId());
            authEntity.setAccessToken(socialUser.getAccess_token());
            authEntity.setExpiresIn(socialUser.getExpires_in());

            this.baseMapper.updateById(authEntity);
            userAuthEntity.setAccessToken(socialUser.getAccess_token());
            userAuthEntity.setExpiresIn(socialUser.getExpires_in());
            return userAuthEntity;
        } else {
            //注册
            UserAuthEntity regist = new UserAuthEntity();
            R r = JwtUtil.parse(token);
//            Claims user = r.getData("user", new TypeReference<Claims>() {
//            });
            Claims user = (Claims) r.get("user");

            String username= JSON.toJSONString(user.get("username"));
            String avatar= JSON.toJSONString(user.get("avatar"));
            String userUid = socialUser.getUid();
            String access_token = socialUser.getAccess_token();
            String expires_in = socialUser.getExpires_in();
            regist.setSocialUid(userUid);
            regist.setNickname(username);
            regist.setExpiresIn(expires_in);
            regist.setAccessToken(access_token);
            regist.setHeader(avatar);
            this.baseMapper.insert(regist);
//            //注册
//            UserAuthEntity regist = new UserAuthEntity();
//            //查询当前社交用户的社交账号信息
//            HashMap<String, String> query = new HashMap<>();
//            query.put("access_token", socialUser.getAccess_token());
//            query.put("uid", socialUser.getUid());
//            HttpResponse response = HttpUtils.doGet("https://api.weibo.com", "/2/users/show.json", "get", new HashMap<String, String>(), query);
//            if (response.getStatusLine().getStatusCode() == 200) {
//                //查询成功  apache提供EntityUtils
//                String json = EntityUtils.toString(response.getEntity());
//                //fastjson string转为json并可以取值
//                JSONObject jsonObject = JSON.parseObject(json);
//                //昵称...   拿去登录返回值
//                String name = jsonObject.getString("name");
//                String gender = jsonObject.getString("gender");
//                String header = jsonObject.getString("profile_image_url");
//                //...
//                regist.setNickname(name);
//                regist.setGender("m".equals(gender) ? 1 : 0);
//                regist.setHeader(header);
//                regist.setSocialUid(socialUser.getUid());
//                regist.setAccessToken(socialUser.getAccess_token());
//                regist.setExpiresIn(socialUser.getExpires_in());
//                this.baseMapper.insert(regist);
//            }

            return regist;


        }


    }


}
