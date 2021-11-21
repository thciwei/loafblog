<template>
	<scroll-view scroll-y class="scrollPage">
		<view class="UCenter-bg">
			<image src="https://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/%E9%9D%A2%E5%8C%85.png" class="png"
				mode="widthFix"></image>
			<view class="text-xl" style="color: #000000;">面包博客
			</view>
			<image src="../../static/wave.gif" mode="scaleToFill" class="gif-wave"></image>
		</view>
		<view class="padding flex text-center text-grey bg-white shadow-warp ">

			<view class="flex flex-sub flex-direction solid-right">
				<navigator open-type="reLaunch" class="content" url="/pages/cate/index"
					hover-class="other-navigator-hover">
					<view class="margin-top-sm text-xxl">
						<text class="cuIcon-sort " style="color: #319bfd;"></text>
					</view>
					<view class="text-grey">
						<text>分类</text>
					</view>
				</navigator>
			</view>

			<view class="flex flex-sub flex-direction solid-right" @tap="showModal" data-target="DrawerModalR">
				<view class="margin-top-sm text-xxl">
					<text class="cuIcon-searchlist" style="color: #319bfd;"></text>
				</view>
				<view class="text-grey">
					<text>归档</text>
				</view>
			</view>

			<view class="flex flex-sub flex-direction solid-right">
				<view class="margin-top-sm text-xxl">
					<text class="cuIcon-service   text-blue"></text>
				</view>
				<view class="text-grey">
					<text>关于我</text>
				</view>
			</view>
		</view>
		<view class="cu-list menu card-menu margin-top-xl margin-bottom-xl shadow-lg radius">
			<view class="cu-item arrow" @tap="goGit()">
				<view class="content">
					<text class="cuIcon-github text-grey"></text>
					<text class="text-grey">GitHub</text>
				</view>

			</view>
			<view class="cu-item arrow">
				<navigator class="content" url="/pages/cate/index" hover-class="none">
					<text class="cuIcon-formfill text-green"></text>
					<text class="text-grey">日志</text>
				</navigator>
			</view>
			<view class="cu-item arrow" @tap="gotoFriend()">
				<view class="content" bindtap="showQrcode">
					<text class="cuIcon-appreciatefill text-red"></text>
					<text class="text-grey">友链展示</text>
				</view>
			</view>
			<view class="cu-item arrow" @tap="showModal" data-target="DialogModal1">
				<view class=" content" open-type="feedback">
					<text class="cuIcon-writefill text-cyan"></text>
					<text class="text-grey">友链申请</text>
				</view>
			</view>
			<view class="cu-item arrow">
				<navigator class="content" url="/pages/about/test/list" hover-class="none">
					<text class="cuIcon-creativefill text-orange"></text>
					<text class="text-grey">退出登录</text>
				</navigator>
			</view>
			<view class="cu-modal" :class="modalName=='DialogModal1'?'show':''">
				<view class="cu-dialog">
					<view class="cu-bar bg-white justify-end">
						<view class="content">友链申请</view>
						<view class="action" @tap="hideModal">
							<text class="cuIcon-close text-red"></text>
						</view>
					</view>
					<view class="padding-xl">
						<view class="">
							<u-form :model="form" ref="uForm">
								<u-form-item label="邮箱" prop="mail">
									<u-input v-model="form.mail" />
								</u-form-item>
								<u-form-item label="简介" prop="content">
									<u-input v-model="form.content" />
								</u-form-item>
							</u-form>
							<u-button @click="submit">提交</u-button>
						</view>
					</view>


				</view>
			</view>
			<view class="timelines cu-modal drawer-modal justify-end" :class="modalName=='DrawerModalR'?'show':''"
				@tap="hideModal">
				<view class=" cu-dialog basis-lg" @tap.stop=""
					:style="[{top:CustomBar+'px',height:'calc(100vh - ' + CustomBar + 'px)'}]">
					<scroll-view scroll-y class="DrawerWindow " :class="modalName=='viewModal'?'show':''">
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

				</view>
			</view>
		</view>
		<u-toast ref="uToast" />
		<u-tabbar :list="tabbar" :mid-button="false"></u-tabbar>
	</scroll-view>



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
			...mapState(['tabbar']),

		},
		data() {
			return {
				modalName: null,
				files: [],
				form: {
					mail: '',
					content: '',
				},
				rules: {
					mail: [{
						required: true,
						// min: 12,
						type: 'email',
						message: '需要符合邮箱格式',
						trigger: ['change', 'blur'],
					}],
					content: [{
						required: true,
						min: 5,
						message: '简介不能少于5个字',
						trigger: 'change'
					}]
				}
			}
		},

		onLoad() {

		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {
			initTimeLine() {
				myRequest({
					url: "/blog/web/file"
				}).then(resp => {
					if (resp) {

						this.files = resp.data.data
					}
				})
			},
			goGit() {
				uni.navigateTo({
					url: "./gitpage"
				})
			},
			submit() {
				this.$refs.uForm.validate(valid => {
					if (valid) {
						console.log('验证通过');
						myRequest({
							url: "/blog/info/save",
							data: this.form,
							method: "POST"
						}).then(resp => {
							if (resp) {
								this.modalName = null
								this.$refs.uToast.show({
									title: '马上我就会回复你啦',
									type: 'success',
								})
							} else {
								this.modalName = null
								this.$refs.uToast.show({
									title: '提交失败',
									type: 'error',
								})
							}
						})


					} else {
						console.log('验证失败');
					}
				});
			},
			showModal(e) {
				this.modalName = e.currentTarget.dataset.target
				this.initTimeLine()
			},
			hideModal(e) {
				this.modalName = null
			},
			gotoFriend() {
				uni.navigateTo({
					url: "./websites"
				})
			}

		}
	}
</script>

<style scoped>
	
	.DrawerWindow {
		position: absolute;
		height: 100vh;
		left: 0;
		top: 0;
	}
	
	.UCenter-bg {
		background-image: url("/static/bg3.jpeg");
		background-size: cover;
		height: 500rpx;
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
