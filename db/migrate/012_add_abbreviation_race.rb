class AddAbbreviationRace < ActiveRecord::Migration
  def self.up
    add_column :races, :abbreviation, :string, :limit => 2
  end

  def self.down
    remove_column :races, :abbreviation
  end
end
