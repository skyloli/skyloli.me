import $ from 'jquery'
import * as social_share from './jquery.share.min.js'
import './nprogress.css'

export function init() {
	$('.sidebar-nav li').click(function(e){
		$('.sidebar-nav li').removeClass('sidebar-nav-active');
		$(this).addClass('sidebar-nav-active');
	});

	$('.sidebar-nav-toc').click(function(e){
		$('.site-overview-wrap').removeClass('sidebar-panel-active');
		$('.post-toc-wrap').addClass('sidebar-panel-active')
	});
	$('.sidebar-nav-overview').click(function(e){
		$('.site-overview-wrap').addClass('sidebar-panel-active');
		$('.post-toc-wrap').removeClass('sidebar-panel-active');
	});

	$('.sidebar-nav-active').click();


	$('.des-of-author-nav .des-of-author-title').click(function(e){
		$('.des-of-author-title.active').removeClass('active');
		$('.des-of-author-des.active').removeClass('active');
		const index = $(this).data('index');
		$(this).addClass('active');
		$(`.des-of-author-des[data-index="${index}"]`).addClass('active');
	});
	
	$('.post-toc a.nav-link').click(function(e){
		$('.post-toc a.nav-link').removeClass('active');
		$(this).addClass('active');
		$('html,body').animate({
			scrollTop: $('.post-body a.headerlink[href="'+ $(this).attr('href') +'"]').offset().top
		},1000);
	});
	
	function share () {
	  if ($('.post-share').length) {
		  social_share('.post-share',{
		  disabled: ['tencent', 'douban', 'linkedin', 'diandian', 'facebook', 'google'],
		  wechatQrcodeTitle: "微信扫一扫",
		  wechatQrcodeHelper: '<p>微信扫一扫，右上角分享</p>',
		  source: CONFIG.site.title
		})
	  }
	}
	share();
	
	function show_date_time () {
	  window.setTimeout(function () {
		show_date_time();
	  }, 1000);
	  var BirthDay = new Date(window.CONFIG.since);
	  var today = new Date();
	  var timeold = (today.getTime() - BirthDay.getTime());
	  var msPerDay = 24 * 60 * 60 * 1000;
	  var e_daysold = timeold / msPerDay;
	  var daysold = Math.floor(e_daysold);
	  var e_hrsold = (e_daysold - daysold) * 24;
	  var hrsold = Math.floor(e_hrsold);
	  var e_minsold = (e_hrsold - hrsold) * 60;
	  var minsold = Math.floor((e_hrsold - hrsold) * 60);
	  var seconds = Math.floor((e_minsold - minsold) * 60);
	  $('#since').html(daysold + "天" + hrsold + "小时" + minsold + "分" + seconds + "秒");
	}
	
	show_date_time();
}