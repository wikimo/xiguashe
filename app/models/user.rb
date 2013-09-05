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

	has_many :mentions, :foreign_key => :mention_id, :class_name => "Notification", :dependent => :destroy

	validates :password,:length  => {:minimum  => 6,:maximum  => 15},:if => :password_present?
	#validate :old_password_ok ,:on => :update#更新密码是严重原始密码
	validates_confirmation_of :password,:if => :password_present?

	has_attached_file :icon, 
					  :styles => {
						            :thumb  => "50X50>",
						            :medium => '80X80>',
									      :original => "120x120>"
							    }, 
					  :url => '/attachment/:class/:month_partition/:id/:style/:basename.:extension',
					  :path =>':rails_root/public/attachment/:class/:month_partition/:id/:style/:basename.:extension',
                :whiny => false

    before_create { generate_token(:auth_token) }

    scope :order_by_created_at_desc, order('created_at DESC')
	
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
	
	def unread_notification_count
    	unread_notifications_count = self.notifications.except_mention.unread_notifications.count + self.mentions.unread_notifications.count
  	end

	def groups
		gu = GroupUser.find(:all,:conditions => ["user_id = ?",self.id])
    	
        Group.find(:all,:conditions => ["id in (?)",gu.map(&:group_id)],:order => 'topic_num DESC')
  	end

	def notices(page = 1, per_page = 20)
	   Notification.where("mention_id = ? or (user_id = ? and mention_id is null) ",self.id ,self.id).order('created_at desc').paginate(:page => page,:per_page => per_page )
	end

	
	def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!
	  UserMailer.password_reset(self).deliver
	end

	def last_ten_user
		self.where('id != ?', self.id).order_by_created_at_desc.limit(10)
	end

  	class << self
	  	def authenticate(username_or_email,password)
			user = User.find_by_username(username_or_email) || User.find_by_email(username_or_email)

			if user && user.hashed_password ==  Digest::SHA256.hexdigest(password + user.salt)
			  return user
			end

			false
		end


		def order_desc_by_created_at(page = 1, per_page = 20)
			self.order("created_at DESC").paginate(:page => page, :per_page => per_page)
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

	    def generate_token(column)
	  	    begin
	  	      self[column] = SecureRandom.urlsafe_base64
	  	    end while User.exists?(column => self[column])
  	  	end


	   
end