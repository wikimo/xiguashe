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

ActiveRecord::Schema.define(:version => 20121207071215) do

  create_table "group_users", :force => true do |t|
    t.integer  "group_id",   :default => 0
    t.integer  "user_id",    :default => 0
    t.integer  "level",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "descrip"
    t.integer  "topic_num",       :default => 0
    t.integer  "member_num",      :default => 0
    t.integer  "orderby",         :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "icon_file_name"
    t.datetime "icon_updated_at"
    t.boolean  "state",           :default => false
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id",    :default => 0
    t.string   "username"
    t.integer  "hit_num",    :default => 0
    t.integer  "reply_num",  :default => 0
    t.integer  "state",      :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "group_id",   :default => 0
    t.string   "ip",         :default => ""
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.string   "created_ip"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
