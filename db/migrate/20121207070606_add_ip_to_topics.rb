class AddIpToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :ip, :string,:default => ''

  end
end
