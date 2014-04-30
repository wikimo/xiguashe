class AddIcoToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :ico, :string

  end
end
