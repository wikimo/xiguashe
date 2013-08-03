class Group < ActiveRecord::Base
  
	  self.per_page = 30
	  
    belongs_to :category

    has_many :topics

	  has_many :group_users, :dependent => :destroy
	
    has_many :users, :through => :group_users
    
    

	  has_attached_file :icon, 
					:styles => {
                                    :thumb  => "80X80>",
									:original => "180x180>",
							    }, 
								:url => '/attachment/:class/:month_partition/:id/:style/:basename.:extension',
								:path =>':rails_root/public/attachment/:class/:month_partition/:id/:style/:basename.:extension',
                :whiny => false



    def group_can_use
        groups = Group.find(:all,:conditions =>['state=?',true])
    end

    def creater
        gu = GroupUser.find(:all, :conditions => ['group_id = ? and level = ?', self.id, 2], :order => 'created_at DESC')

        user = User.find_all_by_id(gu.map(&:user_id)).first
    end


    def members
    	gu = GroupUser.find(:all, :conditions => ['group_id = ?', self.id], :order => 'created_at DESC', :limit => 4)
    	
    	users =  User.find_all_by_id(gu.map(&:user_id))
    end

    def activers
        
    end



    def applyers
    	gu = GroupUser.find(:all, :conditions => ['group_id = ? and status = ?', self.id, 1], :order => 'updated_at DESC')

    	users = User.find_all_by_id(gu.map(&:user_id))
    end

    def managers
        gu = GroupUser.find(:all, :conditions => ['group_id = ? and level = ?', self.id, 1], :order => 'updated_at ASC')

        users = User.find_all_by_id(gu.map(&:user_id))
    end

     class << self

        def last_groups(page = 1, per_page = 20)
            groups = Group.order('created_at DESC').paginate(:page => page, :per_page => per_page)
        end

        def order_desc_by_created_at(page = 1, per_page = 20)
            Group.order("created_at DESC").paginate(:page => page, :per_page => per_page)
        end
    end
end
