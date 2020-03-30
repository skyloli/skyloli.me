---
title: BOSS 直聘 反反调试
date: 2020-03-29 14:20:46
categories:
  - [debug, javascript]
---
无聊按到了浏览器F12（找工作的时候无聊）

![I am a image](/images/zhiping_antianti_debug_1.png)

https://www.zhipin.com/web/common/security-js/59106eb1.js

这是反调试，还加了混淆

因为JavaScript是单线程，要达到循环调用要使用setinterval

所以使用
``` javascript
clearInterval(1)
```
复制进浏览器执行，关闭调试窗口，重新在按F12打开调试窗口即可

OK，解决

还有其他解决方式可以用代理替换security-js/59106eb1.js

