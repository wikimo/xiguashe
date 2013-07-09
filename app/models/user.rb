# encoding: utf-8
class User < ActiveRecord::Base
	self.per_page = 15

	attr_accessor :old_password 

	has_many :group_users, :dependent => :destroy
	has_many :groups,      :through => :group_users
	has_many :topics,      :dependent => :destroy
	has_many :comments,    :dependent => :destroy
	has_many :likes,       :dependent => :destroy

	#follower followed
	has_many :user_relations, :foreign_key => "follower_id",
	                       :dependent => :destroy

	has_many :following, :through => :user_relations, :source => :followed

	has_many :reverse_user_relations, :foreign_key => "followed_id",
	                               :class_name => "UserRelation",
	                               :dependent => :destroy
	has_many :followers, :through => :reverse_user_relations, :source => :follower

	has_many :notifications, :dependent => :destroy

	validates :password,:length  => {:minimum  => 6,:maximum  => 15},:if => :password_present?
	#validate :old_password_ok ,:on => :update#更新密码是严重原始密码
	validates_confirmation_of :password,:if => :password_present?

	has_attached_file :icon, 
					  :styles => {
						            :thumb  => "50X50>",
									:original => "200x150>", 
							    }, 
					  :url => '/attachment/:class/:month_partition/:id/:style/:basename.:extension',
					  :path =>':rails_root/public/attachment/:class/:month_partition/:id/:style/:basename.:extension',
                :whiny => false
	
	def password
	    @password
	end

	def password=(pass)
		return unless pass
		@password =  pass
		generate_password pass
	end

	def following?(followed)
		user_relations.find_by_followed_id(followed)
	end

	def follow!(followed)
		user_relations.create!(:followed_id => followed.id) if followed.id != self.id
	end

	def unfollow!(followed)
		user_relations.find_by_followed_id(followed).destroy
	end

	def is_admin?
		Settings.admin_emails.include?(self.email)
	end

	def like(likeable)
		Like.where(:likeable_id => likeable.id, :likeable_type => likeable.class, :user_id => self.id).first_or_create
	end

	def unlike(likeable)
		like = Like.where(:likeable_id => likeable.id, :likeable_type => likeable.class, :user_id => self.id).first
		like.destroy
	end

	def groups
		gu = GroupUser.find(:all,:conditions => ["user_id = ?",self.id])
    	
        Group.find(:all,:conditions => ["id in (?)",gu.map(&:group_id)],:order => 'topic_num DESC')
    end

    class << self
		def authenticate(username_or_email,password)
			user = User.find_by_username(username_or_email) || User.find_by_email(username_or_email)

			if user && user.hashed_password ==  Digest::SHA256.hexdigest(password + user.salt)
			  return user
			end

			false
		end


		def active_user_for_group
			
		end
	end	
  	

	private
	    def generate_password(pass)
	      salt = Array.new(10){rand(1024).to_s(36)}.join
	      self.salt, self.hashed_password = salt,Digest::SHA256.hexdigest(pass+salt)
	    end

	    def password_present?
	      !password.nil? && password.size > 0
	    end

	    def old_password_ok
	    	errors.add(:old_password, "不正确！") if !User.authenticate(email,old_password)
	    end

	  
end
