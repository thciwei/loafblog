<template>
	<view class="container">
		<cu-custom bgColor=" bg-gradual-blue" :isBack="true">
			<block slot="backText">返回</block>
			<block slot="content">{{blog.title}}</block>
		</cu-custom>
		<scroll-view scroll-y class="DrawerPage">
			<view class="tagAndCate">
				<view class="cu-capsule round">
					<view class='cu-tag bg-blue '>
						<text class='cuIcon-people'></text>
					</view>
					<view class="cu-tag line-blue">
						刺猬
					</view>
				</view>

				<view class="cu-capsule round">
					<view class='cu-tag bg-red '>
						<text class='cuIcon-likefill'></text>
					</view>
					<view class="cu-tag line-red">
						{{blog.isoriginal=='true'?'原创':'转载'}}
					</view>
				</view>
				<view class="cu-capsule round">
					<view class='cu-tag bg-green '>
						<text class='cuIcon-time'></text>
					</view>
					<view class="cu-tag line-green">
						{{blog.publishdate}}
					</view>
				</view>
				<view class='cu-tag line-green round'>{{tagName}}</view>
				<view class='cu-tag line-cyan round'>{{cateName}}</view>
			</view>
			<view class="content" style="margin-left: 10px;margin-right: 10px;">
				<mp-html :content="blog.htmlcontent" />

			</view>
		</scroll-view>
	</view>
</template>

<script>
	import mpHtml from 'mp-html/dist/uni-app/components/mp-html/mp-html'
	import {
		myRequest
	} from "../../utils/request.js"
	export default {
		data() {
			return {
				bid: '',
				blog: '',
				cateId: '',
				tagId: '',
				cateName: '',
				tagName: ''

			}
		},
		components: {
		 mpHtml
		},
		onLoad: function(option) { //option为object类型，会序列化上个页面传递的参数 
			console.log(option.blogId); //打印出上个页面传递的参数。  
			this.bid = option.blogId
			this.getBlog()
		},
		mounted() {
			// this.getCateName()
			// this.getTagName()
		},
		methods: {
			getBlog() {
				myRequest({
					url: "/blog/article/info/" + this.bid
				}).then(resp => {
					if (resp) {
						this.blog = resp.data.article
						this.cateId = resp.data.article.cid
						this.tagId = resp.data.article.tid
						this.getCateName()
						this.getTagName()
					}
				})
			},
			getCateName() {
				this.cateName = "love"
				myRequest({
					url: "/blog/category/info/" + this.cateId
				}).then(resp => {
					if (resp) {
						this.cateName = resp.data.category.catename
					}
				})
			},
			getTagName() {
				myRequest({
					url: "/blog/tags/info/" + this.tagId
				}).then(resp => {
					if (resp) {
						this.tagName = resp.data.tags.tagname
					}
				})
			}
		}
	}
</script>

<style>
	.DrawerPage {
		position: fixed;
		width: 100vw;
		height: 100vh;
		left: 0vw;
		background-color: #f1f1f1;
		transition: all 0.4s;
	}

	.tagAndCate {
		margin: 5px 0 5px 4px;
	}
	.tagAndCate .cu-tag{
		margin: 2px 0 0 2px;
	}
</style>
