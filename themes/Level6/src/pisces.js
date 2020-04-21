
import $ from 'jquery'
import {} from './affix'

export function pisces() {
	function getHeaderOffset () {
      return $('.header-inner').height() + 52;
    }
	$(document).ready(function () {
		
		if(!navigator.userAgent.match('/mobile/i')){
			var sidebarInner = $('.sidebar-inner');
			sidebarInner.affix({
			  offset: {
				top: getHeaderOffset() - 2 * 52,
				bottom: 400
			  }
			});
			
		}
	})
}