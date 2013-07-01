class Group < ActiveRecord::Base
	
    belongs_to :category

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

    def last_groups
        groups = Group.find(:all, :order => 'created_at DESC')
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
        def active_groups
            gs = Group.find_by_sql("select  group_id, count(id) as num from (select t.*, DATE_SUB(CURRENT_DATE,INTERVAL 7 DAY) as dd, 
                CURRENT_DATE as cc from topics t where t.created_at between DATE_SUB(CURRENT_DATE,INTERVAL 7 DAY) and CURRENT_DATE) as t group by group_id order by num desc limit 5")
            
            groups = Group.find_all_by_id(gs.map(&:group_id))

        end
    end
end
