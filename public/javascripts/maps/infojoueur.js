
function infoplayer_map(event, elt, id_player){
  var xe = Event.pointerX(event);
  var ye = Event.pointerY(event);
  var div_node = $('bulle')
  div_node.style.left =  xe + 'px'
  div_node.style.top =  ye + 'px'
  div_node.style.background = 'yellow';
  div_node.style.width = '100px';
  div_node.style.height = '100px';
  div_node.style.position = 'absolute'
  document.appendChild(div_node);
}
