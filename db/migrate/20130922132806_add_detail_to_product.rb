class AddDetailToProduct < ActiveRecord::Migration
  def change
    add_column :products, :key, :string
    add_column :products, :price, :decimal, :precision => 18, :scale => 2, :default => 0.00
    add_column :products, :nick, :string
  end
end
