import * as zoom from 'zoom-image'

export function zoomContent () {
  Array.prototype.forEach.call($('.content img').not('[hidden]').not('.no-fancybox').not('.post-share img'), el => {
    zoom(el);
  });
}
