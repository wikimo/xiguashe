class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.integer :group_id , :default => 0
      t.integer :user_id , :default => 0
      #0:common;1:admin;2:creater
      t.integer :level, :default =>0

      t.timestamps
    end
  end
end
