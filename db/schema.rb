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

ActiveRecord::Schema.define(:version => 20131224111340) do

  create_table "activities", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "hit_num",             :default => 0
    t.integer  "like_num",            :default => 0
    t.integer  "reply_num",           :default => 0
    t.integer  "status",              :default => 1
    t.string   "from_url"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "activity_created_at"
    t.string   "icon_file_name"
    t.datetime "icon_updated_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_use",      :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "reply_parent_id"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "group_users", :force => true do |t|
    t.integer  "group_id",   :default => 0
    t.integer  "user_id",    :default => 0
    t.integer  "level",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status",     :default => 0
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
    t.integer  "category_id"
  end

  create_table "likes", :force => true do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "notificationable_id"
    t.string   "notificationable_type"
    t.integer  "user_id"
    t.boolean  "is_read",               :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "mention_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "descrip"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.integer  "photoable_id"
    t.string   "photoable_type"
    t.integer  "user_id"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "descrip"
    t.string   "url"
    t.string   "img"
    t.integer  "user_id"
    t.string   "source"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "topic_id"
    t.string   "key"
    t.decimal  "price",       :precision => 18, :scale => 2, :default => 0.0
    t.string   "nick"
    t.decimal  "promo_price", :precision => 18, :scale => 2, :default => 0.0
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id",                                   :default => 0
    t.string   "username"
    t.integer  "hit_num",                                   :default => 0
    t.integer  "reply_num",                                 :default => 0
    t.integer  "state",                                     :default => 0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "group_id",                                  :default => 0
    t.string   "ip",                                        :default => ""
    t.integer  "like_num",                                  :default => 0,   :null => false
    t.integer  "types",                                     :default => 1
    t.decimal  "score",      :precision => 18, :scale => 5, :default => 0.0
  end

  create_table "user_relations", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_relations", ["followed_id"], :name => "index_user_relations_on_followed_id"
  add_index "user_relations", ["follower_id", "followed_id"], :name => "index_user_relations_on_follower_id_and_followed_id", :unique => true
  add_index "user_relations", ["follower_id"], :name => "index_user_relations_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.string   "created_ip"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "icon_file_name"
    t.datetime "icon_updated_at"
    t.string   "nickname"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
