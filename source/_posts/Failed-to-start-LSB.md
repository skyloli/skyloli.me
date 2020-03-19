---
title: Failed to start LSB
date: 2019-5-1 22:53:25
categories:
  - 烫烫烫烫
---
不知道怎么了，网络突然不行了

查了一下说是网卡的mac地址和配置文件的不一致

看了下我的网卡配置 /etc/sysconfig/network-scripts/ifcfg-ens11

我根本没有配置HWADDR 属性

看到其他地方说是NetworkManager 服务导致的

我先把他停止，然后启动网络服务，在重新启动网络管理服务，解决了

``` bash
systemctl stop NetworkManager
systemctl start network
systemctl start NetworkManager
```
