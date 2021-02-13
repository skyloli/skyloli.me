---
title: Arch Linux Installation
date: 2020-12-07 21:20:01
categories:
  - [linux]
---

[官方安装教程](https://wiki.archlinux.org/index.php/Installation_guide_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

[参考1](https://blog.yoitsu.moe/arch-linux/installing_arch_linux_for_complete_newbies.html)

[参考2](https://shenyu.me/2020/04/11/arch-uefi-install.html)

[分区](https://wiki.archlinux.org/index.php/Partitioning_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E9%80%89%E6%8B%A9_GPT_%E8%BF%98%E6%98%AF_MBR)

## 键盘布局

控制台键盘布局默认为 us（美式键盘映射）。列出所有可用的键盘布局，可以使用：

``` bash
ls /usr/share/kbd/keymaps/**/*.map.gz
```

如果您想要更改键盘布局，可以将一致的文件名添加进 loadkeys(1)，但请省略路径和扩展名。比如，要添加 German 键盘布局：

``` bash
loadkeys de-latin1
```

