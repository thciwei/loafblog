import {envConfig} from '../config/env.js'
// const WEB_API='http://localhost:88/api'
// const TEST_API='http://192.168.31.72:88/api'
export const myRequest=(options)=>{ //传入的options是一个json对象
	return new Promise((resolve,reject)=>{
		uni.request({
			url:envConfig.TEST_API+options.url,
			method:options.methods||"GET",
			data:options.data || {},
			dataType:options.dataType || "json",
			success: (res) => {
				if(res.data.code != 0){
					return uni.showToast({
						title:"获取数据失败"
					})
					
				}
				resolve(res)
			},
			fail: (err) => {
				uni.showToast({
					title:"接口请求失败"
				})
				reject(err)
			}
		})
	})
}