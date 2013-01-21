class AddAttachmentIconToUser < ActiveRecord::Migration
  def change
  	add_column :users, :icon_file_name, :string

  	add_column :users, :icon_updated_at, :datetime
  end
end
