class CreateOthers < ActiveRecord::Migration
  def self.up
    create_table :others do |t|
      t.column :content, :text
      t.column :box_id, :integer
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :others
  end
end
