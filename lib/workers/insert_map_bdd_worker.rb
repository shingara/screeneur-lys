# Put your code that runs your task inside the do_work method it will be
# run automatically in a thread. You have access to all of your rails
# models.  You also get logger and results method inside of this class
# by default.

require 'hpricot'

class InsertMapBddWorker < BackgrounDRb::Worker::RailsBase
  
  def do_work(args)
    # This method is called in it's own new thread when you
    # call new worker. args is set to :args
    list_x = []
    args[:plateau].each_child_with_index do |tr, i|
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
            box.map_id = args[:map]
            box.save!
            if div.get_attribute('onclick') =~ /infojoueur\(this,'([^']*)','([^']*)','([^']*)','([^']*)','([^']*)',[']*([^']*)[']*,'([^']*)','([^']*)','([^']*)','([^']*)','([^']*)','([^']*)'\)/
              
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

            if div.get_attribute('onclick') =~ /infoobjet\('([^']*)','([^']*)',[']*([^']*)[']*,'([^']*)','([^']*)','([^']*)'\)/
              objet = Objet.find_or_create_by_lys_id $1
              objet.name = $2[/([^ ]+)[ ]*Pos/, 1]
              objet.box = box
              objet.picture = div.get_elements_by_tag_name('img')[0].get_attribute('src')
              objet.save!
            end
          end
        end unless td.nil?
      end
    end
  end

end
InsertMapBddWorker.register
