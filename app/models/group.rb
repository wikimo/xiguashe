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


    def members
    	gu = GroupUser.find(:all, :conditions => ['group_id = ?', self.id], :order => 'created_at ASC')
    	
    	users =  User.find_all_by_id(gu.map(&:user_id))
    end
end
