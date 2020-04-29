import $ from 'jquery'
import './jquery.pjax'
import './nprogress.css'
import * as NProgress from './nprogress'
import {pisces} from './pisces'
import {postDetails} from './post-details'
import {init} from './xx'
import {zoomContent} from './zoom'

$(document).pjax('a:not(.fancybox):not([target="_blank"])', '#main', {
  scrollTo: $('#main').position().top - 60,
  fragment: '#main',
  timeout: 5000,
});

$(document).on('pjax:start', function () {
    NProgress.start();
    $('html, body').animate({
      scrollTop: $('#main').position().top - 60
    }, 500);

    if (window.dplayers) {
      for (let i = 0; i < window.dplayers.length; i++) {
          window.dplayers[i].destroy();
      }
      window.dplayers = [];
    }
    if (window.aplayers) {
      for (let i = 0; i < window.aplayers.length; i++) {
        window.aplayers[i].destroy();
      }
      window.aplayers = [];
    }
});

$(document).on('pjax:end', function () {
    NProgress.done();
	pisces();
	postDetails();
	init();
	zoomContent();
    window.originTitle = document.title;

});
