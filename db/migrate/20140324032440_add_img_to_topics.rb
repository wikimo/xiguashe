class AddImgToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :img, :string
  end
end
