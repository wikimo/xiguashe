class AddIndexToPhotos < ActiveRecord::Migration
  def change
    add_index :photos, [:photoable_id, :photoable_type], name: "index_photos_on_photoable_id_and_photoable_type"
  end
end
