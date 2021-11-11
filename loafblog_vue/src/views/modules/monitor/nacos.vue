<template>
    <div class="container">
      <div style="display: flex;">

        <div class="pic">
          <img src="../../../assets/img/logo-nacos.svg" alt="" class="nacosImg">
        </div>
        <div class="wtext">
          <div class="btntext">
            <h2 tag="H2" class="jsx-3758713709 ">注册配置中心</h2>
                <el-button @click="inita" style=" background-image: linear-gradient(#4093ff, #1be1f6);color: whitesmoke">前往
                </el-button>
          </div>
        </div>

      </div>
    </div>
</template>

<script>
export default {
  name: 'nacos',

  data () {
    return {}
  },
  mounted () {
   this.inita()
  },
  methods: {
    inita () {
      this.$notify({
        title:'监控界面',
        message: '请关闭弹窗拦截'
      });
      window.open('http://8.129.122.160:8848/nacos')
    }
  }

}
</script>

<style scoped>

.wtext{
  width: 100%;
  position: relative;
  min-height: 1px;
  padding-right: 16px;
  padding-left: 16px;
}

.pic .nacosImg{
  border-radius: 50px 50px 50px 50px;
  background: black;
  width: 580px;
  height: 390px;
  margin: 0px auto;
  position: relative;
}
.btntext{
  margin-left: 20px;
}
h2{
  font-size: 40px;
  line-height: 48px;
  padding-bottom: 16px;
}

</style>
