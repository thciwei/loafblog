let proxyObj = {};
// proxyObj['/ws'] = {
//     ws: true,
//     target: "ws://localhost:88/api/blog"
// };
// proxyObj['/api'] = {
//     ws: true,
//     target: 'http://localhost:88',
//     changeOrigin: true,
//     // pathRewrite: {
//     //     '^/api': ''
//     // }
// }

proxyObj['/'] = {
    ws: true,
    target: 'http://localhost:88/api',
    changeOrigin: true,
    // pathRewrite: {
    //     '^/api': ''
    // }
}



module.exports = {
    devServer: {
        host: '0.0.0.0',
        port: 8888,
        proxy:proxyObj,
        disableHostCheck:true
    },


  //  lintOnSave: false
}
