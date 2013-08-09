class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :descrip

      t.timestamps
    end
  end
end
