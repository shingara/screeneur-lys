class ObjetIdInBox < ActiveRecord::Migration
  def self.up
    add_column :boxes, :objet_id, :integer
    Objet.find(:all).each do |o|
      box_tmp = Box.find o.box_id
      box_tmp.objet_id = o.id
      box_tmp.save!
    end
    remove_column :objets, :box_id
  end

  def self.down
    add_column :objets, :box_id, :integer
    Box.transaction do
      Box.find(:all).each do |b|
        objet_tmp = Objet.find b.objet_id
        objet_tmp.box_id = b.id
        objet_tmp.save!
      end
    end
    remove_column :boxes, :objet_id
  end
end
