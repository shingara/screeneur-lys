
function infoplayer_map(event, elt, id_player){
  var xe = Event.pointerX(event);
  var ye = Event.pointerY(event);
  var div_node = $('bulle')
  div_node.style.left =  xe + 'px'
  div_node.style.top =  (ye - 300) + 'px'
  div_node.style.display = 'block'
}
