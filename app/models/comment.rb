# coding: utf-8
class Comment < ActiveRecord::Base

	belongs_to :commentable, :polymorphic => true

	belongs_to :user

	belongs_to :parent, :class_name => "Comment"

	has_many   :replies,  :class_name => "Comment", :foreign_key => "reply_parent_id"


	has_many :notifications, :as => :notificationable, :dependent => :destroy

	scope :order_desc_by_created_at, order("created_at desc")

	after_create :send_comment_notification
  
	def send_comment_notification
    mention_users = match_user_test(self.content)
    p "mention_users "
    p mention_users
    
  	mention_ids = []
  	
	  if mention_users.any?
	    mention_users.each do |mention_user|
	      user = User.where(:nickname => mention_user).first
	      
	      if mention_ids.any?
	        mention_ids.each do |id|
  	        if user.id == id
  	          break
  	        else
              mention_ids << user.id
            end
          end
        else
          mention_ids << user.id
        end

      end
    end
    
    p "mention_ids"
    p mention_ids
    
		if self.commentable_type != nil
			if self.user != self.commentable.user 
				Notification.create(:user => self.commentable.user, :notificationable => self)
			end
      
			if !mention_ids.include?(self.commentable.user.id)
				mention_ids.each do |mention_id|
					Notification.create(:user => self.commentable.user, :notificationable => self, :mention_id => mention_id)
				end
			end
		end
	end


	def match_user_test(str)

		arr = str.scan(/@([\p{Han}+\w]{2,20}\s)/u).flatten

	end
	
end
