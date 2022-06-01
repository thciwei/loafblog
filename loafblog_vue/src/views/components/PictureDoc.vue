<template>
  <div>
    <iframe id="myIframe" :src="adminSwaggerUrl" width="100%" height="750px;"></iframe>
  </div>
</template>

<script>
import {Loading} from 'element-ui'
import API from '../../../config/API'
export default {
  name: 'PictureDoc',
  data(){
    return {
      adminSwaggerUrl: API.PICTURE_API+"/swagger-ui/index.html",
    }
  },
  mounted () {
    let iframe = document.getElementById("myIframe")
    let uploadLoading = Loading.service({
      lock: true,
      text: '正在努力加载中……'
    })
    if (iframe.attachEvent) {
      iframe.attachEvent("onload", function () {
        uploadLoading.close();
      });
    } else {
      iframe.onload = function () {
        uploadLoading.close();
      };
    }

  },
  methods: {

  }
}
</script>

<style scoped>

</style>
