const Mock = require('mockjs');
const List = [{
    id: 0,
    siteName: "thciwei′blog",
    path: "https://gitee.com/thciweicloud/loafblog",
    desc: "一个微服务博客"
}]
const count = 15

for (let i = 0; i < count; i++) {
    List.push(Mock.mock({
        id: '@increment',
        siteName: "@cname",
        path: "@url",
        desc: "@ctitle(5,20)"
    }))
}

export default [
    {
        url: '/friend',
        type: 'get',
        response: config => {
            return {
                code: 20000,
                data: List
            }
        }
    }
]
