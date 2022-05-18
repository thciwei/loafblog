# 面包博客
<div align="center">
<img src="http://tva1.sinaimg.cn/large/006yRl4Gly1h2cytl2jy8j305k05kwey.jpg"/>
    <p >
        面包博客,一个微服务架构的前后端分离博客系统
    </p>
<img src="https://img.shields.io/badge/license-Apache--2.0-blue"/>
<img src="https://img.shields.io/badge/JDK-1.8%2B-brightgreen"/>
<img src="https://img.shields.io/badge/SpringBoot-2.1.8.RELEASE-brightgreen"/>
<img src="https://img.shields.io/badge/SpringCloud-Greenwich.SR6-brightgreen"/>
<img src="https://img.shields.io/badge/vue-2.6.11-yellow"/>
<img src="https://img.shields.io/badge/mybatis--plus-3.3.1-yellowgreen"/>
<img src="https://img.shields.io/badge/swagger-3.0.0-green"/>
</div>




#### 前言

在学习的过程中，最重要的是把学到的技术系统的进行整合，最后做到融会贯通，正巧作者学校开设的云计算课程讲到了现代微服务的整体理论流程，这让作者有了尝试技术落地与实现的想法，在这种诉求下，面包博客就诞生了，你可能在它的身上会看到很多开源项目的影子，所以它更像作者大三时期的一个不成熟的练习产物。**为什么叫面包博客？loaf 是现实中被裹胁的物质生活，亦是人们虚度的光阴**

#### 项目介绍

面包博客( **loafBlog** )，一个**基于微服务架构的前后端分离博客系统**。Web端使用 **Vue** + **ElementUi** ，移动端使用**uniapp**+**ColorUI**。后端使用 **SpringCloud** + **Mybatis-plus**进行开发，使用 **Jwt** 做登录验证和权限校验，使用**ElasticSearch** 作为全文检索服务，使用 **Github Actions**完成博客的持续集成，使用 **ElasticStack** 收集博客日志，文件支持**上传本地**、**阿里云OSS** 。


#### 项目特点

* 良好的代码结构，配有清晰的注释，方便阅读
* 前后端分离开发
* 引入**swagger3** 文档支持，便于编写**API**文档
* 引入**JustAuth**第三方登录，支持**Github**、**Gitee**、**微博**登录
* 引入**Nacos**作为服务发现注册与分布式配置中心，方便配置与管理
* 引入**RabbitMQ**消息队列，实现邮件的发送
* 引入**阿里云OSS**对象存储，支持文件的上传
* 引入**FastDFS**分布式数据库，支持私人的文件上传
* 通过**Github Action**将服务统一打包成镜像，使用**DockerCompose**进行容器编排，实现**CI/CD**

#### 站点演示
* [面包博客简易演示地址，门户网站](http://8.129.122.160:8888/)
* [面包博客简易演示地址，管理后台](http://8.129.122.160:8001/) 账号 visitor 密码 123
* 由于服务器过于轻量，只启动少量模块
#### 项目地址
* Gitee地址：https://gitee.com/thciweicloud/loafblog
* Github地址：https://github.com/thciwei/loafblog



#### 项目目录

* loafblog 面包博客，管理与门户一体化的博客系统
* loafblog-auth-server **认证中心**，第三方登录、单点登录
* loafblog-common **公共模块**，主要存放常用的utils工具类、entity实体类
* loafblog-gateway **蓝牙网关**，所有接口通过统一的过滤
* loafblog-mail **邮件服务**，用于添加友链发送邮件
* loafblog-picture **第三方服务**，主要是OSS存储、短信发送
* loafblog-search **搜索服务**，全文博客的检索
* renren-fast  **admin端**，博客管理后台
* loafblog_vue 面包博客**管理端**页面
* loafblog_vue_web 面包博客**门户**页面
* loablog_uniapp 面包博客**移动端**

#### 技术选型

##### 技术架构

![](http://tva1.sinaimg.cn/large/006yRl4Gly1h2czfhwmuuj321d1ejb29.jpg)

> 面包博客架构图由 [ProcessOn](https://www.processon.com/) 绘制



##### 后端技术

|      技术      |       描述        |                       官方                        |
| :------------: | :---------------: | :-----------------------------------------------: |
|  SpringCloud   |    微服务框架     |      https://spring.io/projects/spring-cloud      |
|   SpringBoot   |      MVC框架      |      https://spring.io/projects/spring-boot       |
|  MyBatis-Plus  |      ORM框架      |             https://mp.baomidou.com/              |
|    Swagger     |  API文档生成工具  |                https://swagger.io/                |
|      JWT       |     登录鉴权      |           https://github.com/jwtk/jjwt            |
| Elasticsearch  |     搜索引擎      |     https://www.elastic.co/cn/elasticsearch/      |
|     Kibana     | 分析和可视化平台  |         https://www.elastic.co/cn/kibana          |
|     Beats      | 轻量型数据采集器  |         https://www.elastic.co/cn/beats/          |
|    Logstash    | 接收Beats数据处理 |        https://www.elastic.co/cn/logstash         |
|     Docker     |    虚拟容器化     | [https://www.docker.com](https://www.docker.com/) |
|    RabbitMQ    |     消息队列      |             https://www.rabbitmq.com/             |
|     Redis      |    分布式缓存     |                 https://redis.io/                 |
|     Nginx      | 反向代理web服务器 |                 http://nginx.org/                 |
|     Druid      |   数据库连接池    |         https://github.com/alibaba/druid          |
|    JustAuth    |  第三方登录工具   |              https://justauth.wiki/               |
|     SLF4J      |     日志框架      |               http://www.slf4j.org/               |
|     Lombok     | 简化对象封装工具  |            https://projectlombok.org/             |
|    uni-sms     |   短信服务平台    |            https://unisms.apistd.com/             |
| Docker Compose |  Docker容器编排   |         https://docs.docker.com/compose/          |
|   Prometheus   |  可视化数据监控   |              https://prometheus.io/               |
|    Grafana     |   数据监控面板    |               https://grafana.com/                |
|     Zipkin     |     链路追踪      |       https://github.com/openzipkin/zipkin        |

##### 前端技术

|       技术       |           描述            |                      官方                      |
| :--------------: | :-----------------------: | :--------------------------------------------: |
|      Vue.js      |      渐进式前端框架       |               https://vuejs.org/               |
|    Vue Router    |  Vue.js 官方的路由管理器  |          https://router.vuejs.org/zh/          |
|       Vuex       | Vue.js 官方的状态管理模式 |           https://vuex.vuejs.org/zh/           |
|    Element-ui    |      Vue.js的ui框架       |        https://element.eleme.cn/#/zh-CN        |
|      Axios       |  基于 promise 的 HTTP 库  |            http://www.axios-js.com/            |
|     Echarts      |     开源可视化图表库      |    https://echarts.apache.org/zh/index.html    |
|      Vditor      |      Markdown 编辑器      |       https://github.com/thciwei/vditor        |
| vue-side-catalog |        目录导航栏         | https://github.com/yaowei9363/vue-side-catalog |
|     VueStar      |         点赞插件          |        https://github.com/OYsun/VueStar        |
|  vue-clipboard2  |        剪切板工具         |    https://github.com/Inndy/vue-clipboard2     |
|      uniapp      |      开发跨平台框架       |           https://uniapp.dcloud.io/            |
|     ColorUI      |         css样式库         |      https://github.com/weilanwl/ColorUI       |





#### 开发环境

|     工具      | 版本    |                     下载                     |
| :-----------: | ------- | :------------------------------------------: |
|      JDK      | 1.8     |            https://www.oracle.com            |
|     MySQL     | 5.7     |            https://www.mysql.com/            |
|     Maven     | 3.8.1   |           http://maven.apache.org/           |
|    Docker     | 20.10.7 |           https://www.docker.com/            |
|   RabbitMQ    | 3.8     |    http://www.rabbitmq.com/download.html     |
|     Redis     | 6.2.4   |          https://redis.io/download           |
|     Nacos     | 1.4.2   |  https://github.com/alibaba/nacos/releases   |
|   Sentinel    |         | https://github.com/alibaba/Sentinel/releases |
|    Zipkin     |         |     https://github.com/openzipkin/zipkin     |
| Elasticsearch | 7.4.2   |   https://www.elastic.co/cn/elasticsearch/   |
|    node.js    | 14.18.1 |            https://nodejs.org/en/            |
|      npm      | 6.14.15 |                                              |

**开发工具**

|     工具     |       描述        |                    官方                     |
| :----------: | :---------------: | :-----------------------------------------: |
|     IDEA     |    Java开发IDE    |   https://www.jetbrains.com/idea/download   |
|   WebStorm   |    前端开发IDE    |     https://www.jetbrains.com/webstorm/     |
|   X-shell    | Linux远程连接工具 |       https://xshell.en.softonic.com/       |
|    X-ftp     | Linux文件传输工具 | https://www.netsarang.com/zh/all-downloads/ |
| SwitchHosts  | 本地Host管理工具  |     https://oldj.github.io/SwitchHosts/     |
| RedisDesktop |  Redis可视化工具  |      https://redisdesktop.com/download      |
|   Navicat    |  数据库管理工具   |         https://www.navicat.com.cn/         |
|  Hbuilder X  |    前端开发IDE    |    https://www.dcloud.io/hbuilderx.html     |



#### 推荐学习

* 学习陌溪大佬的 [蘑菇博客](https://gitee.com/moxi159753/mogu_blog_v2?_from=gitee_search) 技术处理方法和基础微服务架构
* 学习 [谷粒商城](https://gitee.com/agoni_no/gulimall?_from=gitee_search) 的业务架构模式
* 学习技术，重视技术过程，先简化省略基础CRUD代码，使用 [人人开源](https://gitee.com/renrenio/renren-fast?_from=gitee_search) 组件
* 学习简洁风格的前端样式，[fenziy](https://gitee.com/fengziy) 大佬的博客样式



## 项目展示



| WEB端                                                        |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg7vxobhj31hc0oz7fm.jpg) | ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9iw6hij31hc0oz45a.jpg) |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9mgahoj31hc0ozqa2.jpg) | ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9n3q8nj31hc0oz7bg.jpg) |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9ogbuxj31hc0ozn4w.jpg) | ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9rk2ebj31hc0oztkg.jpg) |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9rl7b5j31hc0oz799.jpg) |                                                              |
| **管理端**                                                   |                                                              |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9uuq8pj31hc0ozwrl.jpg) | ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9wok0ej31hc0oz110.jpg) |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9yb2qxj31hc0ozdr0.jpg) | ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9zj8otj31hc0ozajm.jpg) |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxga113zij31hc0ozwo9.jpg) | ![admin_4.png](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxgov2tgmj31hc0oz4as.jpg) |
| ![admin_5.png](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxgpoyqc5j31hc0oz7jk.jpg) |                                                              |
| **监控**                                                     |                                                              |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9rakn4j31hc0oz49q.jpg) | ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9vrjaqj31hc0oz7a7.jpg) |
| ![](http://tva1.sinaimg.cn/large/006yRl4Gly1gwxg9vzl6fj31hc0oz7df.jpg) | ![](http://tva1.sinaimg.cn/large/006yRl4Gly1h2cdhod7ypj31g00oxk3f.jpg)                                                             |



**移动端**

![](https://github.com/thciwei/theVhr/blob/0e367386c60cb5b84288ba78fd37ed30a477945c/springboot_vhr/src/assets/006yRl4Gly1gwxga1vkrfg30910jme87.gif)

