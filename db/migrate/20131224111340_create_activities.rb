class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string   :title
      t.string   :content
      t.integer  :hit_num, default: 0
      t.integer  :like_num, default: 0
      t.integer  :reply_num, default: 0
      t.integer  :status, default:1
      t.string   :from_url
      t.string   :province
      t.string   :city
      t.string   :area
      t.integer  :user_id
      t.string   :icon_file_name
      t.datetime :icon_updated_at

      t.timestamps
    end
  end
end
