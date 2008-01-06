# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 36) do

  create_table "boxes", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "type_id"
    t.integer  "race_id"
    t.integer  "user_id"
    t.integer  "map_id"
    t.integer  "other_id"
    t.integer  "objet_id"
    t.integer  "player_1_id"
    t.datetime "update_1"
    t.integer  "player_2_id"
    t.datetime "update_2"
    t.integer  "player_3_id"
    t.datetime "update_3"
    t.integer  "player_4_id"
    t.datetime "update_4"
  end

  create_table "compagnies", :force => true do |t|
    t.string  "name"
    t.integer "race_id"
    t.string  "abbreviation", :limit => 3
  end

  create_table "grades", :force => true do |t|
    t.string  "name"
    t.integer "race_id"
  end

  create_table "maps", :force => true do |t|
    t.string  "name"
    t.integer "x"
    t.integer "y"
  end

  create_table "objets", :force => true do |t|
    t.string "name"
    t.string "lys_id"
    t.string "picture"
  end

  create_table "others", :force => true do |t|
    t.text     "content"
    t.integer  "box_id"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer "lys_id"
    t.string  "name"
    t.string  "identification"
    t.integer "compagny_id"
    t.integer "weapon_id"
    t.integer "level"
    t.integer "box_id"
    t.integer "race_id"
    t.integer "grade_id"
    t.string  "message"
    t.string  "picture"
    t.integer "camouflage"
    t.integer "user_id"
  end

  add_index "players", ["lys_id"], :name => "index_players_on_lys_id"

  create_table "races", :force => true do |t|
    t.string  "name"
    t.string  "abbreviation", :limit => 2
    t.integer "id_lys"
  end

  create_table "screens", :force => true do |t|
    t.string  "view_id"
    t.integer "race_id"
  end

  add_index "screens", ["view_id"], :name => "index_screens_on_view_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "types", :force => true do |t|
    t.string "name"
    t.string "font_color"
    t.string "path",       :limit => 50
    t.string "font_map",   :limit => 10
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.integer  "player_id"
  end

  create_table "weapons", :force => true do |t|
    t.string "name"
  end

end
