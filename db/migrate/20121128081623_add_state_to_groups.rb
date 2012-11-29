class AddStateToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :state, :boolean,:default => false

  end
end
