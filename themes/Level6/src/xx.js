import $ from 'jquery'

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
	

}