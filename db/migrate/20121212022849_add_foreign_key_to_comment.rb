class AddForeignKeyToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :reply_parent_id, :integer
  end
end
