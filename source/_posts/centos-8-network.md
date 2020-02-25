---
title: CentOS 8 网络设置
date: 2020-01-17 14:30:46
tags: [Linux,CentOS,CentOS8]
categories:
  - Linux
---

配置好ip后想重启network，提示network不存在，CentOS7好像还有CentOS8直接不存在了

不能使用service和systemctl

systemctl取代service

network 服务被 nmcli 命令取代

``` bash
#重启网卡
nmcli c reload 
```
[nmcli 指南](https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/7/html/networking_guide/sec-using_the_networkmanager_command_line_tool_nmcli)
