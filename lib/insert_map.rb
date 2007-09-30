#! /usr/env ruby

require 'RMagick'
include Magick

module InsertMap

  class << self
    def get (map_name)
      #Create list of Pixel like base
      type_list = {}
      Type.find(:all, :conditions => ['font_map IS NOT NULL']).each do |t|
        type_list[Pixel.from_color(t.font_map)] = t
      end

      #Get all Pixel of image
      map_name = 'Gaia'
      pic = ImageList.new "lib/#{map_name}.png"

      map = Map.create! :name => map_name

      pix_list = pic.get_pixels(0,0,200,200)

      index = 0

      # Iterate on all line
      200.times do |l|

        #iterate on all column
        200.times do |c|
          b = Box.new({
            :x => c + 1,
            :y => l + 1
          })
          b.map = map

          begin
            b.type = type_list.fetch pix_list[index]
            index += 1
            b.save!
          rescue IndexError
            # exception if pix is not in type already save
            logger.warn "pixel doesn't exist in BDD : #{p}, #{i}"
          end
        end
      end
    end
  end
end

