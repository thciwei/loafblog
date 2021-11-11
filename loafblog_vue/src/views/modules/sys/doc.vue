<template>
  <div>
    <div>
      <el-tabs v-model="activeName"  type="card" class="taggroup">
        <el-tab-pane label="博客接口" name="first" class="tag1">
          <BlogDoc></BlogDoc>
        </el-tab-pane>
        <el-tab-pane label="登录接口" name="second"  class="tag2">
          <AuthDoc></AuthDoc>
        </el-tab-pane>
        <el-tab-pane label="第三方服务接口" name="third"  class="tag3">
          <PictureDoc></PictureDoc>
        </el-tab-pane>
        <el-tab-pane label="搜索接口" name="fourth" class="tag4">
          <SearchDoc></SearchDoc>
        </el-tab-pane>
      </el-tabs>
    </div>


  </div>
</template>

<script>
import BlogDoc from '../../components/BlogDoc'
import AuthDoc from '../../components/AuthDoc'
import PictureDoc from '../../components/PictureDoc'
import SearchDoc from '../../components/SearchDoc'
export default {
  name: 'doc',
  data(){
    return{
      activeName:'third'
    }
  },
  components: {
    BlogDoc, AuthDoc, PictureDoc, SearchDoc

  },
  mounted () {

  },
  methods: {}
}
</script>

<style scoped>
.taggroup .tag1 {
  width: 1000px;
  height: 500px
}
.taggroup .tag2 {
  width: 1000px;
  height: 500px
}
.taggroup .tag3 {
  width: 1000px;
  height: 500px
}
.taggroup .tag4 {
  width: 1000px;
  height: 500px
}
</style>
