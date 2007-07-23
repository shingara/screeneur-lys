class AddColorFontType < ActiveRecord::Migration
  def self.up
    add_column :types, 'font_color', :string
  end

  def self.down
    remove_column :types, 'font_color'
  end
end
