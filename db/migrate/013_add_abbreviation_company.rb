class AddAbbreviationCompany < ActiveRecord::Migration
  def self.up
    add_column :compagnies, :abbreviation, :string, :limit => 3
  end

  def self.down
    remove_column :compagnies, :abbreviation
  end
end
