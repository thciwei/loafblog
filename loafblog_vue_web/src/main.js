import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './assets/css/style.less'
import './assets/font/iconfont.css'
 require('./Mock')
import {parseTime} from './utils'
import {postRequest} from './utils/api'
import {postKeyValueRequest} from './utils/api'
import {putRequest} from './utils/api'
import {getRequest} from './utils/api'
import {deleteRequest} from './utils/api'

import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(Element)

import VueStar from 'vue-star'
Vue.component('VueStar', VueStar)
import tagCloud from 'v-tag-cloud'
import axios from "axios";
import cookie from 'vue-cookie'
Vue.use(tagCloud)
axios.defaults.withCredentials = true;
Vue.prototype.postRequest = postRequest
Vue.prototype.putRequest = putRequest
Vue.prototype.getRequest = getRequest
Vue.prototype.deleteRequest = deleteRequest
Vue.prototype.$cookie = cookie;

Vue.config.productionTip = false
Vue.filter('parseTime', (v) => parseTime(v,'{y}-{m}-{d}'))
// Require dependencies

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
