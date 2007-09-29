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
    html = Hpricot data
    plateau = html.search("//table[@id='plateau']")
    parse_hpricot(plateau, map)
  end

  def parse_hpricot(plateau, map)
    logger.debug "Class of HTML : #{plateau.class}"
    logger.debug "PLATEAU : #{plateau}"
    logger.debug "HTML : #{plateau}"

   
    if plateau.nil?
      logger.debug "ParseMapError Raise"
      raise ParseMapError
    end
    args = {:plateau => plateau, :map => map.id}
    logger.debug "ARGS : #{args}"
    MiddleMan.new_worker({:class => :insert_map_bdd_worker, :job_key => :insert_map_bdd})
    Thread.new do
      logger.debug "Thread start"
      work = MiddleMan.worker(:insert_map_bdd)
      work.parse(args)
    end
    plateau
  end

  def create_map (map_body, map_id)
    @map = Map.find map_id
    if map_body.class == Hpricot::Elements
      @plateau = parse_hpricot map_body, @map
      logger.debug 'parse hpricot'
    else
      @plateau = parse_html map_body, @map
      logger.debug 'parse html'
    end
    
    @screen = Screen.create
    @screen.generate_id
    
    a = render_to_string :file => "#{RAILS_ROOT}/app/views/screens/screen.haml"
    a.gsub! /src="image/, 'src="/image'
    a.gsub! /<a href[^>]+>/, ''
    a.gsub! /<\/a>/, ''
    a.gsub! /background="image/, 'background="/image'
    a.gsub! /src="template/, 'src="/template'
    
    # deport from before
    a.gsub!(/onclick=[ ]*"(.+\(.+\))"/) { |i|
      logger.debug "I before change : #{i}"
      re = "onclick=\'#{$1}\'"
      re.gsub! /infojoueur\(/, 'infojoueur(this,'
      re
    }

    @screen.save!
    @screen.create_file a
    @screen.save!
  end
end

