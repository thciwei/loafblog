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

				list: [
					{
						image: 'http://8.129.122.160/group1/M00/00/00/CIF6oGRSKt6AQ3YwAACuuDVT7jk173.jpg',
						title: 'Docker的基本使用',
						id:35
					},{
						image: 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2023-05-03/a55e3b16-da91-4327-842c-bb9ba08a2ec8_logo.png',
						title: 'Spring Cloud学习笔记',
						id:31
					},
					{
						image: 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/typora/202301201618526.png',
						title: '整合阿里云oss',
						id:32
					},
					
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
