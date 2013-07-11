# coding: utf-8
class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :notificationable_id
      t.string :notificationable_type
      t.integer :user_id
      t.boolean :is_read, :default => 0

      t.timestamps
    end
  end
end
