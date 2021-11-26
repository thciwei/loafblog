<template>
	<view class="">
		<cu-custom bgColor=" bg-gradual-blue" :isBack="true">
			<block slot="content">友情链接</block>
		</cu-custom>
		
		<view class="cu-chat">
			<view class="cu-item" v-for="(item,index) in websites" :key="index">
				<view class="">
					<view class='cu-tag round light bg-blue'>{{item.name}}</view>
				</view>
				<view class="main">
					<view class="content bg-blue shadow">
						<text>{{item.descp}}</text>
					</view>
				</view>

				<view class="date">{{item.link}}</view>
			</view>

		</view>
	</view>
</template>

<script>
	import {
		myRequest
	} from "../../utils/request.js"
	export default {
		data() {
			return {
				websites: []

			}
		},
		onLoad: function(option) { //option为object类型，会序列化上个页面传递的参数 
          
		},
		mounted() {
			this.initWebSites()
			
		},
		methods: {
			initWebSites() {
				myRequest({
					url: "/blog/websiteinfo/list"
				}).then(resp => {
					if (resp) {
						this.websites = resp.data.page.list

					}
				})
			}
		}
	}
</script>

<style>
</style>
