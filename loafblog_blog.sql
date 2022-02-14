/*
 Navicat Premium Data Transfer

 Source Server         : linuxMysql
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : 192.168.145.132:3306
 Source Schema         : loafblog_blog

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 15/11/2021 19:37:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '博客id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `tid` int(11) NULL DEFAULT NULL COMMENT '标签id',
  `cid` int(11) NULL DEFAULT NULL COMMENT '分类id',
  `mdContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'md格式内容',
  `htmlContent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'html格式内容',
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '梗概',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '博客封面',
  `publishDate` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `isOriginal` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否原创【0-否,1-是】',
  `isComment` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否评论【0-否,1-是】',
  `number` int(11) NULL DEFAULT NULL COMMENT '文章字数',
  `state` int(4) NOT NULL DEFAULT 0 COMMENT '状态【0-存在,1-已删除】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '博客内容和属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, 'Linux中安装zookeeper', 1, 4, '最近打算出一个系列，介绍Dubbo的使用。\n\n---\n分布式应用现在已经越来越广泛，Spring Could也是一个不错的一站式解决方案，不过据我了解国内目前貌似使用阿里Dubbo的公司比较多，一方面这个框架也确实很OK，另一方面可能也是因为Dubbo的中文文档比较全的缘故，据Dubbo官网上的消息，阿里已经重新开始了对Dubbo的维护，这也算是使用Dubbo的互联网公司的福音了吧。OK，废话不多说，今天我们就先来看看如何在Linux上安装zookeeper。\n\n---\n\n了解过Dubbo的小伙伴都知道，Dubbo官方建议我们使用的注册中心就是zookeeper，zookeeper本来是Hadoop的一个子项目，现在发展成了Apache的顶级项目，看名字就知道Zookeeper就是动物园管理员，管理Hadoop(大象)、Hive(蜂房/蜜蜂)等动物。Apache上的Zookeeper分Linux版和Windows版，但是考虑到实际生产环境都是Linux，所以我们这里主要介绍Linux上Zookeeper的安装，Windows上Zookeeper的安装则比较简单，下载解压即可，和Tomcat差不多。\n\nOK，废话不多说，接下来我们就来看看zookeeper的安装步骤。\n\n---\n环境：\n>1.VMware® Workstation 12 Pro  \n>2.CentOS7  \n>3.zookeeper-3.4.10(本文写作时的最新稳定版)  \n\n---\n# 安装步骤\n1.下载zookeeper\n\nzookeeper下载地址如下，小伙伴们可以在第一个地址中选择适合自己的zookeeper版本，也可以直接点击第二个地址下载我们本文使用的zookeeper。\n\n>1.[http://mirrors.hust.edu.cn/apache/zookeeper/](http://mirrors.hust.edu.cn/apache/zookeeper/)  \n\n>2.[http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz](http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz)\n\n\n\n2.将下载好的zookeeper上传到Linux服务器上\n\n上传方式多种多样，我这里采用了xftp，小伙伴们也可以直接使用putty上传，上传结果如下：\n![这里写图片描述](http://img.blog.csdn.net/20170825114622362?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n3.将文件解压到/opt目录下  \n\n![这里写图片描述](http://img.blog.csdn.net/20170825115122378?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n4.进入到刚刚解压好的目录中，创建两个文件夹，分别是data和logs，如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115324970?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n5.将解压后zookeeper-3.4.10文件夹下的zoo_sample.cfg文件拷贝一份命名为zoo.cfg，如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115426251?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n6.修改zoo.cfg文件，添加data和log目录，如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115527367?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n>1.2888 端口号是zookeeper服务之间通信的端口   \n>2.3888 是zookeeper 与其他应用程序通信的端口  \n>3.initLimit：这个配置项是用来配置 Zookeeper 接受客户端（这里所说的客户端不是用户连接 Zookeeper服务器的客户端，而是 Zookeeper 服务器集群中连接到 Leader 的 Follower 服务器）初始化连接时最长能忍受多少个心跳时间间隔数。当已经超过 10 个心跳的时间（也就是 tickTime）长度后 Zookeeper 服务器还没有收到客户端的返回信息，那么表明这个客户端连接失败。总的时间长度就是 5*2000=10 秒。  \n>4.syncLimit：这个配置项标识 Leader 与 Follower 之间发送消息，请求和应答时间长度，最长不能超过多少个 tickTime 的时间长度，总的时间长度就是 2*2000=4 秒  \n>5.server.A=B:C:D：其中 A 是一个数字，表示这个是第几号服务器；B 是这个服务器的IP地址或/etc/hosts文件中映射了IP的主机名；C 表示的是这个服务器与集群中的 Leader 服务器交换信息的端口；D 表示的是万一集群中的 Leader 服务器挂了，需要一个端口来重新进行选举，选出一个新的 Leader，而这个端口就是用来执行选举时服务器相互通信的端口。如果是伪集群的配置方式，由于 B 都是一样，所以不同的 Zookeeper 实例通信端口号不能一样，所以要给它们分配不同的端口号。\n\n7.在 dataDir=/opt/zookeeper-3.4.10/data下创建 myid文件 编辑myid文件，并在对应的IP的机器上输入对应的编号。如在zookeeper上，myid文件内容就是1。如果只在单点上进行安装配置，那么只有一个server.1。如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115647920?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n8.在.bash_profile文件中增加zookeeper配置：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115729473?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n9.使配置生效\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115807787?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n10.关闭防火墙\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115848488?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n11.启动并测试\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115938795?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n>启动之后如果能看到Mode:standalone就表示启动成功了。\n\n12.关闭zookeeper\n\n![这里写图片描述](http://img.blog.csdn.net/20170825121021364?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n13.配置开机启动zookeeper\n\n![这里写图片描述](http://img.blog.csdn.net/20170825121059827?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n>**注意注意** 在centos7中，/etc/rc.local的权限被降低了，所以需要执行如下命令赋予其可执行权限\n```chmod +x /etc/rc.d/rc.local```\n\n\nOK,以上就是我们在CentOS7中安装zookeeper的全过程，做好这一切之后我们就可以在Dubbo中使用这个注册中心了，这个我们放在下一篇博客中介绍。\n\n更多JavaEE资料请关注公众号：\n\n![](http://img.blog.csdn.net/20170823174820001?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)', '<p>最近打算出一个系列，介绍Dubbo的使用。</p>\n<hr />\n<p>分布式应用现在已经越来越广泛，Spring Could也是一个不错的一站式解决方案，不过据我了解国内目前貌似使用阿里Dubbo的公司比较多，一方面这个框架也确实很OK，另一方面可能也是因为Dubbo的中文文档比较全的缘故，据Dubbo官网上的消息，阿里已经重新开始了对Dubbo的维护，这也算是使用Dubbo的互联网公司的福音了吧。OK，废话不多说，今天我们就先来看看如何在Linux上安装zookeeper。</p>\n<hr />\n<p>了解过Dubbo的小伙伴都知道，Dubbo官方建议我们使用的注册中心就是zookeeper，zookeeper本来是Hadoop的一个子项目，现在发展成了Apache的顶级项目，看名字就知道Zookeeper就是动物园管理员，管理Hadoop(大象)、Hive(蜂房/蜜蜂)等动物。Apache上的Zookeeper分Linux版和Windows版，但是考虑到实际生产环境都是Linux，所以我们这里主要介绍Linux上Zookeeper的安装，Windows上Zookeeper的安装则比较简单，下载解压即可，和Tomcat差不多。</p>\n<p>OK，废话不多说，接下来我们就来看看zookeeper的安装步骤。</p>\n<hr />\n<p>环境：</p>\n<blockquote>\n<p>1.VMware® Workstation 12 Pro<br />\n2.CentOS7<br />\n3.zookeeper-3.4.10(本文写作时的最新稳定版)</p>\n</blockquote>\n<hr />\n<h1>安装步骤</h1>\n<p>1.下载zookeeper</p>\n<p>zookeeper下载地址如下，小伙伴们可以在第一个地址中选择适合自己的zookeeper版本，也可以直接点击第二个地址下载我们本文使用的zookeeper。</p>\n<blockquote>\n<p>1.<a href=\"http://mirrors.hust.edu.cn/apache/zookeeper/\" target=\"_blank\">http://mirrors.hust.edu.cn/apache/zookeeper/</a></p>\n</blockquote>\n<blockquote>\n<p>2.<a href=\"http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz\" target=\"_blank\">http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz</a></p>\n</blockquote>\n<p>2.将下载好的zookeeper上传到Linux服务器上</p>\n<p>上传方式多种多样，我这里采用了xftp，小伙伴们也可以直接使用putty上传，上传结果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170825114622362?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>3.将文件解压到/opt目录下</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115122378?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>4.进入到刚刚解压好的目录中，创建两个文件夹，分别是data和logs，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115324970?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>5.将解压后zookeeper-3.4.10文件夹下的zoo_sample.cfg文件拷贝一份命名为zoo.cfg，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115426251?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>6.修改zoo.cfg文件，添加data和log目录，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115527367?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<blockquote>\n<p>1.2888 端口号是zookeeper服务之间通信的端口<br />\n2.3888 是zookeeper 与其他应用程序通信的端口<br />\n3.initLimit：这个配置项是用来配置 Zookeeper 接受客户端（这里所说的客户端不是用户连接 Zookeeper服务器的客户端，而是 Zookeeper 服务器集群中连接到 Leader 的 Follower 服务器）初始化连接时最长能忍受多少个心跳时间间隔数。当已经超过 10 个心跳的时间（也就是 tickTime）长度后 Zookeeper 服务器还没有收到客户端的返回信息，那么表明这个客户端连接失败。总的时间长度就是 5<em>2000=10 秒。<br />\n4.syncLimit：这个配置项标识 Leader 与 Follower 之间发送消息，请求和应答时间长度，最长不能超过多少个 tickTime 的时间长度，总的时间长度就是 2</em>2000=4 秒<br />\n5.server.A=B:C:D：其中 A 是一个数字，表示这个是第几号服务器；B 是这个服务器的IP地址或/etc/hosts文件中映射了IP的主机名；C 表示的是这个服务器与集群中的 Leader 服务器交换信息的端口；D 表示的是万一集群中的 Leader 服务器挂了，需要一个端口来重新进行选举，选出一个新的 Leader，而这个端口就是用来执行选举时服务器相互通信的端口。如果是伪集群的配置方式，由于 B 都是一样，所以不同的 Zookeeper 实例通信端口号不能一样，所以要给它们分配不同的端口号。</p>\n</blockquote>\n<p>7.在 dataDir=/opt/zookeeper-3.4.10/data下创建 myid文件 编辑myid文件，并在对应的IP的机器上输入对应的编号。如在zookeeper上，myid文件内容就是1。如果只在单点上进行安装配置，那么只有一个server.1。如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115647920?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>8.在.bash_profile文件中增加zookeeper配置：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115729473?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>9.使配置生效</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115807787?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>10.关闭防火墙</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115848488?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>11.启动并测试</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115938795?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<blockquote>\n<p>启动之后如果能看到Mode:standalone就表示启动成功了。</p>\n</blockquote>\n<p>12.关闭zookeeper</p>\n<p><img src=\"http://img.blog.csdn.net/20170825121021364?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>13.配置开机启动zookeeper</p>\n<p><img src=\"http://img.blog.csdn.net/20170825121059827?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<blockquote>\n<p><strong>注意注意</strong> 在centos7中，/etc/rc.local的权限被降低了，所以需要执行如下命令赋予其可执行权限<br />\n<code>chmod +x /etc/rc.d/rc.local</code></p>\n</blockquote>\n<p>OK,以上就是我们在CentOS7中安装zookeeper的全过程，做好这一切之后我们就可以在Dubbo中使用这个注册中心了，这个我们放在下一篇博客中介绍。</p>\n<p>更多JavaEE资料请关注公众号：</p>\n<p><img src=\"http://img.blog.csdn.net/20170823174820001?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"\" /></p>\n', '最近打算出一个系列，介绍Dubbo的使用。\n\n分布式应用现在已经越来越广泛，Spring Could', 'https://gitee.com/thciweicloud/tmp/raw/master/jiageng3%20.jpg', '2021-09-04 11:19:11', 1, 0, 66, 0);
INSERT INTO `article` VALUES (2, 'Ajax上传图片以及上传之前先预览', 2, 2, '手头上有几个小项目用到了easyUI，一开始决定使用easyUI就注定了项目整体上前后端分离，基本上所有的请求都采用Ajax来完成。在文件上传的时候用到了Ajax上传文件，以及图片在上传之前的预览效果，解决了这两个小问题，和小伙伴们分享下。\n\n---\n# 上传之前的预览\n\n## 方式一\n先来说说图片上传之前的预览问题。这里主要采用了HTML5中的FileReader对象来实现，关于FileReader对象，如果小伙伴们不了解，可以查看这篇博客[HTML5学习之FileReader接口](http://blog.csdn.net/zk437092645/article/details/8745647/)。我们来看看实现方式：\n```\n<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Ajax上传文件</title>\n    <script src=\"jquery-3.2.1.js\"></script>\n</head>\n<body>\n用户名：<input id=\"username\" type=\"text\"><br>\n用户图像：<input id=\"userface\" type=\"file\" onchange=\"preview(this)\"><br>\n<div id=\"preview\"></div>\n<input type=\"button\" id=\"btnClick\" value=\"上传\">\n<script>\n    $(\"#btnClick\").click(function () {\n        var formData = new FormData();\n        formData.append(\"username\", $(\"#username\").val());\n        formData.append(\"file\", $(\"#userface\")[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    function preview(file) {\n        var prevDiv = document.getElementById(\'preview\');\n        if (file.files && file.files[0]) {\n            var reader = new FileReader();\n            reader.onload = function (evt) {\n                prevDiv.innerHTML = \'<img src=\"\' + evt.target.result + \'\" />\';\n            }\n            reader.readAsDataURL(file.files[0]);\n        } else {\n            prevDiv.innerHTML = \'<div class=\"img\" style=\"filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\\\'\' + file.value + \'\\\'\"></div>\';\n        }\n    }\n</script>\n</body>\n</html>\n```\n\n这里对于支持FileReader的浏览器直接使用FileReader来实现，不支持FileReader的浏览器则采用微软的滤镜来实现（注意给图片上传的input标签设置onchange函数）。\n实现效果如下：\n![这里写图片描述](http://img.blog.csdn.net/20170825184056537?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n\n## 方式二\n\n除了这种方式之外我们也可以采用网上现成的一个jQuery实现的方式。这里主要参考了[这里](http://keleyi.com/keleyi/phtml/image/16.htm)。\n不过由于原文年代久远，里边使用的```$.browser.msie```从jQuery1.9就被移除掉了，所以如果我们想使用这个得做一点额外的处理，我修改后的uploadPreview.js文件内容如下：\n```\njQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();\njQuery.fn.extend({\n    uploadPreview: function (opts) {\n        var _self = this,\n            _this = $(this);\n        opts = jQuery.extend({\n            Img: \"ImgPr\",\n            Width: 100,\n            Height: 100,\n            ImgType: [\"gif\", \"jpeg\", \"jpg\", \"bmp\", \"png\"],\n            Callback: function () {}\n        }, opts || {});\n        _self.getObjectURL = function (file) {\n            var url = null;\n            if (window.createObjectURL != undefined) {\n                url = window.createObjectURL(file)\n            } else if (window.URL != undefined) {\n                url = window.URL.createObjectURL(file)\n            } else if (window.webkitURL != undefined) {\n                url = window.webkitURL.createObjectURL(file)\n            }\n            return url\n        };\n        _this.change(function () {\n            if (this.value) {\n                if (!RegExp(\"\\.(\" + opts.ImgType.join(\"|\") + \")$\", \"i\").test(this.value.toLowerCase())) {\n                    alert(\"选择文件错误,图片类型必须是\" + opts.ImgType.join(\"，\") + \"中的一种\");\n                    this.value = \"\";\n                    return false\n                }\n                if ($.browser.msie) {\n                    try {\n                        $(\"#\" + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                    } catch (e) {\n                        var src = \"\";\n                        var obj = $(\"#\" + opts.Img);\n                        var div = obj.parent(\"div\")[0];\n                        _self.select();\n                        if (top != self) {\n                            window.parent.document.body.focus()\n                        } else {\n                            _self.blur()\n                        }\n                        src = document.selection.createRange().text;\n                        document.selection.empty();\n                        obj.hide();\n                        obj.parent(\"div\").css({\n                            \'filter\': \'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)\',\n                            \'width\': opts.Width + \'px\',\n                            \'height\': opts.Height + \'px\'\n                        });\n                        div.filters.item(\"DXImageTransform.Microsoft.AlphaImageLoader\").src = src\n                    }\n                } else {\n                    $(\"#\" + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                }\n                opts.Callback()\n            }\n        })\n    }\n});\n```\n\n然后在我们的html文件中引入这个js文件即可：\n```\n<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Ajax上传文件</title>\n    <script src=\"jquery-3.2.1.js\"></script>\n    <script src=\"uploadPreview.js\"></script>\n</head>\n<body>\n用户名：<input id=\"username\" type=\"text\"><br>\n用户图像：<input id=\"userface\" type=\"file\" onchange=\"preview(this)\"><br>\n<div><img id=\"ImgPr\" width=\"200\" height=\"200\"/></div>\n<input type=\"button\" id=\"btnClick\" value=\"上传\">\n<script>\n    $(\"#btnClick\").click(function () {\n        var formData = new FormData();\n        formData.append(\"username\", $(\"#username\").val());\n        formData.append(\"file\", $(\"#userface\")[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    $(\"#userface\").uploadPreview({Img: \"ImgPr\", Width: 120, Height: 120});\n</script>\n</body>\n</html>\n```\n\n这里有如下几点需要注意：\n>1.HTML页面中要引入我们自定义的uploadPreview.js文件\n>2.预先定义好要显示预览图片的img标签，该标签要有id。\n>3.查找到img标签然后调用uploadPreview函数\n\n执行效果如下：  \n![这里写图片描述](http://img.blog.csdn.net/20170825190203757?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n# Ajax上传图片文件\n\nAjax上传图片文件就简单了，没有那么多方案，核心代码如下：\n```\n        var formData = new FormData();\n        formData.append(\"username\", $(\"#username\").val());\n        formData.append(\"file\", $(\"#userface\")[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n```\n核心就是定义一个FormData对象，将要上传的数据包装到这个对象中去。然后在ajax上传数据的时候设置data属性就为formdata，processData属性设置为false，表示jQuery不要去处理发送的数据，然后设置contentType属性的值为false，表示不要设置请求头的contentType属性。OK，主要就是设置这三个，设置成功之后，其他的处理就和常规的ajax用法一致了。\n\n后台的处理代码大家可以在文末的案例中下载，这里我就不展示不出来了。\n\nOK，以上就是我们对Ajax上传图片以及图片预览的一个简介，有问题的小伙伴欢迎留言讨论。\n\n案例下载地址[http://download.csdn.net/download/u012702547/9950813](http://download.csdn.net/download/u012702547/9950813)\n\n由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。\n\n以上。\n', '<p>手头上有几个小项目用到了easyUI，一开始决定使用easyUI就注定了项目整体上前后端分离，基本上所有的请求都采用Ajax来完成。在文件上传的时候用到了Ajax上传文件，以及图片在上传之前的预览效果，解决了这两个小问题，和小伙伴们分享下。</p>\n<hr />\n<h1>上传之前的预览</h1>\n<h2>方式一</h2>\n<p>先来说说图片上传之前的预览问题。这里主要采用了HTML5中的FileReader对象来实现，关于FileReader对象，如果小伙伴们不了解，可以查看这篇博客<a href=\"http://blog.csdn.net/zk437092645/article/details/8745647/\" target=\"_blank\">HTML5学习之FileReader接口</a>。我们来看看实现方式：</p>\n<pre><code class=\"lang-\">&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;title&gt;Ajax上传文件&lt;/title&gt;\n    &lt;script src=&quot;jquery-3.2.1.js&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n用户名：&lt;input id=&quot;username&quot; type=&quot;text&quot;&gt;&lt;br&gt;\n用户图像：&lt;input id=&quot;userface&quot; type=&quot;file&quot; onchange=&quot;preview(this)&quot;&gt;&lt;br&gt;\n&lt;div id=&quot;preview&quot;&gt;&lt;/div&gt;\n&lt;input type=&quot;button&quot; id=&quot;btnClick&quot; value=&quot;上传&quot;&gt;\n&lt;script&gt;\n    $(&quot;#btnClick&quot;).click(function () {\n        var formData = new FormData();\n        formData.append(&quot;username&quot;, $(&quot;#username&quot;).val());\n        formData.append(&quot;file&quot;, $(&quot;#userface&quot;)[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    function preview(file) {\n        var prevDiv = document.getElementById(\'preview\');\n        if (file.files &amp;&amp; file.files[0]) {\n            var reader = new FileReader();\n            reader.onload = function (evt) {\n                prevDiv.innerHTML = \'&lt;img src=&quot;\' + evt.target.result + \'&quot; /&gt;\';\n            }\n            reader.readAsDataURL(file.files[0]);\n        } else {\n            prevDiv.innerHTML = \'&lt;div class=&quot;img&quot; style=&quot;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\\\'\' + file.value + \'\\\'&quot;&gt;&lt;/div&gt;\';\n        }\n    }\n&lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这里对于支持FileReader的浏览器直接使用FileReader来实现，不支持FileReader的浏览器则采用微软的滤镜来实现（注意给图片上传的input标签设置onchange函数）。<br />\n实现效果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170825184056537?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<h2>方式二</h2>\n<p>除了这种方式之外我们也可以采用网上现成的一个jQuery实现的方式。这里主要参考了<a href=\"http://keleyi.com/keleyi/phtml/image/16.htm\" target=\"_blank\">这里</a>。<br />\n不过由于原文年代久远，里边使用的<code>$.browser.msie</code>从jQuery1.9就被移除掉了，所以如果我们想使用这个得做一点额外的处理，我修改后的uploadPreview.js文件内容如下：</p>\n<pre><code class=\"lang-\">jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();\njQuery.fn.extend({\n    uploadPreview: function (opts) {\n        var _self = this,\n            _this = $(this);\n        opts = jQuery.extend({\n            Img: &quot;ImgPr&quot;,\n            Width: 100,\n            Height: 100,\n            ImgType: [&quot;gif&quot;, &quot;jpeg&quot;, &quot;jpg&quot;, &quot;bmp&quot;, &quot;png&quot;],\n            Callback: function () {}\n        }, opts || {});\n        _self.getObjectURL = function (file) {\n            var url = null;\n            if (window.createObjectURL != undefined) {\n                url = window.createObjectURL(file)\n            } else if (window.URL != undefined) {\n                url = window.URL.createObjectURL(file)\n            } else if (window.webkitURL != undefined) {\n                url = window.webkitURL.createObjectURL(file)\n            }\n            return url\n        };\n        _this.change(function () {\n            if (this.value) {\n                if (!RegExp(&quot;\\.(&quot; + opts.ImgType.join(&quot;|&quot;) + &quot;)$&quot;, &quot;i&quot;).test(this.value.toLowerCase())) {\n                    alert(&quot;选择文件错误,图片类型必须是&quot; + opts.ImgType.join(&quot;，&quot;) + &quot;中的一种&quot;);\n                    this.value = &quot;&quot;;\n                    return false\n                }\n                if ($.browser.msie) {\n                    try {\n                        $(&quot;#&quot; + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                    } catch (e) {\n                        var src = &quot;&quot;;\n                        var obj = $(&quot;#&quot; + opts.Img);\n                        var div = obj.parent(&quot;div&quot;)[0];\n                        _self.select();\n                        if (top != self) {\n                            window.parent.document.body.focus()\n                        } else {\n                            _self.blur()\n                        }\n                        src = document.selection.createRange().text;\n                        document.selection.empty();\n                        obj.hide();\n                        obj.parent(&quot;div&quot;).css({\n                            \'filter\': \'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)\',\n                            \'width\': opts.Width + \'px\',\n                            \'height\': opts.Height + \'px\'\n                        });\n                        div.filters.item(&quot;DXImageTransform.Microsoft.AlphaImageLoader&quot;).src = src\n                    }\n                } else {\n                    $(&quot;#&quot; + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                }\n                opts.Callback()\n            }\n        })\n    }\n});\n</code></pre>\n<p>然后在我们的html文件中引入这个js文件即可：</p>\n<pre><code class=\"lang-\">&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;title&gt;Ajax上传文件&lt;/title&gt;\n    &lt;script src=&quot;jquery-3.2.1.js&quot;&gt;&lt;/script&gt;\n    &lt;script src=&quot;uploadPreview.js&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n用户名：&lt;input id=&quot;username&quot; type=&quot;text&quot;&gt;&lt;br&gt;\n用户图像：&lt;input id=&quot;userface&quot; type=&quot;file&quot; onchange=&quot;preview(this)&quot;&gt;&lt;br&gt;\n&lt;div&gt;&lt;img id=&quot;ImgPr&quot; width=&quot;200&quot; height=&quot;200&quot;/&gt;&lt;/div&gt;\n&lt;input type=&quot;button&quot; id=&quot;btnClick&quot; value=&quot;上传&quot;&gt;\n&lt;script&gt;\n    $(&quot;#btnClick&quot;).click(function () {\n        var formData = new FormData();\n        formData.append(&quot;username&quot;, $(&quot;#username&quot;).val());\n        formData.append(&quot;file&quot;, $(&quot;#userface&quot;)[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    $(&quot;#userface&quot;).uploadPreview({Img: &quot;ImgPr&quot;, Width: 120, Height: 120});\n&lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这里有如下几点需要注意：</p>\n<blockquote>\n<p>1.HTML页面中要引入我们自定义的uploadPreview.js文件<br />\n2.预先定义好要显示预览图片的img标签，该标签要有id。<br />\n3.查找到img标签然后调用uploadPreview函数</p>\n</blockquote>\n<p>执行效果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170825190203757?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<h1>Ajax上传图片文件</h1>\n<p>Ajax上传图片文件就简单了，没有那么多方案，核心代码如下：</p>\n<pre><code class=\"lang-\">        var formData = new FormData();\n        formData.append(&quot;username&quot;, $(&quot;#username&quot;).val());\n        formData.append(&quot;file&quot;, $(&quot;#userface&quot;)[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n</code></pre>\n<p>核心就是定义一个FormData对象，将要上传的数据包装到这个对象中去。然后在ajax上传数据的时候设置data属性就为formdata，processData属性设置为false，表示jQuery不要去处理发送的数据，然后设置contentType属性的值为false，表示不要设置请求头的contentType属性。OK，主要就是设置这三个，设置成功之后，其他的处理就和常规的ajax用法一致了。</p>\n<p>后台的处理代码大家可以在文末的案例中下载，这里我就不展示不出来了。</p>\n<p>OK，以上就是我们对Ajax上传图片以及图片预览的一个简介，有问题的小伙伴欢迎留言讨论。</p>\n<p>案例下载地址<a href=\"http://download.csdn.net/download/u012702547/9950813\" target=\"_blank\">http://download.csdn.net/download/u012702547/9950813</a></p>\n<p>由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。</p>\n<p>以上。</p>\n', '手头上有几个小项目用到了easyUI，一开始决定使用easyUI就注定了项目整体上前后端分离，基本上', 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/1605004575968.jpg', '2020-09-04 11:19:15', 0, 0, 60, 0);
INSERT INTO `article` VALUES (3, 'Git学习资料', 3, 3, '关于Git的用法我们已经写七篇文章，介绍了Git的不少用法，这些足以应付工作中90%的需求了，剩下的10%就需要小伙伴们在工作中自己慢慢总结了，我这里再给小伙伴们推荐一点Git学习资料，为我们的Git系列画上一个句号。  \n\n\n![Image 012.png](http://localhost:80/blogimg/20171224/9f628a1d-2acd-412f-b9a6-b52acf779138_Image012.png)\n\n## 书\n\n推荐两本个人觉得很不错的书：  \n\n1.《GitHub入门与实践》  \n2.《Pro Git》  \n\n《GitHub入门与实践》秉承了日系技术书刊一贯的“手把手教学”风格，作者用亲切的语言，简明扼要的介绍，配以生动详实的示例一步步讲解GitHub和Git的使用方法。《Pro Git》作为Git官方推荐书籍，《Pro Git》值得Git初学者和爱好者认真阅读一遍。  \n\n## 网站\n\n1.https://learngitbranching.js.org  \n\n链接是一个git学习网站，我们可以直接在上面练习git命令。  \n\n## 博客\n\n推荐本公号前面的几篇教程:  \n\n---\n1.[Git概述](https://mp.weixin.qq.com/s/3RheAJ9LYKK5BnVr331h5A)  \n2.[Git基本操作](https://mp.weixin.qq.com/s/S1T4wy3srmLvXgIjvpVEwg)  \n3.[Git中的各种后悔药](https://mp.weixin.qq.com/s/WiLnRQfDVITHMYzGl9pAzQ)  \n4.[Git分支管理](https://mp.weixin.qq.com/s/9OZY7x9DSyRO7T56TyDJ8Q)  \n5.[Git关联远程仓库](https://mp.weixin.qq.com/s/x5bRe4QBMoVFKv5jNl9iRw)  \n6.[Git工作区储藏兼谈分支管理中的一个小问题](https://mp.weixin.qq.com/s/S5rrBQoWwof7n3ZRTrZGWQ)  \n7.[Git标签管理](https://mp.weixin.qq.com/s/Jwr4fjCw7MBUD-CalVXhZQ)  \n\n---  \n\n更多JavaEE和Git资料请关注公众号：   \n\n![公众号二维码](https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg)   ', '<p>关于Git的用法我们已经写七篇文章，介绍了Git的不少用法，这些足以应付工作中90%的需求了，剩下的10%就需要小伙伴们在工作中自己慢慢总结了，我这里再给小伙伴们推荐一点Git学习资料，为我们的Git系列画上一个句号。</p>\n<p><img src=\"http://localhost:80/blogimg/20171224/9f628a1d-2acd-412f-b9a6-b52acf779138_Image012.png\" alt=\"Image 012.png\" /></p>\n<h2>书</h2>\n<p>推荐两本个人觉得很不错的书：</p>\n<p>1.《GitHub入门与实践》<br />\n2.《Pro Git》</p>\n<p>《GitHub入门与实践》秉承了日系技术书刊一贯的“手把手教学”风格，作者用亲切的语言，简明扼要的介绍，配以生动详实的示例一步步讲解GitHub和Git的使用方法。《Pro Git》作为Git官方推荐书籍，《Pro Git》值得Git初学者和爱好者认真阅读一遍。</p>\n<h2>网站</h2>\n<p>1.https://learngitbranching.js.org</p>\n<p>链接是一个git学习网站，我们可以直接在上面练习git命令。</p>\n<h2>博客</h2>\n<p>推荐本公号前面的几篇教程:</p>\n<hr />\n<p>1.<a href=\"https://mp.weixin.qq.com/s/3RheAJ9LYKK5BnVr331h5A\" target=\"_blank\">Git概述</a><br />\n2.<a href=\"https://mp.weixin.qq.com/s/S1T4wy3srmLvXgIjvpVEwg\" target=\"_blank\">Git基本操作</a><br />\n3.<a href=\"https://mp.weixin.qq.com/s/WiLnRQfDVITHMYzGl9pAzQ\" target=\"_blank\">Git中的各种后悔药</a><br />\n4.<a href=\"https://mp.weixin.qq.com/s/9OZY7x9DSyRO7T56TyDJ8Q\" target=\"_blank\">Git分支管理</a><br />\n5.<a href=\"https://mp.weixin.qq.com/s/x5bRe4QBMoVFKv5jNl9iRw\" target=\"_blank\">Git关联远程仓库</a><br />\n6.<a href=\"https://mp.weixin.qq.com/s/S5rrBQoWwof7n3ZRTrZGWQ\" target=\"_blank\">Git工作区储藏兼谈分支管理中的一个小问题</a><br />\n7.<a href=\"https://mp.weixin.qq.com/s/Jwr4fjCw7MBUD-CalVXhZQ\" target=\"_blank\">Git标签管理</a></p>\n<hr />\n<p>更多JavaEE和Git资料请关注公众号：</p>\n<p><img src=\"https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg\" alt=\"公众号二维码\" /></p>\n', '关于Git的用法我们已经写七篇文章，介绍了Git的不少用法，这些足以应付工作中90%的需求了，剩下的', 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/ba5cc7eed880cdba69b4571e7d63b821.jpg', '2019-09-04 11:25:28', 0, 0, 70, 0);
INSERT INTO `article` VALUES (7, 'linux祈求了', 1, 4, '* 林纳斯', '<h2 id=\\\"\\\">林纳斯</h2>', 'linux格格不入', 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/2021-09-13/e86ce527-27e5-48ef-8091-3fa96f1c43ac_1595765952698.jpg', '2021-09-10 15:17:43', 1, 1, 233, 0);
INSERT INTO `article` VALUES (19, 'docker入门', 3, 5, '# docker\n\n## docker 命令\n\n```markdown\n# 查看镜像|搜索|删除\n检查版本：docker --version             \n\n检查镜像是否生效:docker info                    \n\n查看镜像：docker images\n\n搜索镜像：docker search mysql:5.7.0 (5.7.0：搜索指定的版本)\n\n列出当前运行的容器：docker ps\n\n删除：docker rmi 容器id/mysql:版本号       \n\n强制删除：docker rmi 容器id -f   简写rm也可以\n\nctrl c 结束\n```\n\n### 一般步骤\n\n```\ndocker pull nginx\ndocker images\ndocker run -d -p 80:80 --name xx nginx\ndocker ps\n{\ndocker ps -a 历史运行\ndocker rm 容器id 可删除历史中的容器\n}\ndocker ps\ndocker exec -it 容器id /bin/bash 进入容器进行交互\ncd /usr/share/nginx/html/\nls\n(xxxx index.html)\necho \"i love java\" > index.html\ncat index.html       --i love java\ndocker commit 容器id lovenginx:1.11  上传自己修改的镜像\ndocker images\ndocker stop 容器id\ndocker ps\ndocker rm $(docker ps -qa)     删除所有运行\ndocker run -d -p 80:80 容器id   运行自己的镜像，须通过id\ndocker ps    \n```\n\n**ctrl insert复制**\n\n**shift insert 粘贴**\n\n---\n\n## 容器\n\n一个镜像是一个应用环境\n\n### 外部指令\n\n```markdown\n# 运行容器\n\n启动应用：docker run  mysql\n\n-d 启动守护式容器(在后台启动容器，不占用窗口)\n--name 起别名\n-p 映射端口：原始端口号    指定端口号启动\n-P 随机分配端口\n\n例:不占用窗口并映射访问路径：docker run -d -p 80:80 mysql\n\n自定义名称：docker run -d -p 80:80 --name mynginx nginx\n# 查看运行容器\n查看运行容器：docker ps\n\n显示所有容器：docker ps -a\n-a 显示正在运行和历史运行\n-q 静默模式，只显示容器编号\n一起用：docker ps -qa \n\n# 停止|关闭\n开启容器：docker start 容器名字或者id\n重启容器：docker restart 容器名字或者id\n结束容器：docker stop 对应的id\n立即停止容器：docker kill id\n\n# 删除容器\n删除容器：docker rm id\n强制删除：docker rm id -f\n删除所有：docker rm -f $(docker ps -qa)\n```\n\n### 内部指令\n\n```markdown\n# 查看容器内进程\n查看容器内的进程：docker top 容器id或容器name\n\n# 查看容器内部细节 \n查看内部细节：docker inspect 容器id\n\n# 查看容器的运行日志\n查看日志：docker logs[OPTIONS] 容器id或容器名 \n-t     加入时间戳\n-f     跟随最新的日志打印\n--tail 数字 显示最后多少条\n\n例：docker logs -t -f e6a\nctrl c 结束\n```\n\n### 进阶命令(容器内数据交互)\n\nlinux/windows --》 docker(引擎) --》mynginx(容器)\n\n```markdown\nrequires at least xx arguments 至少需要的参数\n# 进入容器内部\n\ndocker exec 容器id \n-i 以交互模式运行容器，通常与 -t一起使用\n-t 分配一个伪终端 shell窗口 /bin/bash\ndocker exec -it  容器id /bin/bash\nls:列出目录文件\n# 查看修改容器内软件配置\n查看主页：cat /usr/share/nginx/html/index.html\n\n更改主页内容：echo \"i love docker\" >  /usr/share/nginx/html/index.html\n\n也可以用vim修改\n# 容器内安装安装软件\n安装apt-get update\n\n终端：apt-get install vim      Ubuntu窗口，用来修改index\n\nvim /usr/share/nginx/html/index.html\n\n编辑好shift zz 保存退出\n\n# 退出容器\nexit\n\n# 将容器打包为新的镜像\ndocker commit -a=\"作者\" -m=\"描述信息\" 容器ID 目标镜像名称：TAG\n\n# 拷贝\ndocker cp id:容器内资源路径 宿主机目录路径\n将容器资源拷贝到宿主机\n```\n\n\n\n### 交互步骤\n\n```\ndocker exec -it id /bin/bash\ncd /usr/share/nginx/html/\nls\npwd     查看当前位置\nexit\nls 检查当前已有文件\ndocker cp id:位置(/usr/share/nginx/html) .\nls\n\n```\n\npwd 是 Print Working Directory 的缩写，其功能是显示当前所在工作目录的全路径\n\n## docker的镜像原理\n\n>  镜像是一种轻量级的，可执行的独立软件包，用来打包软件运行环境和基于运行环境开发的软件，它包含运行某个软件所需的所有内容，包括代码、运行时所需的库、环境变量和配置文件。\n\n为什么一个镜像那么大\n\n**联合文件系统**，镜像被**分层**管理，体现是我们镜像多了之后，很多层不用重复下载\n\n\n\n\n\n\n\n---', '<h1 id=\"docker\">docker</h1>\n<h2 id=\"docker-1\">docker 命令</h2>\n<pre><code class=\"markdown language-markdown\"># 查看镜像|搜索|删除\n检查版本：docker --version             \n\n检查镜像是否生效:docker info                    \n\n查看镜像：docker images\n\n搜索镜像：docker search mysql:5.7.0 (5.7.0：搜索指定的版本)\n\n列出当前运行的容器：docker ps\n\n删除：docker rmi 容器id/mysql:版本号       \n\n强制删除：docker rmi 容器id -f   简写rm也可以\n\nctrl c 结束\n</code></pre>\n<h3 id=\"\">一般步骤</h3>\n<pre><code>docker pull nginx\ndocker images\ndocker run -d -p 80:80 --name xx nginx\ndocker ps\n{\ndocker ps -a 历史运行\ndocker rm 容器id 可删除历史中的容器\n}\ndocker ps\ndocker exec -it 容器id /bin/bash 进入容器进行交互\ncd /usr/share/nginx/html/\nls\n(xxxx index.html)\necho \"i love java\" &gt; index.html\ncat index.html       --i love java\ndocker commit 容器id lovenginx:1.11  上传自己修改的镜像\ndocker images\ndocker stop 容器id\ndocker ps\ndocker rm $(docker ps -qa)     删除所有运行\ndocker run -d -p 80:80 容器id   运行自己的镜像，须通过id\ndocker ps    \n</code></pre>\n<p><strong>ctrl insert复制</strong></p>\n<p><strong>shift insert 粘贴</strong></p>\n<hr />\n<h2 id=\"-1\">容器</h2>\n<p>一个镜像是一个应用环境</p>\n<h3 id=\"-2\">外部指令</h3>\n<pre><code class=\"markdown language-markdown\"># 运行容器\n\n启动应用：docker run  mysql\n\n-d 启动守护式容器(在后台启动容器，不占用窗口)\n--name 起别名\n-p 映射端口：原始端口号    指定端口号启动\n-P 随机分配端口\n\n例:不占用窗口并映射访问路径：docker run -d -p 80:80 mysql\n\n自定义名称：docker run -d -p 80:80 --name mynginx nginx\n# 查看运行容器\n查看运行容器：docker ps\n\n显示所有容器：docker ps -a\n-a 显示正在运行和历史运行\n-q 静默模式，只显示容器编号\n一起用：docker ps -qa \n\n# 停止|关闭\n开启容器：docker start 容器名字或者id\n重启容器：docker restart 容器名字或者id\n结束容器：docker stop 对应的id\n立即停止容器：docker kill id\n\n# 删除容器\n删除容器：docker rm id\n强制删除：docker rm id -f\n删除所有：docker rm -f $(docker ps -qa)\n</code></pre>\n<h3 id=\"-3\">内部指令</h3>\n<pre><code class=\"markdown language-markdown\"># 查看容器内进程\n查看容器内的进程：docker top 容器id或容器name\n\n# 查看容器内部细节 \n查看内部细节：docker inspect 容器id\n\n# 查看容器的运行日志\n查看日志：docker logs[OPTIONS] 容器id或容器名 \n-t     加入时间戳\n-f     跟随最新的日志打印\n--tail 数字 显示最后多少条\n\n例：docker logs -t -f e6a\nctrl c 结束\n</code></pre>\n<h3 id=\"-4\">进阶命令(容器内数据交互)</h3>\n<p>linux/windows --》 docker(引擎) --》mynginx(容器)</p>\n<pre><code class=\"markdown language-markdown\">requires at least xx arguments 至少需要的参数\n# 进入容器内部\n\ndocker exec 容器id \n-i 以交互模式运行容器，通常与 -t一起使用\n-t 分配一个伪终端 shell窗口 /bin/bash\ndocker exec -it  容器id /bin/bash\nls:列出目录文件\n# 查看修改容器内软件配置\n查看主页：cat /usr/share/nginx/html/index.html\n\n更改主页内容：echo \"i love docker\" &gt;  /usr/share/nginx/html/index.html\n\n也可以用vim修改\n# 容器内安装安装软件\n安装apt-get update\n\n终端：apt-get install vim      Ubuntu窗口，用来修改index\n\nvim /usr/share/nginx/html/index.html\n\n编辑好shift zz 保存退出\n\n# 退出容器\nexit\n\n# 将容器打包为新的镜像\ndocker commit -a=\"作者\" -m=\"描述信息\" 容器ID 目标镜像名称：TAG\n\n# 拷贝\ndocker cp id:容器内资源路径 宿主机目录路径\n将容器资源拷贝到宿主机\n</code></pre>\n<h3 id=\"-5\">交互步骤</h3>\n<pre><code>docker exec -it id /bin/bash\ncd /usr/share/nginx/html/\nls\npwd     查看当前位置\nexit\nls 检查当前已有文件\ndocker cp id:位置(/usr/share/nginx/html) .\nls\n</code></pre>\n<p>pwd 是 Print Working Directory 的缩写，其功能是显示当前所在工作目录的全路径</p>\n<h2 id=\"docker-2\">docker的镜像原理</h2>\n<blockquote>\n  <p>镜像是一种轻量级的，可执行的独立软件包，用来打包软件运行环境和基于运行环境开发的软件，它包含运行某个软件所需的所有内容，包括代码、运行时所需的库、环境变量和配置文件。</p>\n</blockquote>\n<p>为什么一个镜像那么大</p>\n<p><strong>联合文件系统</strong>，镜像被<strong>分层</strong>管理，体现是我们镜像多了之后，很多层不用重复下载</p>\n<hr />', 'docker基础指令和容器认识', 'http://gulimall-wqs.oss-cn-beijing.aliyuncs.com/9c8e6b18509311ad8d74cfdb4da52c60_1440w.png', '2021-09-22 13:32:38', 1, 1, 1000, 0);

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) NULL DEFAULT NULL COMMENT '博客id',
  `cid` int(11) NULL DEFAULT NULL COMMENT '分类id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '博客所在的分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_category
-- ----------------------------
INSERT INTO `article_category` VALUES (1, 1, 3);
INSERT INTO `article_category` VALUES (2, 2, 2);
INSERT INTO `article_category` VALUES (3, 3, 1);
INSERT INTO `article_category` VALUES (5, 7, 4);
INSERT INTO `article_category` VALUES (17, 19, 5);

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) NULL DEFAULT NULL COMMENT '博客id',
  `tid` int(11) NULL DEFAULT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '博客和标签的对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_tags
-- ----------------------------
INSERT INTO `article_tags` VALUES (1, 1, 1);
INSERT INTO `article_tags` VALUES (2, 2, 2);
INSERT INTO `article_tags` VALUES (3, 3, 3);
INSERT INTO `article_tags` VALUES (5, 7, 1);
INSERT INTO `article_tags` VALUES (17, 19, 3);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `cateName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `date` datetime NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Vue', '2021-09-03 11:16:59');
INSERT INTO `category` VALUES (2, 'JavaEE', '2021-08-01 11:17:06');
INSERT INTO `category` VALUES (3, 'Git', '2021-07-01 11:17:10');
INSERT INTO `category` VALUES (4, 'Linux', '2021-05-01 11:17:15');
INSERT INTO `category` VALUES (5, 'docker', '2021-09-03 11:16:59');
INSERT INTO `category` VALUES (6, 'python', '2021-09-05 10:23:09');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评论内容',
  `createTime` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `fromUserAvatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论者头像',
  `fromUserId` int(11) NULL DEFAULT NULL COMMENT '评论用户id',
  `fromUserName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论者名字',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `parentId` int(11) NULL DEFAULT NULL,
  `postId` int(11) NULL DEFAULT NULL COMMENT '文章id',
  `toUserAvatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '被评论者头像',
  `toUserId` int(11) NULL DEFAULT NULL COMMENT '被评论者id',
  `toUserName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '被评论者姓名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('最后一句是不是有问题', '2021-09-25 14:17:26', 'https://s1.ax1x.com/2020/05/14/YDhU81.jpg', 1, '崔敏', 1, NULL, 7, 'https://s1.ax1x.com/2020/05/14/YDhBDO.jpg', NULL, 'ciwei');
INSERT INTO `comment` VALUES ('我同意', '2021-09-25 14:19:31', '	https://gitee.com/thciweicloud/tmp/raw/master/ciwei.png', 2, '司马懿', 2, 1, 7, '22', 1, '崔敏');
INSERT INTO `comment` VALUES ('林纳斯gg', '2021-09-25 14:22:06', 'https://s1.ax1x.com/2020/05/14/YDhU81.jpg', NULL, '诸葛亮', 3, NULL, 7, 'https://s1.ax1x.com/2020/05/14/YDhBDO.jpg', NULL, 'ciwei');
INSERT INTO `comment` VALUES ('linux and unix', '2021-09-25 22:59:39', '', 5, '尤大', 5, NULL, 7, '', NULL, 'ciwei');
INSERT INTO `comment` VALUES ('顶<img data-v-7c9572d1=\"\" width=\"20\" height=\"20\" src=\"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAzNiAzNiI+PHBhdGggZmlsbD0iI0ZGREM1RCIgZD0iTTUgMjFjMCAyLjIwOS0xLjExOSA0LTIuNSA0UzAgMjMuMjA5IDAgMjFzMS4xMTktNCAyLjUtNFM1IDE4Ljc5MSA1IDIxeiIvPjxwYXRoIGZpbGw9IiNGRkRDNUQiIGQ9Ik0zIDE4LjU2MkMzIDEwLjAzNyA4LjM3MyAzLjEyNSAxNSAzLjEyNXMxMiA2LjkxMiAxMiAxNS40MzhDMjcgMjcuMDg4IDIxLjYyNyAzNCAxNSAzNFMzIDI3LjA4OCAzIDE4LjU2MnoiLz48cGF0aCBmaWxsPSIjREQyRTQ0IiBkPSJNMjAgMGMtLjI0OSAwLS40NzguMDA3LS43MTMuMDEyQzE5LjE5LjAxIDE5LjA5NyAwIDE5IDAgOSAwIDIgNC41ODIgMiA5czYuMzczIDQgMTMgNGM0LjQ0MiAwIDcuNjQ4IDAgOS45NjYtLjA4NkwyNSAxM2w2IDE1aDJzLjM0My0zLjA1NSAxLTdjMS02IC41MzMtMjEtMTQtMjF6Ii8+PHBhdGggZmlsbD0iI0ZGREM1RCIgZD0iTTMwIDIxYzAgMi4yMDktMS4xMTkgNC0yLjUgNFMyNSAyMy4yMDkgMjUgMjFzMS4xMTktNCAyLjUtNCAyLjUgMS43OTEgMi41IDR6Ii8+PHBhdGggZmlsbD0iIzY2MjExMyIgZD0iTTEwIDIxYy0uNTUyIDAtMS0uNDQ3LTEtMXYtMmMwLS41NTIuNDQ4LTEgMS0xczEgLjQ0OCAxIDF2MmMwIC41NTMtLjQ0OCAxLTEgMXptMTAgMGMtLjU1MyAwLTEtLjQ0Ny0xLTF2LTJjMC0uNTUyLjQ0Ny0xIDEtMXMxIC40NDggMSAxdjJjMCAuNTUzLS40NDcgMS0xIDF6Ii8+PHBhdGggZmlsbD0iI0I3NzU1RSIgZD0iTTE2IDI2aC0yYy0uNTUyIDAtMS0uNDQ3LTEtMXMuNDQ4LTEgMS0xaDJjLjU1MiAwIDEgLjQ0NyAxIDFzLS40NDggMS0xIDF6Ii8+PHBhdGggZmlsbD0iI0U2RTdFOCIgZD0iTTI3IDI1YzAtMi0yLjI5My0uNzA3LTMgMC0xIDEtMyAzLTUgMi0yLjgyOC0xLjQxNC00LTEtNC0xcy0xLjE3MS0uNDE0LTQgMWMtMiAxLTQtMS01LTItLjcwNy0uNzA3LTMtMi0zIDBzMSAyIDEgMmMtMSAyIDEgMyAxIDMgMCAzIDMgMyAzIDMgMCAzIDQgMiA0IDIgMSAxIDMgMSAzIDFzMiAwIDMtMWMwIDAgNCAxIDQtMiAwIDAgMyAwIDMtMyAwIDAgMi0xIDEtMyAwIDAgMSAwIDEtMnoiLz48cGF0aCBmaWxsPSIjRkZEQzVEIiBkPSJNMTUgMjhjNyAwIDQgMiAwIDJzLTctMiAwLTJ6Ii8+PGVsbGlwc2UgZmlsbD0iI0QxRDNENCIgY3g9IjMiIGN5PSIxNCIgcng9IjIiIHJ5PSI0Ii8+PGVsbGlwc2UgZmlsbD0iI0QxRDNENCIgY3g9IjI2IiBjeT0iMTQiIHJ4PSIyIiByeT0iNCIvPjxjaXJjbGUgZmlsbD0iI0YxRjJGMiIgY3g9IjMyIiBjeT0iMjkiIHI9IjQiLz48cGF0aCBmaWxsPSIjRjFGMkYyIiBkPSJNMjkgMTJjMCAxLjEwNC0uODk2IDItMiAySDJjLTEuMTA0IDAtMi0uODk2LTItMnYtMWMwLTEuMTA0Ljg5Ni0yIDItMmgyNWMxLjEwNCAwIDIgLjg5NiAyIDJ2MXoiLz48L3N2Zz4=\" alt=\"\" class=\"emoji-icon\" style=\"vertical-align: text-top;\">', '2021-09-25 23:27:16', '', 6, '尤小又', 6, 5, 7, '', 5, '尤大');
INSERT INTO `comment` VALUES ('可以呀兄弟', '2021-09-25 23:32:37', '', NULL, '大和', 7, 5, 7, '', 5, '尤大');
INSERT INTO `comment` VALUES ('成功了', '2021-09-25 23:34:15', '', NULL, '尤大', 8, NULL, 7, '', NULL, 'ciwei');
INSERT INTO `comment` VALUES ('恭喜', '2021-09-25 23:35:59', '', NULL, '尤小又', 10, NULL, 7, '', NULL, '尤大');
INSERT INTO `comment` VALUES ('ttk', '2021-10-22 13:15:55', 'https://portrait.gitee.com/uploads/avatars/user/2579/7739504_thciweicloud_1621301627.png', 7739504, 'thciweicloud', 25, NULL, 3, '', NULL, '');

-- ----------------------------
-- Table structure for info
-- ----------------------------
DROP TABLE IF EXISTS `info`;
CREATE TABLE `info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `isView` tinyint(4) NULL DEFAULT 0 COMMENT '是否读消息【0-未读1-已读】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友链邮箱和信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of info
-- ----------------------------
INSERT INTO `info` VALUES (1, '1462108765@qq.com', '站点:被追忆的风，url:www.feng.com;介绍:后端知识分享站点', 1);
INSERT INTO `info` VALUES (2, '33', '33', 1);
INSERT INTO `info` VALUES (3, '44', '444', 0);
INSERT INTO `info` VALUES (4, '111111111111', '111111111111111', 1);
INSERT INTO `info` VALUES (5, 'asd', 'asd', 0);

-- ----------------------------
-- Table structure for mail_send_log
-- ----------------------------
DROP TABLE IF EXISTS `mail_send_log`;
CREATE TABLE `mail_send_log`  (
  `msgId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `websiteId` int(11) NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0发送中，1发送成功，2发送失败',
  `routeKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '绑定key',
  `exchange` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交换机',
  `count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '重试次数',
  `tryTime` date NULL DEFAULT NULL COMMENT '第一次重试时间',
  `createTime` date NULL DEFAULT NULL,
  `updateTime` date NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '邮件发送保证消息可靠性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mail_send_log
-- ----------------------------
INSERT INTO `mail_send_log` VALUES ('662e6e5e-61ec-49c8-b3b1-d0e3cdb11a92', 111, 2, 'thciwei.mail.routing.key', 'thciwei.mail.exchange', 0, '2021-09-01', '2021-09-22', '2021-09-19');
INSERT INTO `mail_send_log` VALUES ('662e6e5e-61ec-49c8-b3b1-d0e3cdb11a91', 20, 2, 'thciwei.mail.routing.key', 'thciwei.mail.exchange', 0, '2021-09-17', '2021-09-17', '2021-09-19');
INSERT INTO `mail_send_log` VALUES ('662e6e5e-61ec-49c8-b3b1-d0e3cdb11a98', 23, 2, 'thciwei.mail.routing.key', 'thciwei.mail.exchange', 0, '2021-09-18', '2021-09-18', '2021-09-19');
INSERT INTO `mail_send_log` VALUES ('c12681a4-dfdd-4889-957e-15f315a7fcb9', 24, 1, 'thciwei.mail.routing.key', 'thciwei.mail.exchange', 0, '2021-09-18', '2021-09-18', '2021-09-19');
INSERT INTO `mail_send_log` VALUES ('cdbed6de-3e1c-4a52-9008-27bd6916a3a9', 25, 2, 'thciwei.mail.routing.key', 'thciwei.mail.exchange', 3, '2021-09-18', '2021-09-18', '2021-09-19');
INSERT INTO `mail_send_log` VALUES ('1494272e-d483-4f60-8868-8e76b604b9e6', 26, 2, 'thciwei.mail.routing.key', 'thciwei.mail.exchange', 3, '2021-09-19', '2021-09-19', '2021-09-19');

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `tagName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  `date` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (1, 'Ajax', '2021-09-03 11:18:18');
INSERT INTO `tags` VALUES (2, 'git', '2021-09-04 11:18:22');
INSERT INTO `tags` VALUES (3, 'spring', '2021-09-05 11:18:24');

-- ----------------------------
-- Table structure for todoList
-- ----------------------------
DROP TABLE IF EXISTS `todoList`;
CREATE TABLE `todoList`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'todo事件',
  `done` tinyint(4) NULL DEFAULT 0 COMMENT '是否完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '事件清单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of todoList
-- ----------------------------
INSERT INTO `todoList` VALUES (1, '完成爬虫模块', 0);
INSERT INTO `todoList` VALUES (2, '整合oss', 0);
INSERT INTO `todoList` VALUES (3, '完成search服务', 0);
INSERT INTO `todoList` VALUES (4, '接入zipkin', 0);

-- ----------------------------
-- Table structure for user_auth
-- ----------------------------
DROP TABLE IF EXISTS `user_auth`;
CREATE TABLE `user_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `header` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` tinyint(4) NULL DEFAULT NULL COMMENT '性别【1-男0-女】',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `source_type` tinyint(4) NULL DEFAULT NULL COMMENT '用户来源',
  `state` tinyint(4) NOT NULL DEFAULT 0 COMMENT '启用状态【0-存在1-不存在】',
  `create_time` date NULL DEFAULT NULL COMMENT '注册时间',
  `social_uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '社交账号ID',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '社交账号Token',
  `expires_in` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '社交账号Token过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_auth
-- ----------------------------
INSERT INTO `user_auth` VALUES (11, 'thciwei', '$2a$10$Q2FOT739r3wJxFgCPYVF1.k8IT1mw0mBIc/hDAOXoAJwygstr/7FO', NULL, '15032289043', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `user_auth` VALUES (13, NULL, NULL, '浸水止渴', NULL, 'https://tvax3.sinaimg.cn/crop.0.0.996.996.50/006yRl4Gly8gay6lrsil4j30ro0rodh4.jpg?KID=imgbed,tva&Expires=1633687966&ssig=JwSpZ7ST9O', 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, '6011904814', '2.00gE2rYGvID1iBff978030c1Np74DE', '157679999');
INSERT INTO `user_auth` VALUES (14, NULL, NULL, '\"thciweicloud\"', NULL, '\"https://portrait.gitee.com/uploads/avatars/user/2579/7739504_thciweicloud_1621301627.png\"', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '7739504', 'ae8e3833fefb9f4c4b8164fa76d2ee17', '86400');
INSERT INTO `user_auth` VALUES (15, NULL, NULL, '\"thciwei\"', NULL, '\"https://avatars.githubusercontent.com/u/65482477?v=4\"', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '65482477', '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', '0');

-- ----------------------------
-- Table structure for websiteInfo
-- ----------------------------
DROP TABLE IF EXISTS `websiteInfo`;
CREATE TABLE `websiteInfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友链名称',
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友链path',
  `descp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '站点描述',
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友站邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友链接' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of websiteInfo
-- ----------------------------
INSERT INTO `websiteInfo` VALUES (1, '风雪之隅 \r\n', 'http://www.laruence.com/\n', '  PHP核心开发人员', '1472106316@qq.com');
INSERT INTO `websiteInfo` VALUES (2, '蘑菇博客', 'http://demoweb.moguit.cn/', '陌溪大佬开发', '2422106316@qq.com');
INSERT INTO `websiteInfo` VALUES (3, '闪烁之狐', 'https://github.com/blinkfox', 'hexo知名主题开发者', '3442106316@qq.com');
INSERT INTO `websiteInfo` VALUES (4, '浸水止渴', 'http://thciweicloud.gitee.io/thciwei/', '我的Learning Notes', '1462106316@qq.com');
INSERT INTO `websiteInfo` VALUES (20, '江南一点雨', 'http://www.javaboy.org/', '松哥java专家', '3694478989@qq.com');
INSERT INTO `websiteInfo` VALUES (23, 'kang', 'https://blog.kangkang.org/', '人称康神', '7734479083@qq.com');
INSERT INTO `websiteInfo` VALUES (24, '心灵港', 'https://qinjiangbo.com/thoughts-in-software-engineering.html', '技术分享', '2471449383@qq.com');
INSERT INTO `websiteInfo` VALUES (25, 'Wing的小站', 'https://www.wingmei.cn/', '个人小站', '2367478383@qq.com');
INSERT INTO `websiteInfo` VALUES (26, '帅地', 'https://www.iamshuaidi.com/', '知名面试博主', '7364478383@qq.com');

SET FOREIGN_KEY_CHECKS = 1;
