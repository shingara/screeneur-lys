function show_loader(){
  Element.show('loader_ajax')
  $('bulle_loader').style.height = '150px'
  $('bulle_content').update('')
  $('bulle_content').style.top = '76px'
  $('bulle_content').style.height = '200px'
}

function hide_loader(){
  Element.hide('loader_ajax')
  $('bulle_loader').style.height = 0
  $('bulle_content').style.top = '26px'
  $('bulle_content').style.height = '250px' 
}

function prepare_ajax(event){
  var xe = Event.pointerX(event);
  var ye = Event.pointerY(event);
  var div_node = $('bulle')
  div_node.style.left =  xe + 'px'
  div_node.style.top =  (ye - 350) + 'px'
  div_node.style.display = 'block'
}

function infoplayer_map(event, elt, id_player){
  prepare_ajax(event)
  new Ajax.Updater('bulle_content', '/maps/player', {
      parameters: {'id': id_player},
      onLoading: function(){show_loader()},
      onComplete: function(){hide_loader()}
      })
}

function infoobjet_map(event, elt, id_objet){
  prepare_ajax(event)
  new Ajax.Updater('bulle_content', '/maps/objet', {
      parameters: {'id': id_objet},
      onLoading: function(){show_loader()},
      onComplete: function(){hide_loader()}
      })
}

function hide_bulle(){
  $('bulle').hide()
}

function load_js(){
  if ($('close_bulle')){
    Event.observe('close_bulle', 'click', hide_bulle)
  }
}

Event.observe(window, 'load', load_js)
