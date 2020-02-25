---
title: Linux 修改最大打开文件数量
date: 2019-5-1 22:53:25
tags: [Linux,CentOS7]
categories:
  - Linux
---
查看

``` bash
ulimit -n
```

临时修改

``` bash
ulimit -n 65535
```

<!--more-->

永久修改

在`/etc/security/limits.conf`加入

``` bash
* soft nofile 65535
* hard nofile 65535
```

`*` 表示所有用户

注意用户最大打开文件数量不能大于系统规定的打开数量

查看系统最大打开文件数量

``` bash
cat /proc/sys/fs/file-max
```

临时修改系统最大打开文件数量直接修改上面的文件中的数字即可

永久修改

在`/etc/sysctl.conf`加入

``` conf
fs.file-max = 6553560
```

如果要通过安全shell（SSH）访问

还应编辑`/etc/ssh/sshd_config`并取消注释以下行：

``` conf
#UseLogin no
```

并将其值设置yes为如下所示：

``` conf
UseLogin yes
```

``` bash
ssh restart
```

重新启动计算机以使限制生效并使用以下命令验证是否已设置新限制：

``` bash
ulimit -a
```

With systemd (Recent Linux Distributions)

比如Centos 7

可以修改`/etc/systemd/system.conf`中的

``` conf
DefaultLimitNOFILE
```

重启后生效

针对单独的进程可以设置`/etc/systemd/system/xxx.service.d/limits.conf`

`xxx`是进程

``` conf
[Service]
LimitNOFILE=64000
```
