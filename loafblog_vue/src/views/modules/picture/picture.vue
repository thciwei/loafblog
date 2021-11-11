<template>
  <div style=" margin-top: 10px;display: flex; flex-wrap: wrap;
  justify-content: left;">

    <el-card class="box-card" v-for="item in dataList" :key="item">
      <div class="text item">
        <el-tooltip content="Bottom center" placement="bottom" effect="dark">
          <div slot="content">{{ item.name }}</div>
          <img :src="item.url" style="width: 150px; height: 150px" class="image" @click="showImage(item.url)"/>
        </el-tooltip>
        <el-button-group style="padding-top: 2px;padding-left: 30px;">
          <el-tooltip content="Bottom center" placement="bottom" effect="dark">
            <div slot="content">复制</div>
            <el-button type="primary" icon="el-icon-tickets" size="small" v-clipboard:copy="item.url"
                       v-clipboard:success="onCopy"></el-button>
          </el-tooltip>
          <el-tooltip content="Bottom center" placement="bottom" effect="dark">
            <div slot="content">复制markdown</div>
            <el-button type="primary" icon="el-icon-tickets" size="small"
                       v-clipboard:copy=" '![' + item.name + '](' + item.url + ')'"
                       v-clipboard:success="onCopy"
            ></el-button>
          </el-tooltip>
        </el-button-group>
        <!--      <span style="font-size: 6px">{{item.name }}</span>-->
      </div>
    </el-card>
    <el-dialog
      :visible.sync="imageVisible"
      fullscreen
    >
      <img :src="url" class="fullImage"
           style="width: 500px;height: 500px;display: inline-block;margin: auto auto;margin-left: 360px"/>

    </el-dialog>
  </div>
</template>

<script>


export default {
  name: 'picture',
  data () {
    return {
      dataList: [],
      imageVisible: false,
      url: '',
    }
  },
  mounted () {
    this.initImg()
  },
  methods: {
    showImage (url) {
      this.imageVisible = true
      this.url = url
    },
    onCopy: function (e) {
      this.$message({
        message: '复制链接到剪切板成功',
        type: 'success'
      })
    },
    initImg () {
      this.$http({
        url: this.$http.adornUrl('/picture/list'),
        method: 'get',

      }).then(({data}) => {
        if (data && data.code === 0) {
          this.dataList = data.data
        } else {
          this.dataList = []

        }
        console.log(data)
      })
    }
  }
}
</script>

<style scoped lang="scss">
.text {
  font-size: 14px;
}

.item {
  padding: 18px 0;

}

.box-card {
  height: 200px;
  width: 200px;
  margin-bottom: 10px;
  margin-left: 3px;
}

.box-card .image {
  cursor: pointer;
  margin-top: -28px;
  /*照片效果*/
  object-fit: cover;
  padding: 2px;
  border: 1px solid #DADADA;
  position: relative;
  transition: all 0.2s linear;
  overflow: hidden;

  &:hover {
    transform: scale(1.1, 1.1);
    filter: contrast(130%);
  }

}

.fullImage {
  object-fit: scale-down;
}

</style>
