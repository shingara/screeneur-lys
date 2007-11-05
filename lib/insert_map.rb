#! /usr/env ruby

require 'RMagick'
include Magick
require 'parse_map'

module InsertMap

  MAINTENANCE_PAGE = "#{RAILS_ROOT}/public/maintenance.html"

  # Get the map with the name and define all Box for this map
  def get_map
    #Create list of Pixel like base
    type_list = {}
    Type.find(:all, :conditions => ['font_map IS NOT NULL']).each do |t|
      type_list[Pixel.from_color(t.font_map)] = t
    end

    #Get all Pixel of image
    img = Net::HTTP.get_response 'conquest-lys.net', "/data/_map/#{name}.png"
    if "404" == img.code
      hide_maintenance
      raise ParseMap::ParseMapError  
    end
    
    f = File.open "#{RAILS_ROOT}/public/image/map/#{name}.png", 'wb'
    f.write img.body
    f.close

    pic = ImageList.new "#{RAILS_ROOT}/public/image/map/#{name}.png"

    pix_list = pic.get_pixels(0,0,y,x)

    index = 0

    # Iterate on all line
    y.times do |l|

      #iterate on all column
      x.times do |c|
        b = Box.new({
          :x => c + 1,
          :y => l + 1
        })
        b.map = self

        begin
          b.type = type_list.fetch pix_list[index]
          index += 1
          b.save!
          print '.'
        rescue IndexError
          # exception if pix is not in type already save
          logger.warn "pixel doesn't exist in BDD : #{c}, #{l}"
        end
      end
    end
  end

  # Create the maintenance page and put it in /public/maintenance.html
  def show_maintenance
    f = File.open MAINTENANCE_PAGE, 'wb'
    haml_maintenance = Haml::Engine.new File.read("#{RAILS_ROOT}/public/maintenance.haml")
    f.write haml_maintenance.to_html
    f.close
  end

  # Delete the file /public/maintenance.html
  def hide_maintenance
    File.delete MAINTENANCE_PAGE
  end

end

