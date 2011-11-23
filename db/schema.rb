# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111123175944) do

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "railroad_id"
  end

  add_index "branches", ["railroad_id"], :name => "index_branches_on_railroad_id"

  create_table "permission_roles", :force => true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  add_index "permission_roles", ["permission_id"], :name => "index_permission_roles_on_permission_id"
  add_index "permission_roles", ["role_id"], :name => "index_permission_roles_on_role_id"

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "railroads", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "north_south",           :default => false
    t.boolean  "west_south_on_right",   :default => false
    t.boolean  "eastbound_odd_numbers", :default => false
  end

  add_index "railroads", ["user_id"], :name => "index_railroads_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.text     "arrival_instructions"
  end

  add_index "sections", ["branch_id"], :name => "index_sections_on_branch_id"

  create_table "track_connections", :force => true do |t|
    t.string   "name"
    t.integer  "index"
    t.boolean  "left"
    t.boolean  "top"
    t.boolean  "center"
    t.boolean  "bottom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "track_types", :force => true do |t|
    t.string   "name"
    t.integer  "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
    t.integer  "ul_id"
    t.integer  "cl_id"
    t.integer  "ll_id"
    t.integer  "ur_id"
    t.integer  "cr_id"
    t.integer  "lr_id"
    t.integer  "track_type_id"
    t.integer  "ul_ext_id"
    t.integer  "cl_ext_id"
    t.integer  "ll_ext_id"
    t.integer  "ur_ext_id"
    t.integer  "cr_ext_id"
    t.integer  "lr_ext_id"
    t.string   "track_class"
    t.integer  "length"
  end

  add_index "tracks", ["cl_ext_id"], :name => "index_tracks_on_cl_ext_id"
  add_index "tracks", ["cl_id"], :name => "index_tracks_on_cl_id"
  add_index "tracks", ["cr_ext_id"], :name => "index_tracks_on_cr_ext_id"
  add_index "tracks", ["cr_id"], :name => "index_tracks_on_cr_id"
  add_index "tracks", ["ll_ext_id"], :name => "index_tracks_on_ll_ext_id"
  add_index "tracks", ["ll_id"], :name => "index_tracks_on_ll_id"
  add_index "tracks", ["lr_ext_id"], :name => "index_tracks_on_lr_ext_id"
  add_index "tracks", ["lr_id"], :name => "index_tracks_on_lr_id"
  add_index "tracks", ["section_id"], :name => "index_tracks_on_section_id"
  add_index "tracks", ["track_type_id"], :name => "index_tracks_on_track_type_id"
  add_index "tracks", ["ul_ext_id"], :name => "index_tracks_on_ul_ext_id"
  add_index "tracks", ["ul_id"], :name => "index_tracks_on_ul_id"
  add_index "tracks", ["ur_ext_id"], :name => "index_tracks_on_ur_ext_id"
  add_index "tracks", ["ur_id"], :name => "index_tracks_on_ur_id"

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
    t.boolean  "use_secondary_role",                      :default => false
    t.integer  "primary_role_id"
    t.integer  "secondary_role_id"
  end

  add_index "users", ["primary_role_id"], :name => "index_users_on_primary_role_id"
  add_index "users", ["secondary_role_id"], :name => "index_users_on_secondary_role_id"
  add_index "users", ["state"], :name => "index_users_on_state"

end
