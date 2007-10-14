class AddOtherRace < ActiveRecord::Migration
  def self.up
    
    add_column "boxes", "player_1_id", :integer
    add_column "boxes", "update_1", :datetime
    add_column "boxes", "player_2_id", :integer
    add_column "boxes", "update_2", :datetime
    add_column "boxes", "player_3_id", :integer
    add_column "boxes", "update_3", :datetime
    add_column "boxes", "player_4_id", :integer
    add_column "boxes", "update_4", :datetime

    boxes = Box.find :all, :conditions => ["player_id IS NOT NULL"]
    boxes.each do |b|
      b.player_1_id = b.player_id
      b.update_1 = b.updated_at
      b.save
    end

    remove_column "boxes", "updated_at"
    remove_column "boxes", "player_id"
  end

  def self.down

    add_column "boxes", "updated_at", :datetime
    add_column "boxes", "player_id", :integer
    
    boxes = Box.find :all, :conditions => ["player_1_id IS NOT NULL"]
    boxes.each do |b|
      b.player_id = b.player_1_id
      b.updated_at = b.update_1
      b.save
    end

    remove_column "boxes", "player_1_id"
    remove_column "boxes", "update_1"
    remove_column "boxes", "player_2_id"
    remove_column "boxes", "update_2"
    remove_column "boxes", "player_3_id"
    remove_column "boxes", "update_3"
    remove_column "boxes", "player_4_id"
    remove_column "boxes", "update_4"
  end
end
