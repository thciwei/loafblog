<template>
  <div id="layout-header" :class="{'fixed':fixed,'hidden':hidden}" @click.stop="mobileShow=false">
    <div class="site-logo">
      <router-link to="/">
        <!--                <img src="@/assets/site-logo.svg" alt="">-->
        <img src="@/assets/loaf.svg" alt="">
        <p class="site-name">loafBlog</p>
      </router-link>
    </div>
    <div class="menus-btn" @click.stop="mobileShow=!mobileShow">
      Menus
    </div>
    <div class="site-menus" :class="{'mobileShow':mobileShow}" @click.stop="mobileShow=!mobileShow">
      <div class="menu-item header-search">
        <header-search/>
      </div>
      <div class="menu-item">
        <router-link to="/">首页</router-link>
      </div>
      <div class="menu-item hasChild">
        <a href="#">文章</a>
        <div class="childMenu" v-if="category.length">
          <div class="sub-menu" v-for="item in category" :key="item.id">
            <router-link :to="`/category/${item.id}`" replace>{{ item.catename }}</router-link>
          </div>
        </div>
      </div>
      <div class="menu-item">
        <router-link to="/friend">友链</router-link>
      </div>
      <div class="menu-item">
        <router-link to="/about">关于</router-link>
      </div>
      <div class="menu-item1" style="margin-left: 20px">
        <el-dropdown @command="handleCommand">
        <span class="el-dropdown-link">
            <el-image :src="avatar" style="width: 40px;height: 40px;border-radius: 50%"></el-image>
        </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="login">登录</el-dropdown-item>
            <el-dropdown-item divided command="regist">注册</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>

      </div>
    </div>
    <el-dialog
        :append-to-body="true"
        :visible.sync="loginDialogVisible"
        width="30%"
        center>
      <span>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
  <el-form-item label="用户名" prop="loginacct">
    <el-input v-model="ruleForm.loginacct" placeholder="用户名/手机号"></el-input>
  </el-form-item>
           <el-form-item label="密码" prop="password">
    <el-input type="password" v-model="ruleForm.password" autocomplete="off"></el-input>
  </el-form-item>
        </el-form>
      </span>
      <div style="margin-top: 40px">
        <el-divider content-position="center"><p style="color: #6f6f6f">其他登录方式</p></el-divider>
        <span class="picGroup">
             <img src="../../icons/svg/weibo.svg" @click="goAuth('weibo')">


        <img src="../../icons/svg/qq.svg" >
        <img src="../../icons/svg/gitee.svg" @click="goAuth('gitee')">
        <img src="../../icons/svg/github.svg" @click="goAuth('github')">
       </span>
      </div>
      <span slot="footer" class="dialog-footer">
    <el-button @click="loginDialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="submitForm('ruleForm')">登 录</el-button>
  </span>
    </el-dialog>

    <el-dialog
        :append-to-body="true"
        :visible.sync="registDialogVisible"
        width="30%"
    >
      <span>
      <el-form :model="registRuleForm" status-icon :rules="registRules" ref="registRuleForm" label-width="100px"
               class="demo-ruleForm" style="margin-bottom: -30px">
          <el-form-item label="姓名" prop="username">
            <el-input v-model="registRuleForm.username"></el-input>
          </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="registRuleForm.password" autocomplete="off"></el-input>
        </el-form-item>


        <el-form-item label="手机号" prop="phone">
          <el-input v-model="registRuleForm.phone" autocomplete="off"></el-input>
        </el-form-item>
           <el-form-item label="验证码" prop="code">
             <el-input v-model="registRuleForm.code" autocomplete="off" style="width: 120px"
                       placeholder="请输入验证码"></el-input>
               <span class="red sendCode" @click="sendMessage">{{ btnText }}</span>
        </el-form-item>
      </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
    <el-button @click="registDialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="submitRegistForm('registRuleForm')">注 册</el-button>
      </span>
    </el-dialog>

  </div>

</template>

<script>
import HeaderSearch from '@/components/header-search'
import {fetchCategory} from '../../api'
import axios from "axios";

export default {
  name: "layout-header",
  components: {HeaderSearch},
  data() {
    return {
      lastScrollTop: 0,
      fixed: false,
      hidden: false,
      category: [],
      mobileShow: false,
      loginDialogVisible: false,
      registDialogVisible: false,

      btnDisabled: false,
      btnText: '获取验证码',

      avatar: "https://gitee.com/thciweicloud/tmp/raw/master/admin.png",
      ruleForm: {
        loginacct: '',
        password: ''
      },
      rules: {
        loginacct: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
      },
      registRuleForm: {
        username: '',
        password: '',
        phone: '',
        code: '',
      },
      registRules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},

        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},

        ],
        phone: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
        code: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ]
      },

    }
  },
  created() {
    this.jwtStorge()
  },
  mounted() {
    window.addEventListener('scroll', this.watchScroll)
    // this.fetchCategory()
    this.initCategory()
    this.getOauthUserInfo()
  },
  beforeDestroy() {
    window.removeEventListener("scroll", this.watchScroll)
  },
  methods: {
    //获取token的payload载荷
    getOauthUserInfo() {
      let tokenValue = window.localStorage.getItem('access-admin')
      if (tokenValue != undefined) {
        this.getRequest("/auth/" + tokenValue).then(resp => {
          if (resp) {
            this.avatar = resp.user.avatar
          }
        })

      }


    },
    getToken() {
      var url = window.document.location.href.toString();//获得当前url地址并转换成字符串
      console.log(url)
      var u = url.split("?");//以？来分割字符串，将？前后的值存到一个数组中
      if (typeof (u[1]) == "string") {//获得？后面具体的请求参数值
        u = u[1].split("&");
        var get = {};
        for (var i in u) {
          var j = u[i].split("=");
          get[j[0]] = j[1];
        }
        return get;
      }
    },
    parse() {
      // JSON.parse(window.localStorage.getItem('access-admin'))
      let token11 = this.getToken();
    },
    jwtStorge() {
      if (this.getToken() != null) {
        let token11 = this.getToken();
        let token = token11.accessToken
        window.localStorage.setItem('access-admin', token)
      }

    },
    goAuth(source) {
      this.getRequest("/auth/render/" + source).then(resp => {
        if (resp) {
          window.location.href = resp.url
        }

      })
    },
    sendMessage() {
      if (this.btnDisabled) {
        return;
      }
      if (this.registRuleForm.phone) {
        this.getRequest("/auth/sendcode", {"phone": this.registRuleForm.phone}).then(resp => {
          if (resp) {
            this.getSecond(60);
          }
        })
      }


    },
    //发送验证码
    getSecond(wait) {
      let _this = this;
      let _wait = wait;
      if (wait == 0) {
        this.btnDisabled = false;
        this.btnText = "获取验证码"
        wait = _wait;
      } else {
        this.btnDisabled = true;
        this.btnText = "验证码(" + wait + "s)"
        wait--;
        setTimeout(function () {
              _this.getSecond(wait);
            },
            1000);
      }
    },
    submitRegistForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log(this.registRuleForm)
          this.postRequest("/auth/regist", this.registRuleForm).then(resp => {
            if (resp) {
              this.registDialogVisible = false
            }
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.postRequest("/auth/login", this.ruleForm).then(resp => {
            if (resp) {
              this.loginDialogVisible = false
            }
          })
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    handleCommand(a) {
      if (a == 'login') {
        this.loginDialogVisible = true
      }
      if (a == 'regist') {
        this.registDialogVisible = true
      }
    },
    watchScroll() {
      let scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop
      if (scrollTop === 0) {
        this.fixed = false;
      } else if (scrollTop >= this.lastScrollTop) {
        this.fixed = false;
        this.hidden = true;
      } else {
        this.fixed = true
        this.hidden = false
      }
      this.lastScrollTop = scrollTop
    },
    initCategory() {
      this.getRequest('/blog/category/list').then(resp => {
        this.category = resp.page.list
        console.log(resp)
      })
    },
    fetchCategory() {
      fetchCategory().then(res => {
        this.category = res.data
      }).catch(err => {
        console.log(err)
      })
    }
  }
}
</script>

<style scoped lang="less">
.picGroup {
  padding-top: 0px;
  display: flex;
  justify-content: space-around;
}

.picGroup img {
  border-radius: 50%;
  width: 35px;
  height: 35px;
  cursor: pointer;
}

.sendCode {
  padding-left: 10px;
  border: 0;
  outline: none;
  background-color: #fff;
  cursor: pointer;
}

.el-dropdown-link {
  cursor: pointer;

}

.el-icon-arrow-down {
  font-size: 12px;
}

#layout-header {
  position: fixed;
  top: 0;
  z-index: 9;
  width: 100%;
  height: 80px;
  padding: 0 80px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  transition: .3s all ease;
  -webkit-transition: .3s all ease;
  -moz-transition: .3s all linear;
  -o-transition: .3s all ease;
  -ms-transition: .3s all ease;

  &.hidden {
    top: -100px;
  }

  &.fixed {
    background-color: #FFFFFF;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  }
}

.site-logo {
  text-align: center;

  img {
    width: 60px;
    height: 60px;
  }

  p.site-name {
    font-size: 15px;
    font-weight: bold;
    position: relative;
    top: -10px;
  }
}

.menus-btn {
  display: none;
  visibility: hidden;
}

.site-menus {
  display: flex;
  align-items: center;

  .menu-item {
    min-width: 60px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    position: relative;

    a {
      padding: 12px 10px;
      color: #545454;
      font-weight: 500;
      font-size: 16px;

      &:hover {
        color: #ff6d6d;
      }
    }

    &:not(:last-child) {
      margin-right: 15px;
    }

    &.hasChild:hover .childMenu {
      opacity: 1;
      visibility: visible;
      transform: translateY(-5px);
    }
  }

  .childMenu {
    width: 130px;
    background-color: #FDFDFD;
    border-radius: 3px;
    border: 1px solid #ddd;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    position: absolute;
    top: 55px;
    z-index: 2;
    opacity: 0;
    visibility: hidden;
    transition: .7s all ease;
    -webkit-transition: .6s all ease;
    -moz-transition: .6s all linear;
    -o-transition: .6s all ease;
    -ms-transition: .6s all ease;

    &:before, &:after {
      content: '';
      position: absolute;
      width: 0;
      height: 0;
      border-left: 6px solid transparent;
      border-right: 6px solid transparent;
      border-bottom: 8px solid white;
      top: -8px;
      left: 20px;
    }

    &:before {
      top: -9px;
      border-bottom: 8px solid #ddd;
    }

    .sub-menu {
      height: 40px;
      line-height: 40px;
      position: relative;

      &:not(:last-child):after {
        /*position: absolute;*/
        content: '';
        width: 50%;
        height: 1px;
        color: #ff6d6d;
        bottom: 0;
        left: 25%;
        z-index: 99;
      }
    }
  }
}

@media (max-width: 960px) {
  #layout-header {
    padding: 0 20px;
  }
}

@media (max-width: 600px) {
  #layout-header {
    padding: 0 10px;
  }

  .menus-btn {
    display: block;
    visibility: visible;
  }

  .site-menus {
    position: absolute;
    display: none;
    visibility: hidden;
    background-color: #F9F9F9;
    width: 100%;
    left: 0;
    top: 80px;
    z-index: -9;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);

    .menu-item {
      position: relative;
      height: unset;

      &:not(:last-child) {
        margin-right: 0;
      }
    }

    .childMenu {
      position: relative;
      width: 100%;
      top: 0;
      background-color: #F3F3F3;
      opacity: 1;
      visibility: visible;
      border: none;
      box-shadow: none;

      &:before, &:after {
        content: '';
        position: relative;
        width: 0;
        height: 0;
        border-left: 0;
        border-right: 0;
        border-bottom: 0;
      }
    }
  }

  .site-menus.mobileShow {
    display: inline-block;
    visibility: visible;
    z-index: 99;
  }
}
</style>
