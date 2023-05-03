<template>

    <div class="container">
      <div style="display: flex;">

        <div class="pic">
          <img src="../../../assets/img/rabbitmqlogo.svg" alt="" class="rabbitImg"/>
        </div>
        <div class="wtext">
          <div class="btntext">
            <h2 tag="H2" class="jsx-3758713709 ">消息队列</h2>
            <el-button @click="inita" style="background: orange;color: whitesmoke" >前往
            </el-button>
          </div>
        </div>
      </div>
    </div>

</template>

<script>
export default {
  name: 'rabbitmq',
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
      window.open('http://192.168.145.132:15672/')
    }
  }
}
</script>

<style scoped>


.rabbitImg {
  padding-left: 100px;
  width: 500px;
  height: 200px;
}

.wtext{
  width: 100%;
  position: relative;
  min-height: 1px;
  padding-right: 16px;
  padding-left: 16px;
}
.pic{

}
.pic .kibanaImg{
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
