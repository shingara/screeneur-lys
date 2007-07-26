module ParseMap

  class ParseMapError < Exception
  end

  # Parse the HTML for find the plateau and create All box and Type in
  # Database. You need send the Map Object in parameters
  #
  # Return the node plateau for create the screen
  def parse_html(data, map)
    data.gsub! /<\/br>/, '<br />'
    data.gsub! /<head.+\/head>/, ''
    data.gsub!(/onclick=[ ]*'.+'/) { |i|
      re = "onclick=\"#{$1.gsub! /"/, '\''}\"" if i =~ /onclick=[ ]*'(.+)'/
      re.gsub! /infojoueur\('/, 'infojoueur(this,\''
      re
    }
    html = Hpricot data
    plateau = html.get_element_by_id('plateau')
   
    raise ParseMapError if plateau.nil?
    args = {:plateau => plateau, :map => map.id}
    MiddleMan.new_worker({:class => :insert_map_bdd_worker, :job_key => :insert_map_bdd})
    work = MiddleMan.worker(:insert_map_bdd)
    work.parse(args)
    plateau
  end
end

