class CreateWeapons < ActiveRecord::Migration
  def self.up
    puts ActiveRecord::Base.connection.class
    create_table :weapons do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :weapons
  end
end
