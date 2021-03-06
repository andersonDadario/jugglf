# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100402080025) do

  create_table "achievements", :force => true do |t|
    t.integer "armory_id",   :null => false
    t.integer "category_id", :null => false
    t.string  "title"
    t.string  "icon"
  end

  add_index "achievements", ["armory_id"], :name => "index_achievements_on_armory_id", :unique => true
  add_index "achievements", ["category_id"], :name => "index_achievements_on_category_id"

  create_table "attendees", :force => true do |t|
    t.integer "member_id"
    t.integer "raid_id"
    t.float   "attendance", :null => false
  end

  add_index "attendees", ["member_id", "raid_id"], :name => "index_attendees_on_member_id_and_raid_id", :unique => true
  add_index "attendees", ["member_id"], :name => "index_attendees_on_member_id"
  add_index "attendees", ["raid_id"], :name => "index_attendees_on_raid_id"

  create_table "bosses", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "bosses", ["name"], :name => "index_bosses_on_name"

  create_table "completed_achievements", :force => true do |t|
    t.integer "achievement_id"
    t.integer "member_id"
    t.date    "completed_on"
  end

  add_index "completed_achievements", ["achievement_id", "member_id"], :name => "index_completed_achievements_on_achievement_id_and_member_id", :unique => true
  add_index "completed_achievements", ["achievement_id"], :name => "index_completed_achievements_on_achievement_id"
  add_index "completed_achievements", ["member_id"], :name => "index_completed_achievements_on_member_id"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.string   "icon"
    t.integer  "level",           :default => 0
    t.string   "slot"
    t.boolean  "heroic",          :default => false, :null => false
    t.boolean  "authentic",       :default => false, :null => false
    t.integer  "loots_count",     :default => 0,     :null => false
    t.integer  "wishlists_count", :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["name"], :name => "index_items_on_name"

  create_table "live_attendees", :force => true do |t|
    t.integer  "live_raid_id"
    t.string   "member_name",                         :null => false
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.boolean  "active",           :default => false, :null => false
    t.integer  "minutes_attended", :default => 0,     :null => false
  end

  add_index "live_attendees", ["live_raid_id"], :name => "index_live_attendees_on_live_raid_id"

  create_table "live_loots", :force => true do |t|
    t.integer "live_raid_id"
    t.integer "item_id"
    t.integer "member_id"
    t.string  "loot_type"
  end

  add_index "live_loots", ["item_id"], :name => "index_live_loots_on_item_id"
  add_index "live_loots", ["live_raid_id"], :name => "index_live_loots_on_live_raid_id"
  add_index "live_loots", ["member_id"], :name => "index_live_loots_on_member_id"

  create_table "live_raids", :force => true do |t|
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.integer  "live_attendees_count", :default => 0, :null => false
    t.integer  "live_loots_count",     :default => 0, :null => false
  end

  create_table "loot_tables", :force => true do |t|
    t.integer "object_id"
    t.string  "object_type"
    t.integer "parent_id"
    t.string  "note"
  end

  add_index "loot_tables", ["object_id"], :name => "index_loot_tables_on_object_id"
  add_index "loot_tables", ["parent_id"], :name => "index_loot_tables_on_parent_id"

  create_table "loots", :force => true do |t|
    t.integer  "item_id"
    t.integer  "raid_id"
    t.integer  "member_id"
    t.float    "price"
    t.date     "purchased_on"
    t.boolean  "best_in_slot", :default => false, :null => false
    t.boolean  "situational",  :default => false, :null => false
    t.boolean  "rot",          :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loots", ["item_id"], :name => "index_loots_on_item_id"
  add_index "loots", ["member_id"], :name => "index_loots_on_member_id"
  add_index "loots", ["purchased_on"], :name => "index_loots_on_purchased_on"
  add_index "loots", ["raid_id"], :name => "index_loots_on_raid_id"

  create_table "member_ranks", :force => true do |t|
    t.string "name",   :null => false
    t.string "prefix"
    t.string "suffix"
  end

  create_table "members", :force => true do |t|
    t.string   "name",                                  :null => false
    t.integer  "user_id"
    t.integer  "rank_id"
    t.boolean  "active",              :default => true
    t.date     "first_raid"
    t.date     "last_raid"
    t.string   "wow_class"
    t.float    "lf",                  :default => 0.0,  :null => false
    t.float    "sitlf",               :default => 0.0,  :null => false
    t.float    "bislf",               :default => 0.0,  :null => false
    t.float    "attendance_30",       :default => 0.0,  :null => false
    t.float    "attendance_90",       :default => 0.0,  :null => false
    t.float    "attendance_lifetime", :default => 0.0,  :null => false
    t.integer  "raids_count",         :default => 0,    :null => false
    t.integer  "loots_count",         :default => 0,    :null => false
    t.integer  "wishlists_count",     :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["active"], :name => "index_members_on_active"
  add_index "members", ["rank_id"], :name => "index_members_on_rank_id"
  add_index "members", ["user_id"], :name => "index_members_on_user_id"

  create_table "punishments", :force => true do |t|
    t.integer  "member_id",                   :null => false
    t.string   "reason",                      :null => false
    t.date     "expires_on",                  :null => false
    t.float    "value",      :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "punishments", ["member_id"], :name => "index_punishments_on_member_id"

  create_table "raids", :force => true do |t|
    t.date     "date",                           :null => false
    t.string   "note"
    t.integer  "attendees_count", :default => 0, :null => false
    t.integer  "loots_count",     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raids", ["date"], :name => "index_raids_on_date"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "wishlists", :force => true do |t|
    t.integer  "item_id"
    t.integer  "member_id"
    t.string   "priority",   :default => "normal", :null => false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishlists", ["item_id"], :name => "index_wishlists_on_item_id"
  add_index "wishlists", ["member_id"], :name => "index_wishlists_on_member_id"

  create_table "zones", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "zones", ["name"], :name => "index_zones_on_name"

end
