class Comment < ActiveRecord::Base

	belongs_to :commentable, :polymorphic => true

	belongs_to :user

	belongs_to :parent, :class_name => "Comment"

	has_many   :replies,  :class_name => "Comment", :foreign_key => "reply_parent_id"


	has_many :notifications, :as => :notificationable, :dependent => :destroy

	scope :order_desc_by_created_at, order("created_at desc")

	after_create :send_comment_notification

	def send_comment_notification
		if self.commentable_type != nil
			if self.user != self.commentable.user
				Notification.create(:user => self.commentable.user, :notificationable => self)
			end
		end
	end
	
end
