<template>
	<view class="">
		<cu-custom bgColor=" bg-gradual-blue" :isBack="true">
			<block slot="backText">返回</block>
			<block slot="content">搜索列表</block>
		</cu-custom>
		<scroll-view scroll-y>
			<view class="cu-bar bg-white search " :style="[{top:CustomBar + 'px'}]" 
			>
				<view class="search-form round">
					<text class="cuIcon-search"></text>
					<input type="text" placeholder="输入搜索的关键词" confirm-type="search"
						v-model="searchParam.keyword"></input>
				</view>
				<view class="action">
					<button class="cu-btn bg-gradual-blue shadow-blur round" @click="getSearchResult()">搜索</button>
				</view>
			</view>
			<view class="cu-card case"  :class="isCard?'no-card':''" 
			v-for="(item,index) in blogs" :key="index" @tap="gotoBlog(item.id)">
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
							
							<view class="content flex-sub" >
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
	</view>
</template>

<script>
	import {
		myRequest
	} from "../../utils/request.js"
	export default {
		data() {
			return {
				searchParam: {
					keyword: '',
					pageNum: 1
				},
				blogs:[],
				cateId: '',
				tagId: '',

			}
		},

		onLoad: function(option) { //option为object类型，会序列化上个页面传递的参数 
			console.log(option.keyword); //打印出上个页面传递的参数。  
			this.searchParam.keyword = option.keyword
			this.getSearchResult()
		},
		mounted() {
		
		},
		methods: {
			gotoBlog(bid) {
				uni.navigateTo({
					url: "/pages/blog/blog?blogId=" + bid,
				})
			},
			getSearchResult() {
				myRequest({
					url: "/search/save/search",
					data: this.searchParam
				}).then(resp => {
					if (resp) {
						console.log(resp)
						this.blogs=resp.data.data.articles
						
					}
				})
			},
		
		}
	}
</script>

<style>
</style>
