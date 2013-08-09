class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      
      t.string :name

      t.text :description

      #默认为可用状态
      t.boolean :is_use, :default => true

      t.timestamps
    end
  end
end
