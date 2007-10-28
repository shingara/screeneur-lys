# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 36) do

  create_table "boxes", :force => true do |t|
    t.column "x",           :integer
    t.column "y",           :integer
    t.column "type_id",     :integer
    t.column "race_id",     :integer
    t.column "user_id",     :integer
    t.column "map_id",      :integer
    t.column "other_id",    :integer
    t.column "objet_id",    :integer
    t.column "player_1_id", :integer
    t.column "update_1",    :datetime
    t.column "player_2_id", :integer
    t.column "update_2",    :datetime
    t.column "player_3_id", :integer
    t.column "update_3",    :datetime
    t.column "player_4_id", :integer
    t.column "update_4",    :datetime
  end

  create_table "compagnies", :force => true do |t|
    t.column "name",         :string
    t.column "race_id",      :integer
    t.column "abbreviation", :string,  :limit => 3
  end

  create_table "grades", :force => true do |t|
    t.column "name",    :string
    t.column "race_id", :integer
  end

  create_table "maps", :force => true do |t|
    t.column "name", :string
    t.column "x",    :integer
    t.column "y",    :integer
  end

  create_table "objets", :force => true do |t|
    t.column "name",    :string
    t.column "lys_id",  :string
    t.column "picture", :string
  end

  create_table "others", :force => true do |t|
    t.column "content",    :text
    t.column "box_id",     :integer
    t.column "updated_at", :datetime
  end

  create_table "players", :force => true do |t|
    t.column "lys_id",         :integer
    t.column "name",           :string
    t.column "identification", :string
    t.column "compagny_id",    :integer
    t.column "weapon_id",      :integer
    t.column "level",          :integer
    t.column "box_id",         :integer
    t.column "race_id",        :integer
    t.column "grade_id",       :integer
    t.column "message",        :string
    t.column "picture",        :string
    t.column "camouflage",     :integer
    t.column "user_id",        :integer
  end

  add_index "players", ["lys_id"], :name => "index_players_on_lys_id"

  create_table "races", :force => true do |t|
    t.column "name",         :string
    t.column "abbreviation", :string,  :limit => 2
    t.column "id_lys",       :integer
  end

  create_table "screens", :force => true do |t|
    t.column "view_id", :string
    t.column "race_id", :integer
  end

  add_index "screens", ["view_id"], :name => "index_screens_on_view_id"

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "types", :force => true do |t|
    t.column "name",       :string
    t.column "font_color", :string
    t.column "path",       :string, :limit => 50
    t.column "font_map",   :string, :limit => 10
  end

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "activation_code",           :string,   :limit => 40
    t.column "activated_at",              :datetime
    t.column "player_id",                 :integer
  end

  create_table "weapons", :force => true do |t|
    t.column "name", :string
  end

end
