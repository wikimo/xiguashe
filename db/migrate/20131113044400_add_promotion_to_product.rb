class AddPromotionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :promo_price, :decimal, :precision => 18, :scale => 2, :default => 0.00

  end
end
