<template>

	<scroll-view scroll-y class="scrollPage">
		<view class="UCenter-bg">
			<image src="/static/面包.png" class="png" mode="widthFix"></image>
			<view class="text-xl" style="color: #000000;">面包博客
			</view>
			<image src="../../static/wave.gif" mode="scaleToFill" class="gif-wave"></image>
		</view>
		<view class="padding flex text-center text-grey bg-white shadow-warp">
			<view class="flex flex-sub flex-direction solid-right">
				<view class="text-xxl text-orange">{{visitTotal}}</view>
				<view class="margin-top-sm">
					<text class="cuIcon-attentionfill"></text> View
				</view>
			</view>
			<view class="flex flex-sub flex-direction solid-right">
				<view class="text-xxl text-blue">{{starCount}}</view>
				<view class="margin-top-sm">
					<text class="cuIcon-favorfill"></text> Star
				</view>
			</view>
			<view class="flex flex-sub flex-direction">
				<view class="text-xxl text-green">{{forksCount}}</view>
				<view class="margin-top-sm">
					<text class="cuIcon-fork"></text> Fork
				</view>
			</view>
		</view>
		<view class="cu-list menu card-menu margin-top-xl margin-bottom-xl shadow-lg radius">
			<view class="cu-item arrow">
				<view class="content" bindtap="CopyLink" data-link="https://github.com/weilanwl/ColorUI">
					<text class="cuIcon-github text-grey"></text>
					<text class="text-grey">GitHub</text>
				</view>
			</view>
			<!-- <view class="cu-item arrow">
	      <navigator class="content" url="/pages/about/about/about" hover-class="none">
	        <image src="/images/logo.png" class="png" mode="aspectFit"></image>
	        <text class="text-grey">关于ColorUI组件库</text>
	      </navigator>
	    </view> -->
			<view class="cu-item arrow">
				<navigator class="content" url="/pages/about/log/log" hover-class="none">
					<text class="cuIcon-formfill text-green"></text>
					<text class="text-grey">日志</text>
				</navigator>
			</view>
			<view class="cu-item arrow">
				<view class="content" bindtap="showQrcode">
					<text class="cuIcon-appreciatefill text-red"></text>
					<text class="text-grey">赞赏支持</text>
				</view>
			</view>
			<view class="cu-item arrow">
				<button class="cu-btn content" open-type="feedback">
					<text class="cuIcon-writefill text-cyan"></text>
					<text class="text-grey">意见反馈</text>
				</button>
			</view>
			<view class="cu-item arrow">
				<navigator class="content" url="/pages/about/test/list" hover-class="none">
					<text class="cuIcon-creativefill text-orange"></text>
					<text class="text-grey">登录</text>
				</navigator>
			</view>
		</view>
		<!--  <view class="cu-tabbar-height"></view> -->
		<u-tabbar :list="tabbar" :mid-button="false"></u-tabbar>
	</scroll-view>



</template>

<script>
	import {
		mapState,
		mapMutations
	} from 'vuex'
	export default {
		computed: {
			// 映射两个状态到页面示例中，可以直接访问，实时获取state的值，更多请自行了解vuex  
			...mapState(['username', 'favorites', 'tabbar']),

		},
		data() {
			return {
				title: 'Hello',
			}
		},

		onLoad() {

		},
		methods: {

		}
	}
</script>

<style>
	.UCenter-bg {
		background-image: url("/static/bg3.jpeg");
		background-size: cover;
		height: 550rpx;
		display: flex;
		justify-content: center;
		padding-top: 40rpx;
		overflow: hidden;
		position: relative;
		flex-direction: column;
		align-items: center;
		color: #fff;
		font-weight: 300;
		text-shadow: 0 0 3px rgba(0, 0, 0, 0.3);
	}

	.UCenter-bg text {
		opacity: 0.8;
	}

	.UCenter-bg image {
		width: 200rpx;
		height: 200rpx;
	}

	.UCenter-bg .gif-wave {
		position: absolute;
		width: 100%;
		bottom: 0;
		left: 0;
		z-index: 99;
		mix-blend-mode: screen;
		height: 100rpx;
	}

	map,
	.mapBox {
		left: 0;
		z-index: 99;
		mix-blend-mode: screen;
		height: 100rpx;
	}

	map,
	.mapBox {
		width: 750rpx;
		height: 300rpx;
	}
</style>
