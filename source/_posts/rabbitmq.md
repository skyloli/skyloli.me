---
title: RabbitMQ 入门教程
date: 2019-5-1 22:53:25
categories:
  - 烫烫烫烫
---

- [什么是MQ为什么使用MQ](#link1 )
- [为什么选择RabbitMQ](#link2 )
- [怎么安装RabbitMQ](#link3 )
- [RabbitMQ怎么使用](#link4 )
- [RabbitMQ概念](#link5 )
- [RabbitMQ消息事物](#link6 )
- [RabbitMQ消息确认](#link7 )
- [RabbitMQ配置](#link8 )
- [RabbitMQ集群](#link9 )
- [帮助](#link10 )

# 当前版本

> * CentOS 7
> * Erlang 21.x
> * RabbitMQ 3.7.14

<!--more-->

<div id="link1"></div>

## 什么是MQ,为什么要使用MQ
  
哈，MQ你都不知道，你还来这里，茨~ 快去百度啦
  
为什么使用MQ
  
话说，你都不知道为什么使用MQ，那你还来这里干嘛？
  
---
  
<div id="link2"></div>
  
## 为什么选择RabbitMQ
  
  
现在的市面上有很多MQ可以选择，比如ActiveMQ、ZeroMQ、Appche Qpid，那问题来了为什么要选择RabbitMQ？
  
> 1. 除了Qpid，RabbitMQ是唯一一个实现了AMQP标准的消息服务器；
> 2. 可靠性，RabbitMQ的持久化支持，保证了消息的稳定性；
> 3. 高并发，RabbitMQ使用了Erlang开发语言，Erlang是为电话交换机开> 发4. 的语言，天生自带高并发光环，和高可用特性；
> 5. 集群部署简单，正是应为Erlang使得RabbitMQ集群部署变的超级简单；
> 6. 社区活跃度高，根据网上资料来看，RabbitMQ也是首选；
  
---
  
### MQ 对比
  
我们先来看一些数据
  
阿里官网对比
  
| 功能 | 消息队列 RocketMQ | Apache RocketMQ（开源） | 消息队列 Kafka | Apache Kafka（开源） | RabbitMQ（开源）|
| - | - | - | - | - | - |
| 安全防护 | 支持 | 不支持 | 支持 | 不支持 | 支持
| 主子账号支持 | 支持 | 不支持 | 支持 | 不支持 | 不支持
| 可靠性 |  同步刷盘 - 同步双写 - 超3份数据副本 - 99.99999999%	| - 同步刷盘 - 异步刷盘 - | 同步刷盘 - 同步双写 - 超3份数据副本 - 99.99999999% | 异步刷盘，丢数据概率高 | 同步刷盘 |
| 可用性 | - 非常好，99.95% - Always Writable | 好 |    - 非常好，99.95% - Always Writable	| 好 | 好 |
| 横向扩展能力 |	- 支持平滑扩展 - 支持百万级 QPS	| 支持	| - 支持平滑扩展 - 支持百万级 QPS	| 支持	| - 集群扩容依赖前端 - LVS 负载均衡调度
| Low Latency |	支持 | 不支持 | 支持 |	不支持 |	不支持
| 消费模型	| Push / Pull	| Push / Pull |	Push / Pull |	Pull |	Push / Pull |
| 定时消息	| 支持（可精确到秒级） |	支持（只支持18个固定 Level） | 	暂不支持 |	不支持 |	支持 |
| 事务消息	| 支持	| 不支持 | 不支持 |	不支持 |	不支持 |
| 顺序消息	| 支持	| 支持	| 暂不支持 |	支持 |	不支持 |
| 全链路消息轨迹 |	支持 |	不支持 |	暂不支持 |	不支持 |	不支持 |
| 消息堆积能力 |	百亿级别 不影响性能 |	百亿级别 影响性能	| 百亿级别 不影响性能	| 影响性能 |	影响性能 |
| 消息堆积查询 |	支持 |	支持 |	支持 |	不支持 |	不支持 |
| 消息回溯	| 支持 |	支持 |	支持 |	不支持 |	不支持 |
| 消息重试	| 支持 |	支持 |	暂不支持 |	不支持 |	支持 |
| 死信队列	| 支持 |	支持 |	不支持 |	不支持 |	支持 |
| 性能（常规） |	非常好 百万级 QPS |	非常好 十万级 QPS |	非常好 百万级 QPS |	非常好 百万级 QPS |	一般 万级 QPS |
| 性能（万级 Topic 场景） |	非常好 百万级 QPS |	非常好 十万级 QPS |	非常好 百万级 QPS |	低 |	低 |
| 性能（海量消息堆积场景） |	非常好 百万级 QPS |	非常好 十万级 QPS |	非常好 百万级 QPS |	低 |	低 |
  
---
  
| xxxxxxxxxxxxxxxxxx | ActiveMQ | RabbitMQ | RocketMq | ZeroMQ | Kafka |
| ------------------ | -------- | -------- | -------- | ------ | ----- |
| 关注度	| 高 |	高 |	中 |	中 |	高 |
| 成熟度 | 成熟 |	成熟 |	比较成熟 |	不成熟 |	成熟 |
| 所属社区/公司 | Apache |	Mozilla Public License | Alibaba Apache |
| 社区活跃度	| 高	 | 高 |	中 |	低 |	高 |
| 文档 |	多 | 	多 |	中 |	中 |	多 |
| 特点 |	功能齐全，被大量开源项目使用 |	由于Erlang 语言的并发能力，性能很好 | 各个环节分布式扩展设计，主从 HA；支持上万个队列；多种消费模式；性能很好 |	低延时，高性能，最高 43万条消息每秒 |	 
| 授权方式 |	开源 |	开源 |	开源 |	开源 |	开源 |
| 开发语言 |	Java |	Erlang |	Java |	C |	 
| 支持的协议 |	OpenWire、STOMP、REST、XMPP、AMQP |	AMQP 自己定义的一套(社区提供JMS--不成熟)	| TCP、UDP	 
| 客户端支持语言 | Java、C、C++、Python、PHP、Perl、.net 等 | 	Java、C、C++、Python、PHP、Perl、.net 等 | Java  C++（不成熟） | python java、 php、.net 等 | 
| 持久化 |内存、文件、数据库 |	内存、文件 |	磁盘文件 |	在消息发送端保存 |	 
| 事务	| 支持 |	不支持 |	支持 |	不支持 |	 
| 集群	| 支持 | 支持 |	支持 |	不支持 |	 
| 负载均衡 |	支持 |	支持 |	支持 |	不支持 |
| 管理界面 |	一般 |好 | 无社区有 web console 实现 | 无 | 
| 部署方式 |	独立、嵌入 |	独立 |	独立 |	独立 |	 
| 顺序 |	无法保证严格的顺序 |  | 保证严格的消费顺序 |	 	 
| 优点 | 成熟的产品，已经在很多公司得到应用（非大规模场景）。有较多的文档。各种协议支持较好，有多重语言的成熟的客户端； | 由于erlang语言的特性，mq 性能较好；管理界面较丰富，在互联网公司也有较大规模的应用；支持amqp系诶，有多中语言且支持 amqp 的客户端可用 | 模型简单，接口易用（JMS   的接口很多场合并不太实用）。在阿里大规模应用。目前支付宝中的余额宝等新兴产品均使用rocketmq。集群规模大概在50 台左右，单日处理消息上百亿；性能非常好，可以大量堆积消息在broker   中；支持多种消费，包括集群消费、广播消费等。开发度较活跃，版本更新很快。 |
| 缺点 | 根据其他用户反馈，会出莫名其妙的问题，切会丢失消息。 其重心放到activemq6.0 产品—apollo 上去了，目前社区不活跃，且对 5.x 维护较少;Activemq 不适合用于上千个队列的应用场景 | erlang语言难度较大。集群不支持动态扩展。 | 没有在 mq 核心中去实现JMS 等接口
  
---
  
### 知道了吗？为什么选择RabbitMQ！！！！！！
  
**(小声的说：其实！！！我也没用过MQ，各大厂商都实现了一套，所以我准备选择一个先了解一下)**
  
**为什么选择RabbitMQ呢？**
> * **因为我也是第一次接触MQ，选择的原因嘛，是RabbitMQ时间比较久了，资料比较多，刚入手肯定选择资料比较多的最好**
> * **还有Rabbit是兔子的意思嘛，一想到兔子，很可爱啊！！！**
  
---
  
<div id="link3"></div>
  
## 怎么安装RabbitMQ
  
打开[官网](https://www.rabbitmq.com/ )看了吗？
  
Download + Installation
  
哈！！！没看到，你网速太差了吧，那你等一下吧！
  
还是没看到！哦，那你点击一下[我](https://www.rabbitmq.com/#getstarted )吧！
  
啊~~ ~别点了~啊~~~～(￣▽￣～)
  
> 我怀疑你在开车，但是我没有证据
  
---
  
OK，现在到[这里](https://www.rabbitmq.com/download.html )了
  
我的是CentOS7 所以我点击[这个](https://www.rabbitmq.com/install-rpm.html )
  
其他的系统自己研究了~ RabbitMQ 是Erlange开发了，所以要先安装Erlang，版本有要求哦
  
进来后看到[Install Erlang](https://www.rabbitmq.com/install-rpm.html#install-erlang )
  
下面有一个[a package](https://github.com/rabbitmq/erlang-rpm ) 的一个链接，点击跳转到了Github
  
往下面拉，这里我选择最新版本的Erlang 源，Erlang 21.x，当前版本的RabbitMQ3.7.14 也要求Erlang >= 19.3 
  
在往下拉，可以看到指定版本的Erlang 安装源
  
源安装好像有两种 Package Cloud、Bintray Yum Repositories
  
我选择第一种的，但是我没有操作这个
Package Cloud supports a variety of options for RPM package installation: from Yum configuration to shell scripts to Chef and Puppet.
  
See Package Cloud repository installation page for details.
  
也安装好了~嘛 再往下拉就能看到Bintray Yum Repositories，也可以用这个源安装
  
``` conf
# In /etc/yum.repos.d/rabbitmq_erlang.repo
[rabbitmq_erlang]
name=rabbitmq_erlang
baseurl=https://packagecloud.io/rabbitmq/erlang/el/7/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/rabbitmq/erlang/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
  
[rabbitmq_erlang-source]
name=rabbitmq_erlang-source
baseurl=https://packagecloud.io/rabbitmq/erlang/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/rabbitmq/erlang/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
```
  
配置好后就安装了~
  
``` bash
yum install -y erlang
```
  
安装好Erlang后开始安装RabbitMQ了
  
我们回到[这里，快点击我啊~](https://www.rabbitmq.com/install-rpm.html#bintray )
  
这里使用Bintray 安装
  
```text
rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc
```
  
``` conf
# In /etc/yum.repos.d/rabbitmq.repo
[bintray-rabbitmq-server]
name=bintray-rabbitmq-rpm
baseurl=https://dl.bintray.com/rabbitmq/rpm/rabbitmq-server/v3.7.x/el/7/
gpgcheck=0
repo_gpgcheck=0
enabled=1
```
  
写完配置后，安装，没有指定版本号默认安装最新版,我这里的是 **3.7.14**
  
``` bash
yum install -y rabbitmq-server.noarch
```
  
### 启动服务RabbitMQ器
  
  
设置开机启动，默认是不会开机启动，大家自己选择

``` bash
chkconfig rabbitmq-server on
```

启动RabbitMQ，Centos7 已经使用systemctl 替代 service 命令了
  
``` bash
# 启动
systemctl start rabbitmq-server
  
# 重新启动
systemctl restart rabbitmq-server
  
# 停止
systemctl stop rabbitmq-server
  
# 状态
systemctl status rabbitmq-server
```

也可是使用RabbitMQ 提供的命令查看状态，更多关于rabbitmqctl 命令请[点击这里](https://www.rabbitmq.com/rabbitmqctl.8.html )
  
``` bash
rabbitmqctl status
```
  
我选择开启Web 管理插件
  
``` bash
rabbitmq-plugins enable rabbitmq_management
  
rabbitmq-plugins disable rabbitmq_management
  
# 注意：插件的启用和关闭都不会影响当前运行rabbitmq节点。必须重新启动之后才会影响。
  
```

打开 http://localhost:15672/
  
输入guest guest
  
默认的用户guest只能在安装RabbitMQ的机器上登录，在其他机器登录需要新增用户！,当然利用配置文件也可以实现让guest用户在其他机器登陆！！
  
这里我选择新建用户
  
添加用户

``` bash
rabbitmqctl add_user username password
```
  
设置用户标签（administrator），用户标签的用处主要是管理插件使用的，设置administrator 是让这个用户可以访问 Web端管理程序
  
``` bash
rabbitmqctl set_user_tags username administrator
```
  
设置 虚拟主机权限，RabbitMQ 是使用虚拟主机隔离的，每一个虚拟主机都用自己的交换机和队列，每个虚拟主机互相隔离
  
/ 是默认的虚拟主机
  
``` bash
rabbitmqctl set_permissions username -p / ".*" ".*" ".*"
```
  
设置完后就可以远程使用这个用户登录Web 管理端了
  
---
  
### 常用命令
  
#### [User | 用户](https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management )
  
  
``` bash
# 用户列表
rabbitctl list_users
  
# 添加用户
rabbitmqctl add_user username password
  
# 删除用户
rabbitmqctl delete_user username
  
# 修改密码
rabbitmqctl change_password username password
  
# 清除密码
rabbitmqcaltl clear_password username
  
# 设置标签
rabbitmqctl set_user_tags username administrator
  
# 清空标签
rabbitmqctl set_user_tags username
```

#### [Access Control | 访问控制](https://www.rabbitmq.com/rabbitmqctl.8.html#Access_Control )

``` bash
# 虚拟主机列表
rabbitmqctl list_vhosts
  
# 添加虚拟主机
rabbitmqctl add_vhost vhost
  
# 删除虚拟主机
rabbitmqctl delete_vhost vhost
  
# 设置权限用户
rabbitmqctl set_permissions -p vhost username ".*" ".*" ".*"
  
#清空用户权限
rabbitmqctl clear_permissions -p vhost username
  
# 虚拟主机下的用户
rabbitmqctl list_permissions -p vhost
  
# 用户下的虚拟主机
rabbitmqctl list_user_permissions username
```
  
---
  
<div id="link4"></div>
  
## RabbitMQ怎么使用

### 连接服务器

我使用的是Java 客户端 其他语言自己查阅官方文档
  
根据[官方文档](https://www.rabbitmq.com/java-client.html )
  
我们要引入客户端
  
如果使用Maven
  
```conf
<dependency>
  <groupId>com.rabbitmq</groupId>
  <artifactId>amqp-client</artifactId>
  <version>5.7.0</version>
</dependency>
```
  
如果使用Gradle
  
``` conf
dependencies {
  compile 'com.rabbitmq:amqp-client:5.7.0'
}
```
  
我们来到[api文档](https://www.rabbitmq.com/api-guide.html )，看看Java怎么使用RabbitMQ
  
``` java
ConnectionFactory factory = new ConnectionFactory();
// "guest"/"guest" by default, limited to localhost connections
factory.setUsername(userName);
factory.setPassword(password);
factory.setVirtualHost(virtualHost);
factory.setHost(hostName);
factory.setPort(portNumber);
  
Connection conn = factory.newConnection();
```
  
| Property | Default Value |
| -------- | ------------- |
| Username | "guest" |
| Password | "guest" |
| Virtual host | "/" |
| Hostname | "localhost" |
| port | 5672 for regular connections, 5671 for connections that use TLS |

还可以使用URLs方式
  
``` java
ConnectionFactory factory = new ConnectionFactory();
factory.setUri("amqp://userName:password@hostName:portNumber/virtualHost");
Connection conn = factory.newConnection();
```
  
我使用URLs方式，如果你要连接到默认的虚拟主机/，需要将/转义也就是%2F，其他不用
  
这里我直接写测试类里面了
  
``` java
public class Aphage {
  
    private static final String uri = "amqp://%s:%s@%s:%d/%s";
    private static final String HOST = "192.168.92.128";
    private static final int PORT = AMQP.PROTOCOL.PORT;
    private static final String USERNAME= "Aqua";
    private static final String PASSWORD = "Aqua";
    private static final String VHOST = "%2F";
  
  
  
    private static Connection conn = null;
  
    public Connection getConnection() throws Exception{
        ConnectionFactory factory=new ConnectionFactory();
        factory.setUri(String.format(uri,USERNAME,PASSWORD,HOST,PORT,VHOST));
        return factory.newConnection();
    }
  
  
    @Before
    public void start() throws Exception{
        conn = getConnection();
    }
  
    @After
    public void end() throws Exception{
        if(null!=conn)conn.close();
    }
}
```
  
### 声明交换机和队列并绑定
  
声明交换机和队列的时候分为两种情况
  
1. 声明的交换机和队列不存在，就会创建
2. 如果存在，就不会
  
``` java
channel.exchangeDeclare(exchangeName, "direct", true);
String queueName = channel.queueDeclare().getQueue();
channel.queueBind(queueName, exchangeName, routingKey);
```
  
1. 一种持久的，非自动交换的“直接”类型
2. 具有生成名称的非持久，独占，自动删除队列
  
``` java
channel.exchangeDeclare(exchangeName, "direct", true);
channel.queueDeclare(queueName, true, false, false, null);
channel.queueBind(queueName, exchangeName, routingKey);
```
  
1. 一种持久的，非自动交换的“直接”类型
2. 具有已知名称的持久，非独占，非自动删除队列

### 声明交换机

根据上面的代码，我们先来声明一些交换机
  
``` java
    @Test
    public void Test1() throws Exception{
        Channel channel=conn.createChannel();
        //创建交换机
  
        /*
        * 1. 交换机名称
        * 2. 交换机类型
        * 3. 是否永久存在，false 为临时重启消失
        * */
  
        //直接类型
        channel.exchangeDeclare("direct-forever", BuiltinExchangeType.DIRECT,true);
        channel.exchangeDeclare("direct-temporary", BuiltinExchangeType.DIRECT,false);
  
        //广播类型 routing key 忽略无效
        channel.exchangeDeclare("fanout-forever", BuiltinExchangeType.FANOUT,true);
        channel.exchangeDeclare("fanout-temporary", BuiltinExchangeType.FANOUT,false);
  
        //广播类型 routing key 模糊匹配
        channel.exchangeDeclare("topic-forever", BuiltinExchangeType.TOPIC,true);
        channel.exchangeDeclare("topic-temporary", BuiltinExchangeType.TOPIC,false);
  
        //使用键值对匹配
        channel.exchangeDeclare("headers-forever", BuiltinExchangeType.HEADERS,true);
        channel.exchangeDeclare("headers-temporary", BuiltinExchangeType.HEADERS,false);
  
        channel.close();
    }
```
  
> * 交换机类型分为四种 direct、fanout、topic、header（这个性能最差）
> * channel 官方建议不要多线程共享，最好一个线程使用一个channel
  
然后登陆Web 管理界面查看
  
http://192.168.92.128:15672/#/exchanges
  
发现已经有我们声明的交换机了
  
其中还有一些默认的交换机
  
我们也可以看到交换机是在虚拟主机中的、每个虚拟主机互相隔离
  
我们也发现在Features列，永久的交换机是带有D标签的
  
---
  
接下来我们来声明队列
  
``` java
    @Test
    public void test2() throws Exception{
        Channel channel=conn.createChannel();
        //创建队列
  
        /*
        * queue - 队列的名称
        * durable - 如果我们声明一个持久队列，则为true（队列将在服务器重启后继续存在）
        * exclusive - 如果我们声明一个独占队列（仅限于此连接），则为true
        * autoDelete - 如果我们声明一个自动删除队列，则为true（服务器将在不再使用时将其删除）,消费者断开连接时是否删除队列
        * arguments - 队列的其他属性（构造参数）
        * */
        channel.queueDeclare("Aqua-forever",true,false,false,null);
        channel.queueDeclare("fanout1-forever",true,false,false,null);
        channel.queueDeclare("fanout2-forever",true,false,false,null);
        channel.queueDeclare("topic1-forever",true,false,false,null);
        channel.queueDeclare("topic2-forever",true,false,false,null);
        channel.queueDeclare("topic3-forever",true,false,false,null);
        channel.queueDeclare("headers1-forever",true,false,false,null);
        channel.queueDeclare("headers2-forever",true,false,false,null);
  
        //主动声明一个服务器命名的独占，自动删除，非持久队列。
        String queueName = channel.queueDeclare().getQueue();
        System.out.println(queueName);
  
        queueName = channel.queueDeclare().getQueue();
        System.out.println(queueName);
  
        queueName = channel.queueDeclare().getQueue();
        System.out.println(queueName);
  
        System.in.read();
  
        channel.close();
    }
```

这里我们使用System.in.read 进行阻塞
  
打开 http://192.168.92.128:15672/#/queues
  
我们可以看到我们的队列已经出来了，也有一些临时队列
  
声明队列也就两个api 函数
  
当我们点击结束进程的时候，断开连接了，临时队列就会自动删除
  
队列也有了，接下来就是和交换机绑定了，不然发送的数据没办法进入队列
  
因为exchange 是负责数据转发的，而队列（queue）只是保存数据的
  
``` java
    @Test
    public void test3() throws Exception{
        Channel channel=conn.createChannel();
        //队列绑定交换机，一个队列可绑定多个交换机
  
        /*
        * queue - 队列的名称
        * exchange - 交易所的名称
        * routingKey - 用于绑定的路由密钥
        * */
  
        //绑定到直接交换机
        channel.queueBind("Aqua-forever","direct-forever","Aqua-1");
  
        //绑定到广播(fanout类型，对Routing Key无效)
        channel.queueBind("fanout1-forever","fanout-forever","Aqua-1");
        channel.queueBind("fanout2-forever","fanout-forever","Aqua-2");
  
        //绑定到广播 routing key 模糊匹配
        channel.queueBind("topic1-forever","topic-forever","Aqua.#");
        channel.queueBind("topic2-forever","topic-forever","Aqua.mea.*");
        channel.queueBind("topic3-forever","topic-forever","Aqua.suki.*");
  
        //绑定到广播(fanout类型，对Routing Key无效)
        channel.queueBind("fanout1-forever","fanout-forever","Aqua-1");
        channel.queueBind("fanout2-forever","fanout-forever","Aqua-2");
  
        Map<String,Object> map = new HashMap<>();
        map.put("x-match", "any");//这代表消息携带的Hash是需要全部匹配键值(all)，还是仅匹配一个键值(any)就可以了
        map.put("xxx","111");
        map.put("aaa","bbb");
        channel.queueBind("headers1-forever","headers-forever","",map);
        map.put("x-match", "all");
        channel.queueBind("headers2-forever","headers-forever","",map);
  
        channel.close();
    }
```
  
接下来发送消息（生产消息）到服务器
  
``` java
    @Test
    public void test4() throws Exception{
        Channel channel = conn.createChannel();
        //发送消息(生产消息)
  
  
        channel.basicPublish("direct-forever","Aqua-1",null,getMessage().getBytes());
  
        //routing key 直接忽略
        channel.basicPublish("fanout-forever","Aqua-1",null,getMessage().getBytes());
        channel.basicPublish("fanout-forever","Aqua-2",null,getMessage().getBytes());
  
        /*
        topic路由器的关键在于定义路由键，定义routingKey名称不能超过255字节，使用“.”作为分隔符，例如：com.mq.rabbit.error。
  
        消费消息的时候routingKey可以使用下面字符匹配消息：
  
        "*"匹配一个分段(用“.”分割)的内容；
        "#"匹配0和多个字符；
        例如发布了一个“com.mq.rabbit.error”的消息：
  
        能匹配上的路由键：
  
        cn.mq.rabbit.*
        cn.mq.rabbit.#
        #.error
        cn.mq.#
        #
        不能匹配上的路由键：
  
        cn.mq.*
        *.error
        *
        所以如果想要订阅所有消息，可以使用“#”匹配。
        */
        channel.basicPublish("topic-forever","Aqua.hello",null,getMessage().getBytes());
        channel.basicPublish("topic-forever","Aqua.mea.suki",null,getMessage().getBytes());
        channel.basicPublish("topic-forever","Aqua.suki.me",null,getMessage().getBytes());
  
  
        Map<String,Object> map = new HashMap<>();
        map.put("xxx","111");
        channel.basicPublish("headers-forever","",new AMQP.BasicProperties().builder().headers(map).build(),getMessage().getBytes());
  
  
  
        /*
        void basicPublish(String exchange, String routingKey, BasicProperties props, byte[] body) throws IOException;
        void basicPublish(String exchange, String routingKey, boolean mandatory, BasicProperties props, byte[] body)
            throws IOException;
        void basicPublish(String exchange, String routingKey, boolean mandatory, boolean immediate, BasicProperties props, byte[] body)
            throws IOException;
  
  
        他们共有的参数分别是：
        exchange：交换机名称
        routingKey：路由键
        props：消息属性字段，比如消息头部信息等等
        body：消息主体部分
        除此之外，还有mandatory和immediate这两个参数，鉴于RabbitMQ3.0不再支持immediate标志，因此我们重点讨论mandatory标志
        mandatory的作用：
  
        当mandatory标志位设置为true时，如果exchange根据自身类型和消息routingKey无法找到一个合适的queue存储消息，那么broker会调用basic.return方法将消息返还给生产者;
        当mandatory设置为false时，出现上述情况broker会直接将消息丢弃;通俗的讲，mandatory标志告诉broker代理服务器至少将消息route到一个队列中，否则就将消息return给发送者;
        */
        //Return(int replyCode, String replyText, String exchange, String routingKey, AMQP.BasicProperties properties, byte[] body)
  
        //这里我们尝试发送无法路由的数据
        channel.basicPublish("direct-forever","Aqua-tietie",true,null,getMessage().getBytes());
        //
        channel.addReturnListener((i, s, s1, s2, basicProperties, bytes) ->
                System.out.println(String.format("replyCode=%d replyText=%s exchange=%s routingKey=%s body=%s",i,s,s1,s2,new String(bytes,"UTF-8")))
        );
  
        System.in.read();
  
        channel.close();
    }
  
    public String getMessage(){
        return (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + " : Hello Aqua!!!!!!!!!!!!! prpr!!!!!!!!!!!!!");
    }
```
  
执行后可以看到控制台输出无法路由的数据
  
``` text
replyCode=312 replyText=NO_ROUTE exchange=direct-forever routingKey=Aqua-tietie body=2019-05-14 17:00:53 : Hello Aqua!!!!!!!!!!!!! prpr!!!!!!!!!!!!!
```
  
打开 http://192.168.92.128:15672/#/queues 可以看到数据已经到达队列中了
  
---
  
下面我们可以从消息队列中取数据了，取数据比较简单
  
``` java
    public void test5() throws Exception{
        Channel channel = conn.createChannel();
  
        /*
        * 1.队列名称
        * 2. auto ack 自动确认
        * 3. consumerTag 取消回调的时候用的
        * 4. 接受消息回调
        * 5. 回调被取消的回调 例如队列被删除，或者在集群方案中，队列所在的节点失败
        * */
        channel.basicConsume("Aqua-forever",false,"Aqua-listened-1",(s, delivery) -> {
            System.out.println(String.format("tag: %s exchange: %s routing key: %s",s,delivery.getEnvelope().getExchange(),delivery.getEnvelope().getRoutingKey()));
            System.out.println(String.format("msg: %s",new String(delivery.getBody(),"UTF-8")));
  
            channel.basicAck(delivery.getEnvelope().getDeliveryTag(),false);
        },s -> System.out.println("监听被取消: "+ s));
  
        //这里我们没有进行确认，当与服务器断开连接，数据将会重新放回队列
        //让其他消费者进行消费
        channel.basicConsume("fanout1-forever",false,"Aqua-listened-2",(s, delivery) -> {
            System.out.println(String.format("tag: %s exchange: %s routing key: %s",s,delivery.getEnvelope().getExchange(),delivery.getEnvelope().getRoutingKey()));
            System.out.println(String.format("msg: %s",new String(delivery.getBody(),"UTF-8")));
  
            //channel.basicAck(delivery.getEnvelope().getDeliveryTag(),false);
        },s -> System.out.println("监听被取消: "+ s));
  
  
  
        //也可是使用DefaultConsumer 官方文档用的就是这个
//        channel.basicConsume("Aqua-forever",false,"Aqua-listened",new DefaultConsumer(channel){
//            @Override
//            public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body) throws IOException {
//
//
//                channel.basicAck(envelope.getDeliveryTag(),false);
//            }
//        });
  
        channel.addShutdownListener(e ->
            System.out.println(String.format("连接关闭 %s %b",e.getMessage(),e.isHardError()))
        );
  
        System.in.read();
        channel.close();
    }
```
  
如果autoAck设置为false，需要调用basicAck 进行确认，未确认的将放到未确认队列，如果此时客户端断开连接，将重新放回原队列
  
如果autoAck设置为true，则服务器发送消息后，将消息从客户端移除
  
**需要查阅API [请点击](#帮助 )**
  
---
  
<div id="link5"></div>
  
## RabbitMQ概念

### 概念

**看图**
  
![我是图片](https://upload-images.jianshu.io/upload_images/5015984-367dd717d89ae5db.png )
  
1. Message
  
消息，消息是不具名的，它由消息头和消息体组成。消息体是不透明的，而消息头则由一系列的可选属性组成，这些属性包括routing-key（路由键）、priority（相对于其他消息的优先权）、delivery-mode（指出该消息可能需要持久性存储）等。
  
2. Publisher
  
消息的生产者，就是发送消息的，也是一个向交换器发布消息的客户端应用程序。
  
3. Exchange
  
交换器，就是转发消息的，用来接收生产者发送的消息并将这些消息路由给服务器中的队列。
  
4. Binding
  
绑定，用于消息队列和交换器之间的关联。一个绑定就是基于路由键将交换器和消息队列连接起来的路由规则，所以可以将交换器理解成一个由绑定构成的路由表。
  
队列绑定交换机，一个队列可以绑定多个交换机，一个交换机也可以对应多个队列，多对多关系
  
5. Queue
  
消息队列，用来保存消息直到发送给消费者。它是消息的容器，也是消息的终点。一个消息可投入一个或多个队列。消息一直在队列里面，等待消费者连接到这个队列将其取走。
  
6. Connection
  
网络连接，比如一个TCP连接。
  
7. Channel
  
信道，多路复用连接中的一条独立的双向数据流通道。信道是建立在真实的TCP连接内地虚拟连接，AMQP 命令都是通过信道发出去的，不管是发布消息、订阅队列还是接收消息，这些动作都是通过信道完成。因为对于操作系统来说建立和销毁 TCP 都是非常昂贵的开销，所以引入了信道的概念，以复用一条 TCP 连接。
  
其实是一个Channel对应一条TCP连接，还有官方建议不要多线程共享Channel，最好是一个线程对应一个Channel

8. Consumer
  
接收消息的，消息的消费者，表示一个从消息队列中取得消息的客户端应用程序。
  
9. Virtual Host
  
虚拟主机，表示一批交换器、消息队列和相关对象。虚拟主机是共享相同的身份认证和加密环境的独立服务器域。每个 vhost 本质上就是一个 mini 版的 
RabbitMQ 服务器，拥有自己的队列、交换器、绑定和权限机制。vhost 是 AMQP 概念的基础，必须在连接时指定，RabbitMQ 默认的 vhost 是 / 。
  
10. Broker
  
表示消息队列服务器实体。

### AMQP中的消息路由

![我是图片](https://upload-images.jianshu.io/upload_images/5015984-7fd73af768f28704.png )
  
生产者发送消息到交换机，交换机根据交换机类型和参数、绑定的队列，转发到对应的队列
  
消费者去队列取出数据
  
### Exchange 类型

Exchange分发消息时根据类型的不同分发策略有区别，目前共四种类型：direct、fanout、topic、headers 。headers 匹配 AMQP 消息的 header 而不是路
由键，此外 headers 交换器和 direct 交换器完全一致，但性能差很多，目前几乎用不到了，所以直接看另外三种类型
  
1. direct
  
![我是图片](https://upload-images.jianshu.io/upload_images/5015984-13db639d2c22f2aa.png )
  
消息中的路由键（routing key）如果和 Binding 中的 binding key 一致， 交换器就将消息发到对应的队列中。路由键与队列名完全匹配，如果一个队列绑定到交换机要求路由键为“dog”，则只转发 routing key 标记为“dog”的消息，不会转发“dog.puppy”，也不会转发“dog.guard”等等。它是完全匹配、单播的模式。
  
2. fanout
  
![我是图片](https://upload-images.jianshu.io/upload_images/5015984-2f509b7f34c47170.png )
  
每个发到 fanout 类型交换器的消息都会分到所有绑定的队列上去。fanout 交换器不处理路由键，只是简单的将队列绑定到交换器上，每个发送到交换器的消息都会被转发到与该交换器绑定的所有队列上。很像子网广播，每台子网内的主机都获得了一份复制的消息。fanout 类型转发消息是最快的。
  
3. topic
  
![我是图片](https://upload-images.jianshu.io/upload_images/5015984-275ea009bdf806a0.png )
  
topic 交换器通过模式匹配分配消息的路由键属性，将路由键和某个模式进行匹配，此时队列需要绑定到一个模式上。它将路由键和绑定键的字符串切分成单词，这些单词之间用点隔开。它同样也会识别两个通配符：符号“#”和符号“”。#匹配0个或多个单词，匹配不多不少一个单词。
  
  
> *	basicPublish​(String exchange, String routingKey, boolean mandatory, boolean immediate, AMQP.BasicProperties props, byte[] body)
> * basicPublish​(String exchange, String routingKey, boolean mandatory, AMQP.BasicProperties props, byte[] body)
> * basicPublish​(String exchange, String routingKey, AMQP.BasicProperties props, byte[] body)
> * 可以根据 mandatory 进行无法路由的消息进行处理
> * mandatory = false 无法路由的消息直接丢弃
> * mandatory = true 无法路由的消息通过 Return 回调函数 通知
> * immediate RabbitMQ 3.0 不再支持此标记
  
---
  
<div id="link6"></div>
  
## RabbitMQ消息事务

### 事务

消息事物保证消息一定到达RabbitMQ服务器
  
只有三个Api
  
channel.txSelect() 声明启动事务模式；
  
channel.txComment() 提交事务；
  
channel.txRollback() 回滚事务；
  
虽然当你调用publish 发送到服务器的时候，服务器收到并不会把他立刻放到队列，只有事务提交才会进入队列
  
事务性能很低，事务api 比较简单没有什么好描述的了
  
### 扩展知识
  
  
扩展知识
我们知道，消费者可以使用消息自动或手动发送来确认消费消息，那如果我们在消费者模式中使用事务（当然如果使用了手动确认消息，完全用不到事务的），会发生什么呢？
  
消费者模式使用事务
  
假设消费者模式中使用了事务，并且在消息确认之后进行了事务回滚，那么RabbitMQ会产生什么样的变化？
  
结果分为两种情况：
  
1. autoAck=false手动应对的时候是支持事务的，也就是说即使你已经手动确认了消息已经收到了，但在确认消息会等事务的返回解决之后，在做决定是确认消息还是重新放回队列，如果你手动确认现在之后，又回滚了事务，那么已事务回滚为主，此条消息会重新放回队列；
  
2. autoAck=true如果自定确认为true的情况是不支持事务的，也就是说你即使在收到消息之后在回滚事务也是于事无补的，队列已经把消息移除了；
  
---
  
<div id="link7"></div>
  
## RabbitMQ消息确认

Confirm发送方确认模式使用和事务类似，也是通过设置Channel进行发送方确认的。
  
效率比事务要快
  
Confirm的三种实现方式：
  
1. channel.waitForConfirms()普通发送方确认模式；
  
2. channel.waitForConfirmsOrDie()批量确认模式；
  
3. channel.addConfirmListener()异步监听发送方确认模式；
  
  
使用 channel.confirmSelect() 开启消息确认回调
  
### 普通Confirm模式

``` java
    @Test
    public void Test77() throws Exception{
        Channel channel = conn.createChannel();
  
        channel.confirmSelect();
        channel.basicPublish("direct-forever","Aqua-1",null,getMessage().getBytes());
        if(channel.waitForConfirms())
            System.out.println("发送成功");
        else
            System.out.println("发送失败");
  
        channel.close();
    }
```
  
### 批量Confirm模式

```java
    @Test
    public void Test777() throws Exception{
        Channel channel = conn.createChannel();
  
        channel.confirmSelect();
        for (int i=0;i<10;++i)
            channel.basicPublish("direct-forever","Aqua-1",null,getMessage().getBytes());
        channel.waitForConfirmsOrDie();
        System.out.println("发送成功");
  
        channel.close();
    }
```
  
### 异步Confirm模式

``` java
    @Test
    public void test7() throws Exception{
        Channel channel = conn.createChannel();
  
        channel.confirmSelect();
  
        /*
            可以看出，代码是异步执行的，消息确认有可能是批量确认的，是否批量确认在于返回的multiple的参数，
            此参数为bool值，如果true表示批量执行了deliveryTag这个值以前的所有消息，如果为false的话表示单条确认。
        * */
        channel.addConfirmListener((l, b) -> {
            System.out.println("已经确认 "+ l + " " + b);
        },(l, b) -> {
            System.out.println("未确认 " + l + " " + b);
        });
  
        channel.basicPublish("direct-forever","Aqua-1",null,getMessage().getBytes());
        channel.basicPublish("direct-forever","Aqua-1",null,getMessage().getBytes());
        channel.basicPublish("direct-forever","Aqua-1",null,getMessage().getBytes());
  
        System.in.read();
        channel.close();
    }
```

> * 性能比较 普通模式 < 批量模式 < 异步模式 
  
---
  
<div id="link8"></div>

## RabbitMQ配置

文件需要自己创建

rabbitmq.conf和rabbitmq-env.conf的位置
这些文件的位置是特定于分发的。默认情况下，它们不是创建的，但希望位于每个平台的以下位置：

通用UNIX：`$RABBITMQ_HOME/etc/rabbitmq/`
Debian：`/etc/rabbitmq/`
RPM：`/etc/rabbitmq/`
Mac OS（Homebrew）：`${install_prefix}/etc/rabbitmq/`，Homebrew地窖前缀通常是`/usr/local`
Windows：`％APPDATA％\RabbitMQ\`
如果rabbitmq-env.conf不存在，则可以在由RABBITMQ_CONF_ENV_FILE变量指定的位置手动创建。在Windows系统上，它名为rabbitmq-env.bat。

如果rabbitmq.conf不存在，可以手动创建。如果更改位置，请设置RABBITMQ_CONFIG_FILE环境变量。RabbitMQ自动将.conf扩展名附加到此变量的值。

更改后重新启动服务器。添加或删除配置文件后，Windows服务用户需要重新安装该服务

[官方文档](https://www.rabbitmq.com/configure.html)

---
  
<div id="link9"></div>
  
## RabbitMQ集群

### Rabbitmq集群高可用

RabbitMQ是用erlang开发的，集群非常方便，因为erlang天生就是一门分布式语言,但其本身并不支持负载均衡。

Rabbit模式大概分为以下三种：单一模式、普通模式、镜像模式
集群最少需要一个磁盘节点

#### 单一模式：最简单的情况，非集群模式。

没什么好说的。

#### 普通模式：默认的集群模式。

对于Queue来说，消息实体只存在于其中一个节点，A、B两个节点仅有相同的元数据，即队列结构。

当消息进入A节点的Queue中后，consumer从B节点拉取时，RabbitMQ会临时在A、B间进行消息传输，把A中的消息实体取出并经过B发送给consumer。

所以consumer应尽量连接每一个节点，从中取消息。即对于同一个逻辑队列，要在多个节点建立物理Queue。否则无论consumer连A或B，出口总在A，会产生瓶颈。

该模式存在一个问题就是当A节点故障后，B节点无法取到A节点中还未消费的消息实体。

如果做了消息持久化，那么得等A节点恢复，然后才可被消费；如果没有持久化的话，然后就没有然后了……

#### 镜像模式：把需要的队列做成镜像队列，存在于多个节点，属于RabbitMQ的HA方案。

该模式解决了上述问题，其实质和普通模式不同之处在于，消息实体会主动在镜像节点间同步，而不是在consumer取数据时临时拉取。

该模式带来的副作用也很明显，除了降低系统性能外，如果镜像队列数量过多，加之大量的消息进入，集群内部的网络带宽将会被这种同步通讯大大消耗掉。

所以在对可靠性要求较高的场合中适用(后面会详细介绍这种模式，目前我们搭建的环境属于该模式)

启动磁盘节点

``` bash
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl start_app
```

查看集群状态

rabbit1

``` bash
rabbitmqctl cluster_status
```

加入集群，只要加入其中一个节点就可以了

rabbit2

``` bash
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster --ram rabbit@rabbit1
rabbitmqctl start_app
```

rabbit3

``` bash
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster --ram rabbit@rabbit1
rabbitmqctl start_app
```

退出集群

``` bash
# on rabbit3
rabbitmqctl stop_app
# => Stopping node rabbit@rabbit3 ...done.

rabbitmqctl reset
# => Resetting node rabbit@rabbit3 ...done.
rabbitmqctl start_app
# => Starting node rabbit@rabbit3 ...done.
```

使用Rabbit镜像功能，需要基于rabbitmq策略来实现，政策是用来控制和修改群集范围的某个vhost队列行为和Exchange行为

在cluster中任意节点启用策略，策略会自动同步到集群节点

``` bash
rabbitmqctl set_policy -p hrsystem ha-allqueue"^" '{"ha-mode":"all"}'
```

这行命令在vhost名称为hrsystem创建了一个策略，策略名称为ha-allqueue,策略模式为 all 即复制到所有节点，包含新增节点，
策略正则表达式为 “^” 表示所有匹配所有队列名称。
例如rabbitmqctl set_policy -p hrsystem ha-allqueue "^message" '{"ha-mode":"all"}'
注意："^message" 这个规则要根据自己修改，这个是指同步"message"开头的队列名称，我们配置时使用的应用于所有队列，所以表达式为"^"
官方set_policy说明参见

[官方set_policy](https://www.rabbitmq.com/rabbitmqctl.8.html#Policy_Management)

[集群指南](https://www.rabbitmq.com/clustering.html)

---
  
## 完结撒花

---
  
<div id="link10"></div>
  
## 帮助

[官网](https://www.rabbitmq.com)
  
[Java RabbitMQ Client Api 文档](https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/Channel.html )
  
[RabbitMQ Java Api官方教程生肉](https://www.rabbitmq.com/api-guide.html )
  
[RabbitMQ Java Api官方教程熟肉](https://blog.csdn.net/csdnzouqi/article/details/78926603#%E5%8F%91%E5%B8%83%E6%B6%88%E6%81%AFpublishing-messages )

[消息队列之 RabbitMQ](https://www.jianshu.com/p/79ca08116d57)

[分布式开放消息系统(RocketMQ)的原理与实践](https://www.jianshu.com/p/453c6e7ff81c)

[RabbitMQ集群](https://www.cnblogs.com/wyt007/p/9081931.html)

[Rabbitmq集群高可用测试](http://www.cnblogs.com/flat_peach/archive/2013/04/07/3004008.html)

[Rabbitmqctl 文档](https://www.rabbitmq.com/rabbitmqctl.8.html)

[RabbitMQ系列文章](https://blog.csdn.net/u011665991/article/details/89487510)
  