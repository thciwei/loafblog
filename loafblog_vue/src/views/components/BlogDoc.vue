<template>
  <div>
    <iframe src="http://localhost:7000/swagger-ui/index.html" id="mobsf" scrolling="yes" frameborder="0"
            style="position:absolute;top:0px;left: 0px;right:0px;bottom:0px;"></iframe>

  </div>
</template>

<script>
export default {
  name: 'BlogDoc',
  mounted () {
    this.changeMobsfIframe()
    window.onresize = function () {
      this.changeMobsfIframe()
    }
  },
  methods: {
    /**
     * iframe-宽高自适应显示
     */
    changeMobsfIframe () {
      const mobsf = document.getElementById('mobsf')
      const deviceWidth = document.body.clientWidth
      const deviceHeight = document.body.clientHeight
      mobsf.style.width = (Number(deviceWidth) - 240) + 'px' //数字是页面布局宽度差值
      mobsf.style.height = (Number(deviceHeight) - 64) + 'px' //数字是页面布局高度差
    },
  }
}
</script>

<style scoped>

</style>
