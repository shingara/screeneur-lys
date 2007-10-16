module ParseMap

  class ParseMapError < Exception
  end

  # Parse the HTML for find the plateau and create All box and Type in
  # Database. You need send the Map Object in parameters
  #
  # Return the node plateau for create the screen
  def parse_html(data, race_id=nil)
    data.gsub! /<\/br>/, '<br />'
    data.gsub! /<head.+\/head>/, ''
    html = Hpricot data
    race_id = html.search("//input[@name='IDR']")[0].get_attribute('value') if race_id.nil?
    map_name = html.search("//input[@name='mission']")[0].get_attribute('value')
    plateau = html.search("//table[@id='plateau']")
    parse_hpricot(plateau, map_name, race_id)
  end


  # Create a map with a Hpricot::Element where the IDM is
  # Return a Map model create and save
  def create_map_model(plateau, map_name)
      map_idm = plateau.search("//input[@name='IDM']")[0].get_attribute('value')
      http = Net::HTTP.new('www.conquest-lys.net')
      map_x_value = http.get "/index.php?mod=data&t=mission&i=#{map_idm}&c=Taillex"
      map_y_value = http.get "/index.php?mod=data&t=mission&i=#{map_idm}&c=Tailley"
      Map.create({:name => map_name, :x => map_x_value.body, :y => map_y_value.body})
  end

  def parse_hpricot(plateau, map_name, race_id)
    
    logger.debug "Class of HTML : #{plateau.class}"
    logger.debug "PLATEAU : #{plateau}"
    logger.debug "HTML : #{plateau}"

    @map = Map.find_by_name map_name
    @map = create_map_model(plateau, map_name) if @map.nil?
    @race = Race.find_by_id_lys race_id
   
    if plateau.nil?
      logger.debug "ParseMapError Raise"
      raise ParseMapError
    end
    
    args = {:plateau => plateau, :map => @map.id, :race => race_id}
    
    #parse args
    MiddleMan.new_worker({:class => :insert_map_bdd_worker, :job_key => :insert_map_bdd})
    Thread.new do
      logger.debug "Thread start"
      work = MiddleMan.worker(:insert_map_bdd)
      work.parse(args)
    end
    
    plateau
  end

  def create_map (map_body, map_name=nil, race_id=nil)
    if map_body.class == Hpricot::Elements
      @plateau = parse_hpricot map_body, map_name, race_id
      logger.debug 'parse hpricot'
    else
      @plateau = parse_html map_body, race_id
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

