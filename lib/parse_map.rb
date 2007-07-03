module ParseMap

  class ParseMapError < Exception
  end

  # Parse the HTML for find the plateau and create All box and Type in
  # Database. Return the node plateau for create the screen
  def parse_html data
    data.gsub! /<\/br>/, '<br />'
    html = Hpricot(data)
    plateau = html.get_element_by_id('plateau')
   
    raise ParseMapError if plateau.nil?

    list_x = []

    plateau.each_child_with_index do |tr, i|
      next unless tr.elem?
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
          if div.get_attribute('id') == 'p_tdy' 
            y = div.to_plain_text
          else
            t = Type.find_or_create_by_name div.get_attribute('background')
            box = Box.find_or_create_by_x_and_y list_x[k - 1], y
            box.type = t
            box.save!
            if div.get_attribute('onclick') =~ /infojoueur\("([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)",["]*([^"]*)["]*,"([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)"\)/
              
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
              play.box = box
              play.picture = div.get_elements_by_tag_name('img')[0].get_attribute('src')
              play.save!
            
            end
          end
        end unless td.nil?
      end
    end
    plateau
  end
end

