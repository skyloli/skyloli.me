import 'aplayer/dist/APlayer.min.css';
import APlayer from 'aplayer'
import $ from 'jquery'

const apFixed = new APlayer({
  element: document.getElementById('aplayer-fixed'),
  mutex: true,
  theme: '#97dffd',
  order: 'random',
  lrcType: 3,
  fixed: true,
});
$.ajax({
  url: CONFIG.online.music,
  success: function (list) {
    apFixed.list.add(list);
  }
});
