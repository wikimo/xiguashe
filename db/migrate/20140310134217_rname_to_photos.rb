class RnameToPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :taobao_img, :source
    rename_column :photos, :is_main_img, :is_main
  end

end
