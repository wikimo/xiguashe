class AddTopicIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :topic_id, :integer
  end
end
