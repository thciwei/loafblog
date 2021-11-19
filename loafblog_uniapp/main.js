import App from './App'

// #ifndef VUE3
import Vue from 'vue'
import uView from "uview-ui";
import store from "./pages/store/store.js"
import cuCustom from './colorui/components/cu-custom.vue'
Vue.component('cu-custom',cuCustom)

Vue.config.productionTip = false
App.mpType = 'app'
Vue.use(uView);
import myRequest from "./utils/request.js"
Vue.$store = store
Vue.prototype.$myRequest=myRequest
const app = new Vue({
    ...App,
	store
})
app.$mount()
// #endif

// #ifdef VUE3
import { createSSRApp } from 'vue'
export function createApp() {
  const app = createSSRApp(App)
  return {
    app
  }
}
// #endif