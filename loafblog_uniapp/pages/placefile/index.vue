<template>
	<view>
		<view class="fixed">
			<cu-custom :isBack="true" bgColor="bg-shadeTop text-white">
			</cu-custom>
		</view>
		<!-- <swiper class="screen-swiper round-dot" :indicator-dots="true" :circular="true" :autoplay="true" interval="5000"
			duration="500">
			<swiper-item v-for="(item,index) in 4" :key="index">
				<image :src="'https://ossweb-img.qq.com/images/lol/web201310/skin/big3900'+index+ '.jpg'"
					mode="aspectFill"></image>
			</swiper-item>
		</swiper> -->
		<swiper class="screen-swiper" :class="dotStyle?'square-dot':'round-dot'" :indicator-dots="true" :circular="true"
			:autoplay="true" interval="5000" duration="500">
			<swiper-item v-for="(item,index) in imageList" :key="index">
				<image :src="item.image" mode="aspectFill"></image>
				<view class="cu-bar bg-shadeBottom" style="margin-top: -50px;">
					<text class="text-cut" style="font-size: 18px; margin: 0 auto;">{{item.title}}</text>
				</view>
			</swiper-item>
		</swiper>

		<view class="VerticalBox">
			<scroll-view class="VerticalNav nav" scroll-y scroll-with-animation :scroll-top="verticalNavTop"
				style="height:calc(100vh - 375upx)">
				<view class="cu-item" :class="index==tabCur?'text-green cur':''" v-for="(item,index) in list"
					:key="index" @tap="TabSelect" :data-id="index" @click="getFile(item)">
					{{item}}
				</view>
			</scroll-view>
			<scroll-view class="VerticalMain" scroll-y scroll-with-animation style="height:calc(100vh - 375upx)"
				:scroll-into-view="'main-'+mainCur" @scroll="VerticalMain">
				<view class="padding-top padding-lr box" :id="'main-'+index">
					<view class="cu-bar solid-bottom bg-white">
						<view class="action">
							<text class="cuIcon-title text-green"></text> {{selectTime}}
						</view>
					</view>
					<view class="cu-list menu-avatar">
						<view class="cu-item" v-for="(item,index) in blogs" @tap="gotoBlog(item.id)" :key="index">
							
							<image class="cu-avatar radius lg"  :src="item.image"></image>
							<view class="content">
								<view class="text-cut text-grey">{{item.title}}</view>

								<view class="text-gray text-sm flex">
									<view class="text-cut ">
										{{item.summary}}

									</view>
								</view>
							</view>
							<view class="action">
								<view class="text-grey text-xs">{{item.publishdate.substring(0,10)}}</view>
								<view class="cu-tag round bg-orange sm">{{item.isoriginal=='true'?'原创':'转载'}}</view>
							</view>
						</view>
					</view>
				</view>
			</scroll-view>
		</view>
		<u-tabbar :list="tabbar" :mid-button="false"></u-tabbar>
	</view>
</template>

<script>
	import {
		myRequest
	} from "../../utils/request.js"
	import {
		mapState,
		mapMutations
	} from 'vuex'
	export default {
		computed: {
			// 实时获取state的值，vuex  
			...mapState(['tabbar']),

		},
		data() {
			return {
				list: [],
				tabCur: 0,
				mainCur: 0,
				verticalNavTop: 0,
				load: true,
				month: '',
				year: '',
				blogs: [],
				selectTime: '',
				imageList: [{
						image: '/static/vue0.jpg',
						title: 'vue头像裁剪',
						id:3
					},
					{
						image: '/static/docker0.jpg',
						title: 'dockerFile使用',
						id:2
					},
	
				],
			
			}
		},

		onLoad() {
			uni.showLoading({
				title: '加载中...',
				mask: true
			});
		},
		onReady() {
			uni.hideLoading()
		},
		mounted() {
			this.initFiles()
		},
		methods: {
			gotoBlog(bid) {
				uni.navigateTo({
					url: "/pages/blog/blog?blogId=" + bid,
				})
			},
			getFile(time) {
				this.year = time.substring(0, 4)
				this.month = time.substring(5, 7)
				myRequest({
					url: "/blog/article/getByYearMonth/" + this.year + "/" + this.month
				}).then(resp => {
					if (resp) {
						this.blogs = resp.data.data
					
					}
				})
			},
			initFiles() {
				myRequest({
					url: "/blog/article/gettimes"
				}).then(resp => {
					if (resp) {
						this.list = resp.data.data
						this.getFile(this.list[0])
						this.selectTime = this.list[0]
						
					}
				})
			},
			TabSelect(e) {
				this.tabCur = e.currentTarget.dataset.id;
				this.mainCur = e.currentTarget.dataset.id;
				this.verticalNavTop = (e.currentTarget.dataset.id - 1) * 50
			},
			VerticalMain(e) {
				// #ifdef MP-ALIPAY
				return false //支付宝小程序暂时不支持双向联动 
				// #endif
				let that = this;
				let tabHeight = 0;
				if (this.load) {
					for (let i = 0; i < this.list.length; i++) {
						let view = uni.createSelectorQuery().select("#main-" + this.list[i].id);
						view.fields({
							size: true
						}, data => {
							this.list[i].top = tabHeight;
							tabHeight = tabHeight + data.height;
							this.list[i].bottom = tabHeight;
						}).exec();
					}
					this.load = false
				}
				let scrollTop = e.detail.scrollTop + 10;
				for (let i = 0; i < this.list.length; i++) {
					if (scrollTop > this.list[i].top && scrollTop < this.list[i].bottom) {
						this.verticalNavTop = (this.list[i].id - 1) * 50
						this.tabCur = this.list[i].id
						console.log(scrollTop)
						return false
					}
				}
			}
		}
	}
</script>

<style lang="scss" scoped>
	.fixed {
		position: fixed;
		z-index: 99;
	}

	.box .cu-item {
		height: 100px;
		margin: 0;
	}



	.VerticalNav.nav {
		width: 200upx;
		white-space: initial;
	}

	.VerticalNav.nav .cu-item {
		width: 100%;
		text-align: center;
		background-color: #fff;
		margin: 0;
		border: none;
		height: 50px;
		position: relative;
	}

	.VerticalNav.nav .cu-item.cur {
		background-color: #f1f1f1;
	}

	.VerticalNav.nav .cu-item.cur::after {
		content: "";
		width: 8upx;
		height: 30upx;
		border-radius: 10upx 0 0 10upx;
		position: absolute;
		background-color: currentColor;
		top: 0;
		right: 0upx;
		bottom: 0;
		margin: auto;
	}

	.VerticalBox {
		display: flex;
	}

	.VerticalMain {
		background-color: #f1f1f1;
		flex: 1;
	}
</style>
