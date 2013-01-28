class Comment < ActiveRecord::Base

	belongs_to :commentable, :polymorphic => true

	belongs_to :user

	belongs_to :parent, :class_name => "Comment"

	has_many   :replies,  :class_name => "Comment", :foreign_key => "reply_parent_id"

	has_many   :notifications, :dependent => :delete_all


	after_create :send_notification_comment

	def send_notification_comment
		
		if self.user != self.commentable.user
			Notification.create!(:user_id => self.user.id, :comment_id => self.id)
		end
		
	end
end
