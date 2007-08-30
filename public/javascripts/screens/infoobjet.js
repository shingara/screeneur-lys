function infoobjet(ID,Libelle,Cible,Terrain,Bonus,Info){
  if(Info != ""){
    $('objet_info').update(unescape(Info))
  }

  var expression = /(.+)Pos[^0-9]*([0-9]*\/[0-9]*)/
  expression.exec(Libelle)
  $('objet').update(unescape(RegExp.$1))
  $('objet_position').update(unescape(RegExp.$2))
}
