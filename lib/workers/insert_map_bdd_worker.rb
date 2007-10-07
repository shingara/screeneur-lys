# Put your code that runs your task inside the do_work method it will be
# run automatically in a thread. You have access to all of your rails
# models.  You also get logger and results method inside of this class
# by default.

require 'hpricot'

class InsertMapBddWorker < BackgrounDRb::Worker::RailsBase
  
  def do_work(args)
    # This method is called in it's own new thread when you
    # call new worker. args is set to :args
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
              box = Box.find_by_x_and_y_and_map_id list_x[k - 1], y, args[:map]
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

              box = Box.find_by_x_and_y_and_map_id list_x[k - 1], y, args[:map]
              play.box = box
              
              play.picture = div.get_elements_by_tag_name('img')[0].get_attribute('src')
              play.save!
              next
            end

            if div.get_attribute('onclick') =~ /infoobjet\('([^']*)','([^']*)',[']*([^']*)[']*,'([^']*)','([^']*)','([^']*)'\)/
              logger.debug 'An object is found save it'
              objet = Objet.find_or_create_by_lys_id $1
              objet.name = $2[/([^ ]+)[ ]*Pos/, 1]
              objet.box = Box.find_by_x_and_y_and_map_id list_x[k - 1], y, args[:map]
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
InsertMapBddWorker.register
