class AddIndexToBoxes < ActiveRecord::Migration
  def self.up
    add_index :boxes, :race_id
    add_index :boxes, :user_id
    add_index :boxes, :other_id
    add_index :boxes, :objet_id
    add_index :boxes, :player_1_id
    add_index :boxes, :update_1
    add_index :boxes, :player_2_id
    add_index :boxes, :update_2
    add_index :boxes, :player_3_id
    add_index :boxes, :update_3
    add_index :boxes, :player_4_id
    add_index :boxes, :update_4
    add_index :compagnies, :race_id
    add_index :grades, :race_id
    add_index :objets, :lys_id
    add_index :others, :box_id 
    add_index :players, :lys_id
    add_index :players, :weapon_id
    add_index :players, :box_id
    add_index :players, :race_id
    add_index :players, :grade_id
    add_index :players, :user_id
    add_index :screens, :view_id 
    add_index :screens, :race_id 
    add_index :users, :player_id
  end

  def self.down
    remove_index :boxes, :race_id
    remove_index :boxes, :user_id
    remove_index :boxes, :other_id
    remove_index :boxes, :objet_id
    remove_index :boxes, :player_1_id
    remove_index :boxes, :update_1
    remove_index :boxes, :player_2_id
    remove_index :boxes, :update_2
    remove_index :boxes, :player_3_id
    remove_index :boxes, :update_3
    remove_index :boxes, :player_4_id
    remove_index :boxes, :update_5
  end
end
