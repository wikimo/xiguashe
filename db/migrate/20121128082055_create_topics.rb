class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.integer :user_id ,:default => 0
      t.string :username
      t.integer :hit_num , :default => 0
      t.integer :reply_num, :default => 0
      t.integer :state, :default => 0

      t.timestamps
    end
  end
end
