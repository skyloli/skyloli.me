import $ from 'jquery'
var jQuery = $;
import './type'
import './title'
import './aplayer'
import './pjax'
import {init} from './xx'
import {pisces} from './pisces'
import {postDetails} from './post-details'
import {zoomContent} from './zoom'

// Navigation Bar
$('.menu-item').hover(function () {
	const subtitle = $(this).find('.submenu');
	if (subtitle.length) {
	  subtitle.css({
		height: subtitle[0].scrollHeight
	  })
	}}, function () {
	const subtitle = $(this).find('.submenu');
	if (subtitle.length) {
	  subtitle.css({
		height: ''
	  })
	}
})

// search
$('.search-form').submit(function (e) {
  e.preventDefault();
  window.open(`https://www.google.com/search?&q=site%3A${window.location.host}+${encodeURIComponent($('.search-form input[name="keyword"]').val())}`);
});

pisces();
postDetails();
init();
zoomContent();