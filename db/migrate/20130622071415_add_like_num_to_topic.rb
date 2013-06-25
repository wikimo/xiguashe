class AddLikeNumToTopic < ActiveRecord::Migration
  def change
  	add_column :topics, :like_num, :integer, :default => 0
  end
end
