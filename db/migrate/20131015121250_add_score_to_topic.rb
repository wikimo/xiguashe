class AddScoreToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :score, :decimal, :precision => 18, :scale => 5, :default => 0
  end
end
