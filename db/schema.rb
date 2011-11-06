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

ActiveRecord::Schema.define(:version => 20111106160101) do

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
  end

  add_index "railroads", ["user_id"], :name => "index_railroads_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
