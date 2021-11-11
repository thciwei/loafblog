<template>
  <div class="file">
    <div class="block" >
      <el-timeline class="timeline">
        <el-timeline-item v-for="(item,index) in filelist" :key="index"  :timestamp="item.publishdate" :color="item.color" placement="top" class="timeitem">
          <el-card class="card">
            <h4>{{item.title}}</h4>
            <p style="padding-top: 10px"> 提交于 {{item.publishdate}}</p>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </div>
    <div class="cloud">
      <tag-cloud :data="this.tagsList" :config="config"></tag-cloud>
    </div>
  </div>

</template>

<script>


export default {
  name: "fileArticle",
  data() {
    return {
      filelist: [],
      tagsList:[],
      config:{
        maxFont:50,
      }
    }
  },
  mounted() {
    this.initFile()
     this.initTags()
  },
  methods: {
    initTags(){
      this.getRequest('/blog/web/tags').then(resp=>{
        if(resp){
          this.tagsList=resp.data

          console.log(resp)
        }
      })
    },
    initFile() {
      this.getRequest('/blog/web/file').then(resp => {
        if (resp) {
          this.filelist = resp.data
        }
      })
    }
  }
}
</script>

<style scoped>
.file {

  display: flex;
  justify-content: space-around;
}

.block {
  margin-top: 100px;
  width: 500px;
}
.cloud{
  margin-top: 100px;
}

</style>
