<template>
  <div>
    <el-card class="box-card">
      <div class="text item">
        <p>基于 fastDFS 打造私人文件存储</p>
        <el-upload
          :show-file-list="false"
          :on-success="onSuccess"
          action="http://localhost:88/api/picture/fastdfsfile/upload">
          <icon-svg name="dfs" style="width: 80px;height: 50px" class="dfs"></icon-svg>
          <el-button size="small" type="primary" class="uploadBtn">上传</el-button>
        </el-upload>

      </div>
    </el-card>
    <div class="filegroup">
      <el-card class="file" v-for="file in fileList" :key="file">
        <img :src="file.url" style="width: 150px; height: 150px;cursor: pointer" @click="showImage(file.url)"/>
        <el-tooltip content="Bottom center" placement="bottom" effect="dark">
          <div slot="content">复制地址</div>
          <el-button type="primary" icon="el-icon-tickets" size="small" v-clipboard:copy="file.url"
                     v-clipboard:success="onCopy" class="copybtn"></el-button>
        </el-tooltip>
      </el-card>
    </div>
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
  name: 'privateFolder',
  data () {
    return {
      fileList: [],
      imageVisible: false
    }
  },
  mounted () {
    this.initFileList()
  },
  methods: {
    showImage (url) {
      this.imageVisible = true
      this.url = url
    },
    initFileList () {
      this.$http({
        url: this.$http.adornUrl('/picture/fastdfsfile/fileList'),
        method: 'get',
      }).then(({data}) => {
        if (data && data.code === 0) {
          this.fileList = data.data
        } else {
          this.fileList = []
        }
      })
    },
    initFileList2 () {
      this.$http({
        url: this.$http.adornUrl('/picture/fastdfsfile/fileList'),
        method: 'get',
      }).then(({data}) => {
        if (data && data.code === 0) {
          this.fileList = data.data
          this.$message({
            message: '上传成功',
            type: 'success'
          })
        } else {
          this.fileList = []
        }
      })
    },
    onCopy: function (e) {
      this.$message({
        message: '复制链接到剪切板成功',
        type: 'success'
      })
    },
    onSuccess () {
      this.initFileList2()

    }
  }
}
</script>

<style lang="scss" scoped>

.filegroup {
  display: flex;
  flex-wrap: wrap;
  justify-content: left;
  margin-top: 10px;
  margin-left: -5px;
  width: 900px;
  height: 100%;
}

.file img {
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

.dfs {
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

.uploadBtn {
  margin-top: 5px;
  margin-left: 5px;
}

.copybtn {
  margin: 3px 0 0 53px;
}

.filegroup .file {
  margin-left: 5px;
  height: 210px;
  width: 200px;
  margin-bottom: 10px;
}

.text {
  font-size: 14px;
}

.item {
  padding: 18px 0;
  display: flex;
}

.box-card {

  width: 400px;
}
</style>
