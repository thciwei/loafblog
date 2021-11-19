<script>
	import Vue from 'vue'
	export default {
		onLaunch: function() {
			console.log('App Launch')
			uni.getSystemInfo({
				success: function(e) {
					// #ifndef MP
					Vue.prototype.StatusBar = e.statusBarHeight;
					if (e.platform == 'android') {
						Vue.prototype.CustomBar = e.statusBarHeight + 50;
					} else {
						Vue.prototype.CustomBar = e.statusBarHeight + 45;
					};
					// #endif
					// #ifdef MP-WEIXIN
					Vue.prototype.StatusBar = e.statusBarHeight;
					let custom = wx.getMenuButtonBoundingClientRect();
					Vue.prototype.Custom = custom;
					Vue.prototype.CustomBar = custom.bottom + custom.top - e.statusBarHeight;
					// #endif       
					// #ifdef MP-ALIPAY
					Vue.prototype.StatusBar = e.statusBarHeight;
					Vue.prototype.CustomBar = e.statusBarHeight + e.titleBarHeight;
					// #endif
				}
			})
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style lang="scss">
	/* 注意要写在第一行，同时给style标签加入lang="scss"属性 */
	@import "uview-ui/index.scss";

	@import "colorui/main.css";
	@import "colorui/icon.css";
	
	@keyframes show {
		0% {
			transform: translateY(-50px);
		}
	
		60% {
			transform: translateY(40upx);
		}
	
		100% {
			transform: translateY(0px);
		}
	}
	
	@-webkit-keyframes show {
		0% {
			transform: translateY(-50px);
		}
	
		60% {
			transform: translateY(40upx);
		}
	
		100% {
			transform: translateY(0px);
		}
	}
</style>
