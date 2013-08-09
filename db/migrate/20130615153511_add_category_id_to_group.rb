class AddCategoryIdToGroup < ActiveRecord::Migration
  def change

  	add_column :groups, :category_id, :integer
  end
end
