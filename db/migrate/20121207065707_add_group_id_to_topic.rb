class AddGroupIdToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :group_id, :integer, :default => 0

  end
end
