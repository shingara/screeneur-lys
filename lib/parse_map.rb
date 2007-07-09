module ParseMap

  class ParseMapError < Exception
  end

  # Parse the HTML for find the plateau and create All box and Type in
  # Database. Return the node plateau for create the screen
  def parse_html data
    data.gsub! /<\/br>/, '<br />'
    data.gsub! /<head.+\/head>/, ''

    html = Hpricot data
    plateau = html.get_element_by_id('plateau')
   
    raise ParseMapError if plateau.nil?
    MiddleMan.new_worker :class => :insert_map_bdd_worker, :args => plateau, :job_key => :insert_key
    plateau
  end
end

