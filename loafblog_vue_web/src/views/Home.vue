<template>
  <div class="home">
    <banner isHome="true"></banner>
    <div class="site-content animate">
      <!--通知栏-->
      <div class="notify">
        <div class="search-result" v-if="hideSlogan">
          <span v-if="searchWords">搜索结果："{{ searchWords }}" 相关文章</span>
          <span v-else-if="category">分类 "{{ category }}" 相关文章</span>
        </div>
        <!--        <quote v-else>{{ notice }}</quote>-->
      </div>

      <!--焦点图-->
      <div class="top-feature" v-if="!hideSlogan">
        <section-title>
          <div style="display: flex;align-items: flex-end;">聚焦
            <small-ico></small-ico>
          </div>
        </section-title>
        <div class="feature-content">
          <div class="feature-item" v-for="item in features" :key="item.title">
            <Feature :data="item"></Feature>
          </div>
        </div>
      </div>
      <!--文章列表-->
      <main class="site-main" :class="{'search':hideSlogan}">
        <section-title v-if="!hideSlogan">推荐</section-title>
        <template v-for="item in postList2" v-if="mode=='search'">
          <post :post="item" :key="item.id"></post>
        </template>
        <template v-for="item in postList" v-if="mode!='search'">
          <post :post="item" :key="item.id"></post>
        </template>
      </main>

      <!--加载更多-->
      <!--      <div class="more" v-show="hasNextPage">-->
      <!--        <div class="more-btn" @click="loadMore">More</div>-->
      <!--      </div>-->
      <div>
        <el-pagination
            v-if="mode=='search'"
            @current-change="EsCurrentChange"
            :page-size="(this.esTotal%this.esTotalPages)==0?this.esTotal/this.esTotalPages:this.esTotal/this.esTotalPages+1"
            layout="total, prev, pager, next"
            :total="this.esTotal">
        </el-pagination>
        <el-pagination
            v-if="mode!='search'"
            :current-page="currPage"
            @current-change="handleCurrentChange"
            :page-size="this.pageSize"
            layout="total, prev, pager, next"
            :total="this.total">
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
import Banner from '@/components/banner'
import Feature from '@/components/feature'
import sectionTitle from '@/components/section-title'
import Post from '@/components/post'
import SmallIco from '@/components/small-ico'
import Quote from '@/components/quote'
import {fetchFocus, fetchList} from '../api'

export default {
  name: 'Home',
  props: ['cate', 'words'],
  data() {
    return {
      features: [],
      postList: [],
      postList2: [],
      total: 0,
      currentPage: 1,
      pageSize: 4,
      totalPage: '',
      esTotal: 0,
      esPageNum: 1,
      esTotalPages: 1,
      listLength: '',
      currPage: 1,
      hasNextPage: true,
      pages: {
        page: 1,
        limit: 4,
        key: null
      },
      searchParam: {
        keyword: '',
        pageNum: 1
      },
      mode: ''
    }
  },
  components: {
    Banner,
    Feature,
    sectionTitle,
    Post,
    SmallIco,
    Quote
  },
  computed: {
    searchWords() {
      return this.$route.params.words
    },
    category() {

      return this.$route.params.cate
    },
    hideSlogan() {
      return this.category || this.searchWords
    },
    notice() {
      return this.$store.getters.notice
    }
  },

  watch: {  //监听
    $route(to, from) { //路由变化方式，路由发生变化，方法就会执行
      this.searchArticle()
      this.initArticle()

    }
  },
  mounted() {
    this.fetchFocus();
    // this.fetchList();
    this.initArticle()
    // this.searchArticle()
  },
  methods: {
    EsCurrentChange(val) {
      this.searchParam.pageNum = val
      console.log(this.searchParam.pageNum)
      this.searchArticle()
    },

    handleCurrentChange(val) {
      this.pages.page = val
      //console.log(this.pages)
      this.initArticle()
    },
    searchArticle() {
      this.mode = this.$route.name
      console.log(this.$route.name)
      this.searchParam.keyword = this.$route.params.words
      console.log('words', this.$route.params.words)
      if (this.searchParam.keyword != undefined) {
        this.getRequest("/search/save/search", this.searchParam).then(resp => {
          if (resp) {
            this.postList2 = resp.data.articles
            this.esTotal = resp.data.total
            this.esTotalPages = resp.data.totalPages
            console.log('search',resp.data)
          } else {
            this.postList2 = []
          }
          // this.searchParam.pageNum = '';
          this.searchParam.keyword = ''
        })
      }
    },
    initArticle() {
      this.mode = this.$route.name
      this.pages.key = this.$route.params.cate

         this.getRequest('/blog/web/catearticle', this.pages).then(resp => {
           if (resp) {
             this.postList = resp.page.list
             this.total = resp.page.totalCount
             this.totalPage = resp.page.totalPage
             this.currPage=resp.page.currPage
             //this.currentPage = resp.page.currentPage
             this.pageSize = resp.page.pageSize
           } else {
             this.postList = []
             console.log("失败")
           }
         })


    },
    fetchFocus() {
      fetchFocus().then(res => {
        this.features = res.data || []
      }).catch(err => {
        console.log(err)
      })
    },
    fetchList() {
      fetchList().then(res => {
        this.postList = res.data.items || []
        this.currPage = res.data.page
        this.hasNextPage = res.data.hasNextPage
        console.log('res:', res)
        console.log('list:', this.postList)
      }).catch(err => {
        console.log(err)
      })
    },
    // loadMore() {
    //   fetchList({page: this.currPage + 1}).then(res => {
    //     this.postList = this.postList.concat(res.data.items || [])
    //     this.currPage = res.data.page
    //     this.hasNextPage = res.data.hasNextPage
    //   })
    //   this.pages.page+1;
    //
    //   this.pages.limit = (this.pages.limit) * 2
    //   this.initArticle()
    //   if (this.listLength == this.total) {
    //     this.hasNextPage = false
    //     console.log(this.listLength)
    //   }
    // }
  },

}
</script>
<style scoped lang="less">

.site-content {
  .notify {
    margin: 60px 0;
    border-radius: 3px;

    & > div {
      padding: 20px;
    }
  }


  .search-result {
    padding: 15px 20px;
    text-align: center;
    font-size: 20px;
    font-weight: 400;
    border: 1px dashed #ddd;
    color: #828282;
  }
}

.top-feature {
  width: 100%;
  height: auto;
  margin-top: 30px;

  .feature-content {
    margin-top: 10px;
    display: flex;
    justify-content: space-between;
    position: relative;

    .feature-item {
      width: 32.9%;
    }
  }
}

.site-main {
  padding-top: 80px;

  &.search {
    padding-top: 0;
  }
}

.more {
  margin: 50px 0;

  .more-btn {
    width: 100px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    color: #ADADAD;
    border: 1px solid #ADADAD;
    border-radius: 20px;
    margin: 0 auto;
    cursor: pointer;

    &:hover {
      color: #8fd0cc;
      border: 1px dashed #8fd0cc;
    }
  }
}

/******/
@media (max-width: 800px) {
  .top-feature {
    display: none;
  }

  .site-main {
    padding-top: 40px;
  }

  .site-content {
    .notify {
      margin: 30px 0 0 0;
    }

    .search-result {
      margin-bottom: 20px;
      font-size: 16px;
    }
  }
}

/******/
</style>
