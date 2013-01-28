class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|

    	t.integer :user_id
    	t.integer :comment_id
    	t.integer :is_read, :default => 0


      	t.timestamps
    end
  end
end
