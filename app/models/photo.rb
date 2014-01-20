# == Schema Information
#
# Table name: photos
#
#  id               :integer          not null, primary key
#  descrip          :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pic_file_name    :string(255)
#  pic_content_type :string(255)
#  pic_file_size    :integer
#  pic_updated_at   :datetime
#  photoable_id     :integer
#  photoable_type   :string(255)
#  user_id          :integer
#

class Photo < ActiveRecord::Base
    belongs_to :photoable , :polymorphic  => true


    has_attached_file :pic, 
            :styles => {
                :original => "480x480>",
                :medium => "200X",
            :thumb => "80x80#",
    }, 
            :url => '/attachment/:class/:month_partition/:style/:id_:basename.:extension',
            :path =>':rails_root/public/attachment/:class/:month_partition/:style/:id_:basename.:extension'

    mount_uploader :path, ImageUploader        

    before_post_process :rename_photo
    
    private
            def rename_photo
            extension = File.extname(pic_file_name).downcase
            self.pic.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
        end        
end
