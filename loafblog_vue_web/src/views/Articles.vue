<template>

  <div class="articles">
    <banner></banner>
    <div class="site-content animate" @scroll="scrollEvent">
      <!-- 文章目录 -->
      <div id="article-menus">
        <!--        <menu-tree :menus="menus" child-label="child"></menu-tree>-->
        <p style="font-size: 20px">目录导航</p>
        <ul class="menuul">
          <li v-for="(item,index) in menus" :key="index" @click="jump(index)" :class="{active:catalogCur==index}">
            * {{ item.innerHTML }}
          </li>
        </ul>
      </div>
      <main class="site-main" @scroll="scrollEvent">
        <article class="hentry">
          <!-- 文章头部 -->
          <header class="entry-header">
            <!-- 标题输出 -->
            <h1 class="entry-title">{{ article.title }}</h1>
            <hr>
            <div class="breadcrumbs">
              <div id="crumbs">最后更新时间：{{ article.publishdate }}</div>
            </div>
          </header>
          <!-- 正文输出 -->

          <div class="entry-content" v-html="article.htmlcontent">
          </div>

          <!-- 文章底部 -->
          <section-title>

            <footer class="post-footer">

              <!-- 阅读次数 -->
              <div class="post-like">

                <i class="iconfont iconeyes"></i>
                <span class="count">685</span>

              </div>
              <!-- 赞助按钮 -->
              <div class="donate" @click="showDonate=!showDonate">
                <span>赏</span>
                <ul class="donate_inner" :class="{'show':showDonate}">
                  <li class="wedonate"><img src="http://cdn.fengziy.cn/gblog/wexin_pay.png">
                    <p>微信</p></li>
                  <li class="alidonate"><img src="http://cdn.fengziy.cn/gblog/ali_pay.jpg">
                    <p>支付宝</p></li>
                </ul>
              </div>
              <!-- 文章标签 -->
              <div class="post-tags">
                <i class="iconfont iconcategory"></i>
                <router-link to="/category/web">Web</router-link>
                <div style="display: flex;justify-content: center;width: 300px;margin-top: -15px">
                  <div style="margin-top: -40px;width: 80px">
                    <vue-star animate="animated bounceIn" color="rgb(152, 138, 222)">
                      <img class="img" v-if="nopraise" slot="icon" src="../icons/svg/praise.svg" @click="canview"/>
                      <img class="img" v-if="ispraise" slot="icon"
                           src="../icons/svg/icon-praise.svg" @click="noview"/>
                      <!--                      <i slot="icon" class="el-icon-edit"></i>-->
                    </vue-star>
                  </div>
                  <div style="font-size: 15px"><p>点赞</p></div>
                </div>
              </div>

            </footer>

          </section-title>

          <!--声明-->
          <div class="open-message">
            <p>声明：loafBlog博客|版权所有，违者必究|如未注明，均为原创|本网站采用<a href="https://creativecommons.org/licenses/by-nc-sa/3.0/"
                                                         target="_blank">BY-NC-SA</a>协议进行授权</p>
            <p>转载：转载请注明原文链接 - <a href="/">{{ article.title }}</a></p>
          </div>
          <!--评论-->
          <div class="comments">
            <div v-if="showCommentEditorParent" @click.stop="">
              <comment-message-editor :inline="true" buttonText="回复" @submit="submitReply"></comment-message-editor>
            </div>
            <comment v-for="item in this.$store.state.socialComments" :key="item.comment.id"
                     :comment.sync="item.comment">
              <template v-if="item.reply.length">
                <comment v-for="reply in item.reply" :key="reply.id" :comment.sync="reply"></comment>
              </template>
            </comment>
          </div>
        </article>
      </main>
    </div>
  </div>
</template>

<script>
import Banner from '@/components/banner'
import sectionTitle from '@/components/section-title'
import comment from '@/components/comment'
import menuTree from '@/components/menu-tree'
import {fetchComment} from '../api'
import commentMessageEditor from 'comment-message-editor'


export default {

  name: 'articles',
  data() {
    return {
      nopraise: true,
      ispraise: false,
      showDonate: false,
      // comments: [],
      menus: [],
      article: '',
      catalogCur: 0,
      showCommentEditorParent: true,
      comment: {
        content: '',
        createtime: '',
        fromuseravatar: '',
        fromuserid: '',
        fromusername: '',
        id: '',
        parentid: '',
        postid: '',
        touseravatar: '',
        touserid: '',
        tousername: ''
      }
    }
  },
  components: {
    Banner,
    sectionTitle,
    comment,
    menuTree,
    commentMessageEditor

  },
  watch: {},
  mounted() {
    this.createMenus()
    this.initArticles()
    this.initComment()
  },


  methods: {
    canview() {
      this.ispraise = true
      this.nopraise = false

    },
    noview() {
      this.ispraise = false
      this.nopraise = true
    },
    //目录定位
    scrollEvent(e) {
      console.log(e.srcElement.scrollTop)//滚动条变化
      let scrollItems = document.querySelectorAll('.entry-content')
      for (let i = scrollItems.length - 1; i >= 0; i--) {
        // 判断滚动条滚动距离是否大于当前滚动项可滚动距离
        let judge = e.target.scrollTop >= scrollItems[i].offsetTop - scrollItems[0].offsetTop
        if (judge) {
          this.catalogCur = i
          break
        }
      }
      //滚动条触底了
      if (e.srcElement.scrollTop + e.srcElement.offsetHeight == e.srcElement.scrollHeight) {
        this.catalogCur = this.menus.innerHTML.length - 1
      }

    },

    /*目录点击定位效果：有兼容问题，借鉴了很多其他方法却一直不成功，无奈之后使用了scrollIntoView*/
    jump(index) {
      this.catalogCur = index;
      let jump = document.querySelector('.entry-content').getElementsByTagName('h2')
      console.log(jump)

      jump[index].scrollIntoView({block: "start", behavior: "smooth"});

    },
    initArticles() {
      console.log(this.$route.params.id)
      this.getRequest('/blog/article/' + this.$route.params.id).then(resp => {
        if (resp) {
          this.article = resp.data
          console.log(resp)
          console.log(this.article)
        }
      })

    },
    /**
     * 获取评论
     */
    submitReply(v) {
      console.log(v)
      let tokenValue = window.localStorage.getItem('access-admin')
      if (tokenValue != null) {
        this.getRequest("/auth/" + tokenValue).then(resp => {
          if (resp) {
            this.comment.fromuseravatar = resp.user.avatar
            this.comment.fromuserid = resp.user.userid
            this.comment.content = v,
                this.comment.postid = this.$route.params.id,
                this.comment.fromusername = resp.user.username
            this.postRequest("/blog/comment/save", this.comment).then(resp => {
              if (resp) {
                console.log("fatherComment")

                this.initComment()
              }
            })
          }
        })

      }

    },
    initComment() {
      console.log(this.$route.params.id)
      this.getRequest("/blog/comment/commentList/" + this.$route.params.id).then(resp => {
        if (resp) {
          //this.comments = resp.data
          this.$store.commit('INIT_COMMENTS', resp.data)
          //this.comments=this.$store.state.socialComments
          console.log("评论列表", resp.data)
        }
      })

    },
    // getComment() {
    //   console.log("文章postId",this.$route.params.id)
    //   fetchComment().then(res => {
    //     this.comments = res.data || []
    //     console.log(res.data)
    //   }).catch(err => {
    //     console.log(err)
    //   })
    // },
    fetchH(arr, left, right) {
      if (right) {
        return arr.filter(item => item.offsetTop > left && item.offsetTop < right)
      } else {
        return arr.filter(item => item.offsetTop > left)
      }
    },
    // 生成目录
    createMenus() {

      let e = document.querySelector(".entry-content").getElementsByTagName('h2')
      console.log(e)
      this.menus = e;
      console.log(this.menus)

    }
  },

  created() {
    // this.getComment()
  }
}
</script>
<style scoped lang="less">
.img {
  width: 20px;
  cursor: pointer
}

.menuul li {
  cursor: pointer;
  padding-top: 7px;
}

.site-content {
  position: relative;

  .site-main {
    padding: 80px 0 0 0;
  }
}

#article-menus {

  margin-left: 1200px;
  position: sticky;
  top: 0;
  box-shadow: 0 2px 6px rgba(0, 0, 0, .1);
  border-radius: 3px;
  padding: 15px;
  width: 300px;
  transform: translateX(-120%) translateY(150px);
  font-size: 14px;
}

article.hentry {
  .entry-header {
    .entry-title {
      font-size: 23px;
      font-weight: 600;
      color: #737373;
      margin: 0.67em 0;

      &:before {
        content: "#";
        margin-right: 6px;
        color: #d82e16;
        font-size: 20px;
        font-weight: 600;
      }
    }

    hr {
      height: 1px;
      border: 0;
      background: #EFEFEF;
      margin: 15px 0;
    }

    .breadcrumbs {
      font-size: 14px;
      color: #D2D2D2;
      text-decoration: none;
      margin-bottom: 30px;
    }
  }

  .entry-content {
  }

  footer.post-footer {

    width: 100%;
    padding: 20px 10px;
    margin-top: 30px;
    height: 65px;
    position: relative;

    i {
      font-size: 18px;
      margin-right: 5px;
    }

    .post-like {
      float: right;
      margin: 7px 0 0 20px;
    }

    .post-share {
      float: right;
      list-style: none;
      margin-right: 20px;
    }

    .donate {
      float: left;
      line-height: 36px;
      border-radius: 100%;
      -webkit-border-radius: 100%;
      -moz-border-radius: 100%;
      border: 1px solid #2B2B2B;

      &:hover {
        border: 1px solid goldenrod;

        span {
          color: goldenrod;
        }
      }

      span {
        color: #2B2B2B;
        padding: 10px;
        position: relative;
        cursor: pointer;
      }

      .donate_inner {
        display: none;
        margin: 0;
        list-style: none;
        position: absolute;
        left: 80px;
        top: -40px;
        background: #FFF;
        padding: 10px;
        border: 1px solid #ddd;
        box-shadow: 0 2px 6px rgba(0, 0, 0, .08);
        border-radius: 3px;

        &.show {
          display: block;
        }

        li {
          float: left;
        }

        img {
          width: 100px;
        }

        p {
          text-align: center;
          font-size: 15px;
          color: #D2D2D2;
          line-height: 1rem;
        }
      }

      .donate_inner:after, .donate_inner:before {
        content: "";
        position: absolute;
        left: 0;
        bottom: 45%;
        margin-left: -8px;
        border-top: 8px solid transparent;
        border-bottom: 8px solid transparent;
        border-right: 8px solid #fff;
      }

      .donate_inner:before {
        left: -1px;
        border-right: 8px solid #ddd;
      }

    }

    .post-tags {
      margin: 7px 0 0 20px;
      float: left;
      text-transform: uppercase;

      a:hover {
        color: #ff6d6d;
      }
    }
  }

  .open-message {
    margin: 50px 0;
    position: relative;
    background: #2B2B2B;
    padding: 10px 30px;
    border-radius: 3px;
    font-size: 14px;
    color: #fff;

    &:after {
      content: "";
      border-left: 10px solid transparent;
      border-right: 10px solid transparent;
      border-bottom: 10px solid #2B2B2B;
      position: absolute;
      top: -8px;
      left: 48%;
    }

    p {
      margin: 10px 0;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    a {
      color: #A0DAD0;
      padding: 0 5px;
    }
  }
}
</style>
