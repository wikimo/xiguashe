class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :descrip
      t.string :icon
      t.integer :topic_num, :default => 0
      t.integer :member_num, :default => 0
      t.integer :orderby, :default => 0

      t.timestamps
    end
  end
end
