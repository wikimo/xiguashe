class AddMentionIdToNotification < ActiveRecord::Migration
  def change

  	add_column :notifications, :mention_id, :integer
  end
end
