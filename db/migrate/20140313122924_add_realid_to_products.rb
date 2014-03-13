class AddRealidToProducts < ActiveRecord::Migration
  def change
    add_column :products, :really_id, :string
  end
end
