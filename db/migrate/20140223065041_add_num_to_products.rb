class AddNumToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hit_num, :integer, default: 0
    add_column :products, :reply_num, :integer, default: 0
    add_column :products, :like_num, :integer, default: 0
  end
end
