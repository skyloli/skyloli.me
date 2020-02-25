---
title: csdn 突破正版链接直接下载
date: 2018-10-10 22:53:25
tags: [JavaScript,csdn]
categories:
  - 编程
---
``` javascript
//https://download.csdn.net/download/anonymous1991/10137472
//fileId=10137472
//不能免积分，版权限制不能下载
function csdnFileDownload(fileId){
	$.ajax({
		type: 'get',
		url: "/index.php/source/before_do_download/"+fileId,
		async: false,
		dataType: 'jsonp',
		jsonpcallback: 'jsonpcallback',
		success: function (resobj) {
			var targetUrl=resobj.actionUrl+"/"+encodeURIComponent(encodeURIComponent(SMSdk.getDeviceId()));
			console.log(targetUrl);

			$.ajax({
				type: 'get',
				url: targetUrl,
				async: false,
				dataType: 'jsonp',
				jsonpcallback: 'jsonpcallback',
				success: function (resobj) {
					console.log(resobj);
					location.href=resobj.msg;
				},
				error: function (err) {
					console.log(err);
				}
			});
    },
	error: function (err) {
		console.log(err);
	}})
}
```