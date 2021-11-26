<template>
	<view class="bg-white">
		<cu-custom bgColor=" bg-gradual-blue" :isBack="true">
			<block slot="content">登录</block>
		</cu-custom>
		<scroll-view scroll-y class="scrollPage">
			<view class="UCenter-bg">
				<image src="https://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/%E9%9D%A2%E5%8C%85.png"
					class="png" mode="widthFix"></image>
				<view class="text-xl" style="color: #000000;">面包博客
				</view>
				<image src="../../static/wave.gif" mode="scaleToFill" class="gif-wave"></image>
			</view>
			<view class="padding-xl">
				<view class="">
					<u-form :model="form" ref="uForm">
						<u-form-item label="用户" prop="loginacct">
							<u-input v-model="form.loginacct" border="true" placeholder="请输入用户名" />
						</u-form-item>
						<u-form-item label="密码" prop="password">
							<u-input v-model="form.password" type="password" border="true" placeholder="请输入密码" />
						</u-form-item>
					</u-form>
					<view class="padding">
						<button class="cu-btn block bg-blue margin-tb-sm lg" @click="submit"  type="">登录</button>
						<button class="cu-btn block line-blue margin-tb-sm lg" >注册</button>
					</view>
					<!-- <view class="padding">
						<u-button @click="submit">登录</u-button>
						<u-button>注册</u-button>
					</view> -->

				</view>
				<u-toast ref="uToast" />
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
				form: {
					loginacct: '',
					password: '',
				},
				rules: {
					loginacct: [{
						required: true,
						min: 1,
						message: '不能少于1个字',
						trigger: ['change', 'blur'],
					}],
					password: [{
						required: true,
						min: 5,
						message: '密码不能少于5个字',
						trigger: 'change'
					}]
				}
			}
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {
			submit() {
				this.$refs.uForm.validate(valid => {
					if (valid) {
						console.log("验证成功")
						myRequest({
							methods: "POST",
							url: "/blog/userauth/unilogin",
							data: this.form,

						}).then(resp => {
							if (resp) {
								console.log(resp)
								uni.setStorageSync('token', resp.data.token);

								this.$refs.uToast.show({
									title: '登陆成功',
									type: 'success',
								})
								uni.navigateBack({
									url:'my'
								})
								
							} else {
								this.$refs.uToast.show({
									title: '登录失败',
									type: 'error',
								})
							}
						})


					} else {
						console.log('验证失败');
					}
				});
			},
		}
	}
</script>

<style scoped>
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
</style>
