<template>
	<view class="content ">
		<cu-custom bgColor=" bg-gradual-blue" :isBack="false">
			<block slot="content"></block>
		</cu-custom>

		<scroll-view scroll-x class="bg-white nav" scroll-with-animation :scroll-left="scrollLeft">
			<view class="cu-item" :class="index==TabCur?'text-green cur':''" v-for="(item,index) in cateList"
				:key="index" @tap="tabSelect" :data-id="index" @click="select(item.id)">
				{{item.catename}}
			</view>
		</scroll-view>
		<scroll-view scroll-y class="DrawerPage" :class="modalName=='viewModal'?'show':''">

			<view class="action">
				<button class="cu-btn bg-gradual-blue lg block shadow radius margin-xl" @tap="showModal"
					data-target="viewModal">查看时间线</button>
			</view>
			<view  class="cu-card case" :class="isCard?'no-card':''" v-for="(item,index) in blogs" :key="index"
				@tap="gotoBlog(item.id)">
				<view class="cu-item shadow">
					<view class="image">
						<image :src="item.image" mode="widthFix">
						</image>
						<view class="cu-tag bg-blue">{{item.cateName}}</view>
						<view class="cu-bar bg-shadeBottom">
							<view class="text-cut" v-html="item.summary"></view>
						</view>
					</view>
					<view class="cu-list menu-avatar">
						<view class="cu-item" style="height: 50px;">
							<view class="cu-avatar round lg"
								style="background-image:url(https://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/%E9%9D%A2%E5%8C%85.png);background-color: white;">
							</view>

							<view class="content flex-sub">
								<view class="text-grey" v-html="item.title"></view>
								<view class="text-gray text-sm flex justify-between">
									{{item.publishdate}}
									<view class="text-gray text-sm">
										<text class="cuIcon-attentionfill margin-lr-xs"></text> 10
										<text class="cuIcon-appreciatefill margin-lr-xs"></text> 20
										<text class="cuIcon-messagefill margin-lr-xs"></text> 30
									</view>
								</view>
							</view>
						</view>
					</view>
				</view>
			</view>

		</scroll-view>

		<view class="DrawerClose" :class="modalName=='viewModal'?'show':''" @tap="hideModal">
			<text class="cuIcon-pullright"></text>
		</view>
		<scroll-view scroll-y class="DrawerWindow" :class="modalName=='viewModal'?'show':''">
			<view class="cu-list menu card-menu margin-top-xl margin-bottom-xl shadow-lg">
				<view class="cu-timeline" v-for="(item,index) in files " :key="index">
					<view class="cu-item cur  text-blue">
						<view class="content  shadow-blur">
							<text>{{item.publishdate}}</text> <br>
							发布了<text style="font-weight: 700;">{{item.title}}</text>
						</view>
					</view>
				</view>
			</view>
		</scroll-view>
		<u-tabbar :list="tabbar" :mid-button="false"></u-tabbar>
	</view>
</template>

<script>
	import {
		mapState,
		mapMutations
	} from 'vuex'
	import {
		myRequest
	} from "../../utils/request.js"
	export default {
		computed: {
			// 映射两个状态到页面示例中，可以直接访问，实时获取state的值，更多请自行了解vuex  
			...mapState(['tabbar']),

		},
		data() {
			return {
				modalName: null,
				TabCur: 1,
				cateId: 1,
				scrollLeft: 0,
				cateList: [],
				blogs: [],
				param: {
					page: 1,
					limit: 20
				},
				files: []
			}
		},

		onLoad() {
			this.select()
		},
		mounted() {
			this.initCates()
			this.initTimeLine()

		},
		methods: {
			gotoBlog(bid) {
				uni.navigateTo({
					url: "/pages/blog/blog?blogId=" + bid,
				})
			},
			initTimeLine() {
				myRequest({
					url: "/blog/web/file"
				}).then(resp => {
					if (resp) {
						this.files = resp.data.data
					}
				})
			},
			showModal(e) {
				this.modalName = e.currentTarget.dataset.target
			},
			hideModal(e) {
				this.modalName = null
			},
			select(e) {
				if (e == undefined) {
					myRequest({
						url: "/blog/article/uni/2",
					}).then(resp => {
						if (resp) {
							console.log(resp)
							this.blogs = resp.data.data
						}
					})
				}
				if (e != undefined) {
					this.cateId = e
					myRequest({
						url: "/blog/article/uni/" + this.cateId,
					}).then(resp => {
						if (resp) {
							console.log(resp)
							this.blogs = resp.data.data
						}
					})
				}

			},
			initCates() {
				myRequest({
					url: "/blog/category/list",
					data: this.param
				}).then(resp => {
					if (resp) {

						this.cateList = resp.data.page.list
					}
				})
			},
			tabSelect(e) {
				this.TabCur = e.currentTarget.dataset.id;
				console.log(e.currentTarget.dataset.id)
				this.scrollLeft = (e.currentTarget.dataset.id - 1) * 60
			}
		}
	}
</script>

<style scoped>
	.Page {
		height: 100vh;
		width: 100vw;
		left: 0vw;
		background-color: #f1f1f1;
		transition: all 0.4s;
	}

	.action .cu-btn {
		margin-top: 10px;
	}

	page {
		background-image: var(--gradualBlue);
		width: 100vw;
		overflow: hidden;
	}

	.DrawerPage {
		position: absolute;
		width: 100vw;
		height: 100vh;
		left: 0vw;
		background-color: #f1f1f1;
		transition: all 0.4s;
	}

	.DrawerPage .cu-card {
		margin-top: -20px;
	}

	.DrawerPage.show {
		transform: scale(0.9, 0.9);
		left: 85vw;
		box-shadow: 0 0 60upx rgba(0, 0, 0, 0.2);
		transform-origin: 0;
	}

	.DrawerWindow {
		position: absolute;
		width: 85vw;
		height: 100vh;
		left: 0;
		top: 0;
		transform: scale(0.9, 0.9) translateX(-100%);
		opacity: 0;
		pointer-events: none;
		transition: all 0.4s;
		padding: 100upx 0;
	}

	.DrawerWindow.show {
		transform: scale(1, 1) translateX(0%);
		opacity: 1;
		pointer-events: all;
	}

	.DrawerClose {
		position: absolute;
		width: 40vw;
		height: 100vh;
		right: 0;
		top: 0;
		color: transparent;
		padding-bottom: 30upx;
		display: flex;
		align-items: flex-end;
		justify-content: center;
		background-image: linear-gradient(90deg, rgba(0, 0, 0, 0.01), rgba(0, 0, 0, 0.6));
		letter-spacing: 5px;
		font-size: 50upx;
		opacity: 0;
		pointer-events: none;
		transition: all 0.4s;
	}

	.DrawerClose.show {
		opacity: 1;
		pointer-events: all;
		width: 15vw;
		color: #fff;
	}

	.DrawerPage .cu-bar.tabbar .action button.cuIcon {
		width: 64upx;
		height: 64upx;
		line-height: 64upx;
		margin: 0;
		display: inline-block;
	}

	.DrawerPage .cu-bar.tabbar .action .cu-avatar {
		margin: 0;
	}

	.DrawerPage .nav {
		flex: 1;
	}

	.DrawerPage .nav .cu-item.cur {
		border-bottom: 0;
		position: relative;
	}

	.DrawerPage .nav .cu-item.cur::after {
		content: "";
		width: 10upx;
		height: 10upx;
		background-color: currentColor;
		position: absolute;
		bottom: 10upx;
		border-radius: 10upx;
		left: 0;
		right: 0;
		margin: auto;
	}

	.DrawerPage .cu-bar.tabbar .action {
		flex: initial;
	}
</style>
