<template>

	<view class="content">
		<swiper class="screen-swiper" :class="dotStyle?'square-dot':'round-dot'" :indicator-dots="true" :circular="true"
			:autoplay="true" interval="5000" duration="500">
			<swiper-item v-for="(item,index) in list" :key="index">
				<image :src="item.image" mode="aspectFill"></image>
				<view class="cu-bar bg-shadeBottom" style="margin-top: -50px;" @tap="goInfo(item.id)">
					<text class="text-cut" style="font-size: 18px; margin: 0 auto;">{{item.title}}</text>
				</view>
			</swiper-item>
		</swiper>
		
		<view class="main">
			<view class="cu-bar bg-white search " :style="[{top:CustomBar + 'px'}]">
				<view class="search-form round">
					<text class="cuIcon-search"></text>
					<input type="text" placeholder="输入搜索的关键词" confirm-type="search"
						v-model="searchParam.keyword"></input>
				</view>
				<view class="action">
					<button class="cu-btn bg-gradual-blue shadow-blur round" @click="searchBlog()">搜索</button>
				
				</view>
			</view>

			<view class="articleList">
				<view :style="[{animation: 'show ' + ((index+1)*0.2+1) + 's 1'}]" class="cu-card article"
					:class="isCard?'no-card':''" v-for="(item,index) in articles" :key="index" @tap="gotoBlog(item.id)">
					<view class="cu-item shadow">
						<view class="title">
							<view class="text-cut">{{item.title}}</view>
						</view>
						<view class="content">
							<image :src="item.image" mode="aspectFill"></image>
							<view class="desc">
								<view class="text-content"> {{item.summary}}
								</view>
								<view>
									<view class="cu-tag bg-red light sm round">{{item.tagName}}</view>
									<view class="cu-tag bg-green light sm round">{{item.cateName}}</view>
								</view>
							</view>
						</view>
					</view>
				</view>


			</view>

		</view>


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
			...mapState(['username', 'favorites', 'tabbar']),

		},
		onLoad() {
			this.initArticle()
		},
		mounted() {

		},
		data() {
			return {
				showList: true,
				articles: [],
				title: '素胚勾勒出青花，笔锋浓转淡',
				subTitle: '2020-05-15',
				searchParam: {
					keyword: '',
					pageNum: 1,
				},

				list: [{
						image: 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/ba5cc7eed880cdba69b4571e7d63b821.jpg',
						title: 'Git学习资料',
						id:3
					},
					{
						image: 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/1605004575968.jpg',
						title: 'Ajax上传图片以及上传之前先预览',
						id:2
					},
					{
						image: 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/9c8e6b18509311ad8d74cfdb4da52c60_1440w.png',
						title: 'docker入门',
						id:19
					}
				],
			}
		},


		methods: {

			searchBlog() {
				uni.navigateTo({
					url: "../search/search?keyword=" + this.searchParam.keyword
				})

		
			},
			gotoBlog(bid) {
				uni.navigateTo({
					url: "/pages/blog/blog?blogId=" + bid,
				})
			},
			initArticle() {
				myRequest({
					url: '/blog/article/tagAndCate'
				}).then(resp => {
					if (resp) {
						console.log(resp)
						this.articles = resp.data.data
					}
				})
			}

		}
	}
</script>

<style lang="scss">
	
	.main {
		width: 100%;
		height: 100%;

	}

	.search {
		border: 1px solid white;
		height: 100rpx;
		width: 100%;
		background-color: white;
	}

	.u-card-wrap {
		background-color: $u-bg-color;
		padding: 1px;
	}

	.u-body-item {
		font-size: 32rpx;
		color: #333;
		padding: 20rpx 10rpx;
	}

	.u-body-item image {
		width: 120rpx;
		flex: 0 0 120rpx;
		height: 120rpx;
		border-radius: 8rpx;
		margin-left: 12rpx;
	}


</style>
