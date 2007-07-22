function infojoueur(ele, MAT,Pseudo,Grade,Niveau,Nom_a,Cible,Arme,Cam,Prec,Message,Idj,Camp){
  
  $('plateau').getElementsByClassName('player_select').each(function (e){
    e.className = ''
  })
  ele.className = 'player_select'
  $('mat_player').update(unescape(MAT))
  $('fiche_perso').update('<a href="http://www.conquest-lys.net/index.php?mod=fiche&mat=' + unescape(MAT) + '">Fiche Perso</a>')
  $('pseudo').update(unescape(Pseudo))
  $('grade').update(unescape(Grade))
  $('niveau').update(unescape(Niveau))
  $('arme').update(unescape(Arme))
 
  var expression = /(.)-([^-]*)-[0-9]*[^0-9]*Pos[^0-9]*([0-9]*\/[0-9]*)/
  expression.exec(Nom_a)
  $('compa').update(unescape(RegExp.$2))

  $('race').update(unescape(RegExp.$1))
  if (parseInt(Cam) != 0){
    $('camouflage').update('oui')
  } else {
    $('camouflage').update('non')
  }

  $('position').update(unescape(RegExp.$3))
  if (Camp == 0){
    $('affinity').update('posteur')
  } else if (Camp == 1){
    $('affinity').update('ami')
  } else if (Camp == 2){
    $('affinity').update('allié')
  } else {
    $('affinity').update('ennemi')
  }


}
