class RemoveSourceToPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :source
  end

  def down
    add_column :photos, :source, :string
  end
end
