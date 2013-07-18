class Photo < ActiveRecord::Base
	belongs_to :photoable , :polymorphic  => true
	belongs_to :topic

	has_attached_file :pic, 
		:styles => {
		    :original => "480x480>",
		    :medium => "200X",
	        :thumb => "80x80#",
        }, 
		:url => '/attachment/:class/:month_partition/:style/:id_:basename.:extension',
		:path =>':rails_root/public/attachment/:class/:month_partition/:style/:id_:basename.:extension'

	before_post_process :rename_photo
	
	private
		def rename_photo
	        extension = File.extname(pic_file_name).downcase
	        self.pic.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
	    end	
end
