class AddPolyToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :photoable_id, :integer

    add_column :photos, :photoable_type, :string

  end
end
