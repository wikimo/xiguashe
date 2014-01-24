# == Schema Information
#
# Table name: groups
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  descrip         :string(255)
#  topic_num       :integer          default(0)
#  member_num      :integer          default(0)
#  orderby         :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  icon_file_name  :string(255)
#  icon_updated_at :datetime
#  state           :boolean          default(FALSE)
#  category_id     :integer
#

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

    mount_uploader :ico, ImageUploader             


    scope :using_groups, where('state = true')

    scope :have_joined, lambda { |id| where('id != ?', id) }

    scope :order_by_topic_num_desc, order('topic_num DESC')

    scope :order_by_member_num_desc, order('member_num DESC')

    scope :order_by_updated_at_desc, order('updated_at DESC')

    scope :order_by_created_at_desc, order('created_at DESC')

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
            groups = self.using_groups.order_by_created_at_desc.paginate(:page => page, :per_page => per_page)
        end

        def order_desc_by_created_at(page = 1, per_page = 20)
            self.order_by_created_at_desc.paginate(:page => page, :per_page => per_page)
        end

        def recommend(page = 1, per_page = 20)
            self.using_groups.order_by_topic_num_desc.order_by_member_num_desc.order_by_updated_at_desc.paginate(page: page, per_page: per_page)
        end

        def search_in_cpanel(search, page = 1, per_page = 20)
            if search 
                where('name like ? ', "%#{search}%").order_desc_by_created_at(page, per_page)
            else
                order_desc_by_created_at(page, per_page)
            end
        end

        def useing_groups_except_joined(id, page = 1, per_page = 20)
            self.using_groups.have_joined(id).paginate(:page => page, :per_page => per_page)
        end

    end
end
