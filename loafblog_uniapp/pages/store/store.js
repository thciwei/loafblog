import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

const state = {
	favorites: 0,
	username: "123",
	demoxxxx: "1",
	tabbar: [{
			iconPath: "home",
			selectedIconPath: "home-fill",
			text: '首页',
			count: 0,
			isDot: false,
			customIcon: false,
			pagePath: "/pages/index/index"
		},
		{
			iconPath: "grid",
			selectedIconPath: "grid-fill",
			text: '分类',
			customIcon: false,
			pagePath: "/pages/cate/index"
		},
		{
			iconPath: "hourglass",
			selectedIconPath: "hourglass-half-fill",
			text: '归档',
			customIcon: false,
			pagePath: "/pages/placefile/index"
		},
		{
			iconPath: "account",
			selectedIconPath: "account-fill",
			text: '我的',
			count: 0,
			isDot: false,
			customIcon: false,
			pagePath: "/pages/my/index"
		}

	]
}

export default new Vuex.Store({
	state,
	plugins: [
		// 可以有多个持久化实例  
		createPersistedState({
			key: 'app_config_data', // 状态保存到本地的 key   
			paths: ['favorites', 'username', 'tabbar'], // 要持久化的状态，在state里面取，如果有嵌套，可以  a.b.c   
			storage: { // 存储方式定义  
				getItem: (key) => uni.getStorageSync(key), // 获取  
				setItem: (key, value) => uni.setStorageSync(key, value), // 存储  
				removeItem: (key) => uni.removeStorageSync(key) // 删除  
			}
		})
	]
})
