class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :descrip
      t.string :url
      t.string :img
      t.integer :user_id
      t.string :source

      t.timestamps
    end
  end
end
