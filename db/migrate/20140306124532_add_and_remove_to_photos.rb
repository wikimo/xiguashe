#encoding: utf-8
class AddAndRemoveToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :taobao_img, :string, comment: 'taobao image'
    add_column :photos, :is_main_img, :integer, comment: '是否主图: 0:否 1:是'

    remove_column :photos, :pic_file_name
    remove_column :photos, :pic_file_size 
    remove_column :photos, :pic_content_type
    remove_column :photos, :pic_updated_at
  end
end
