const Mock = require('mockjs');
export default [
    {
        url: '/focus/list',
        type: 'get',
        response: () => {
            return {
                code: 20000,
                data: [
                    {
                        id: 1,
                        title: 'LearningNotes',
                        img: 'https://s1.ax1x.com/2020/05/14/YDfRnU.jpg',
                        href: 'friend'
                    },
                    {
                        id: 2,
                        title: '项目地址',
                        img: 'https://gitee.com/thciweicloud/tmp/raw/master/tutu.jpg',
                        href: 'about'
                    },
                    {
                        id: 3,
                        title: '文章归档',
                        img: 'https://s1.ax1x.com/2020/05/14/YDfT91.jpg',
                        href: 'fileArticle'
                    }
                ]
            }
        }
    }
]
