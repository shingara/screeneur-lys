function infojoueur(ele, MAT,Pseudo,Grade,Niveau,Nom_a,Cible,Arme,Cam,Prec,Message,Idj,Camp){
  
  $('plateau').getElementsByClassName('player_select').each(function (e){
    e.className = ''
  })
  ele.className = 'player_select'
  $('mat_player').update(unescape(MAT))
  $('pseudo').update(unescape(Pseudo))
  $('grade').update(unescape(Grade))
  $('niveau').update(unescape(Niveau))
 
  var expression = /(.)-([^-]*)-[0-9]*[^0-9]*Pos[^0-9]*([0-9]*\/[0-9]*)/
  expression.exec(Nom_a)
  $('compa').update(unescape(RegExp.$2))

  $('race').update(unescape(RegExp.$1))
  if (Cam == 1){
    $('camouflage').update('oui')
  } else {
    $('camouflage').update('non')
  }

  $('position').update(unescape(RegExp.$3))
  if (Camp == 1){
    $('affinity').update('ami')
  } else if (Camp == 2){
    $('affinity').update('allié')
  } else {
    $('affinity').update('ennemi')
  }


}
