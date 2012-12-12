class Group < ActiveRecord::Base
	has_many :topics

	has_many :group_users, :dependent => :destroy
	
    has_many :users, :through => :group_users

	has_attached_file :icon, 
					:styles => {
									:original => "200x150>", 
							    }, 
								:url => '/attachment/:class/:month_partition/:id/:style/:basename.:extension',
								:path =>':rails_root/public/attachment/:class/:month_partition/:id/:style/:basename.:extension',
                :whiny => false
end
