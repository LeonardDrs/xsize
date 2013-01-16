$(document).ready(function(){
  $("#banner-imgs")
    .after('<div id="nav">')
    .cycle({
    fx: 'scrollHorz',
    speed: '500',
    pager:  '#nav' 
  });
});