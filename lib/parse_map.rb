module ParseMap

  class ParseMapError < Exception
  end

  # Parse the HTML for find the plateau and create All box and Type in
  # Database. You need send the Map Object in parameters
  #
  # Return the node plateau for create the screen
  def parse_html(data, race_id=nil, map_name=nil)
    data.gsub! /<\/br>/, '<br />'
    data.gsub! /<head.+\/head>/, ''
    html = Hpricot data
    begin
      race_id = html.search("//input[@name='IDR']")[0].get_attribute('value') if race_id.nil?
      map_name = html.search("//input[@name='mission']")[0].get_attribute('value') if map_name.nil?
      plateau = html.search("//table[@id='plateau']")
    rescue NoMethodError
      raise ParseMapError
    end
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
    
    @map = Map.find_by_name map_name
    @map = create_map_model(plateau, map_name) if @map.nil?
    @race = Race.find_by_id_lys race_id
   
    if plateau.nil?
      raise ParseMapError
    end
    
    args = {:plateau => plateau, :map => @map.id, :race => race_id}
    
    parse args
    #MiddleMan.send_request(:worker => :insert_map_bdd, :worker_method => :parse ,:data => args)
    
    [plateau, race_id]
  end

  def create_map (map_body, map_name=nil, race_id=nil)
    if map_body.class == Hpricot::Elements
      @plateau, race_id = parse_hpricot map_body, map_name, race_id
    else
      @plateau, race_id = parse_html map_body, race_id
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
      re = "onclick=\'#{$1}\'"
      re.gsub! /infojoueur\(/, 'infojoueur(this,'
      re
    }

    @screen.race_id = race_id

    @screen.save!
    @screen.create_file a
    @screen.save!
  end
  
  def box_find(race_id, x, y, map_id)
    eval "Box#{race_id}.find_by_x_and_y_and_map_id #{x}, #{y}, #{map_id}"
  end

  # Parse the map like a Hpricot::Element
  # and save into BDD
  def parse(args)

    logger.debug 'parse into BackgroundRB start'

    list_x = []
    logger.debug "nb TR : #{args[:plateau].search("//tr").size}"
    args[:plateau].search("//tr").each_with_index do |tr, i|
      logger.debug "A child TR of Plateau"
      next unless tr.elem?

      # Create a list of X information
      if tr.get_attribute('id') == 'p_tdx'
        tr.children_of_type('td').each do |td|
          td.children_of_type('div').each do |div|
             list_x << div.to_plain_text
          end
        end
      else
        td = tr.children_of_type('td')
        y = 0
        td.each_with_index do |div, k|
          logger.debug "A child TD of Plateau"
          if div.get_attribute('id') == 'p_tdy' 
            y = div.to_plain_text
          else
            # It's a PS or a Town
            unless div.get_attribute('bgcolor').nil?
              logger.debug 'A PS or a town is found save it'
              box = box_find args[:race], list_x[k - 1], y, args[:map]
              other = Other.find_or_create_by_box_id box.id
              logger.debug "div : #{div.to_s}"
              other.content = div.to_s
              other.save!
              next
            end
           
            # It's a player*
            if div.get_attribute('onclick') =~ /infojoueur\("([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)",["]*([^"]*)["]*,"([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)"\)/
              
              logger.debug 'A perso is found save it'
            
              play = Player.find_or_create_by_lys_id $1
              play.name = $2

              # Parse identification for know the Race
              race = Race.find_or_create_by_abbreviation $5[0,1]
              play.race = race
             
              grade = Grade.find_or_create_by_name $3
              grade.race = race
              grade.save!
              
              play.grade = grade
              
              play.level = $4
              play.identification = $5
              
              #play.cible = $6
              
              weapon = Weapon.find_or_create_by_name $7
              weapon.race = race
              weapon.save!
              
              play.weapon = weapon
             
              # 1 if camouflé
              play.camouflage = $8
              #play.precision = $9 => it's useless to log it
              play.message = $10
              #play.Idj = $11

            
              compagny = Compagny.find_or_create_by_abbreviation $5[/-.+-/][1..-2]
              compagny.race = race
              compagny.save!

              play.compagny = compagny

              
              play.picture = div.get_elements_by_tag_name('img')[0].get_attribute('src')
              play.save!
              
              box = box_find args[:race], list_x[k - 1], y, args[:map]
              box.player = play
              box.save

              next
            end

            if div.get_attribute('onclick') =~ /infoobjet\('([^']*)','([^']*)',[']*([^']*)[']*,'([^']*)','([^']*)','([^']*)'\)/
              logger.debug 'An object is found save it'
              objet = Objet.find_or_create_by_lys_id $1
              objet.name = $2[/([^ ]+)[ ]*Pos/, 1]
              objet.box = box_find args[:race], list_x[k - 1], y, args[:map]
              objet.picture = div.get_elements_by_tag_name('img')[0].get_attribute('src')
              objet.save!
              box.save!
              next
            end
          end
        end unless td.nil?
      end
    end
  end
  
end

