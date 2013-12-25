# == Schema Information
#
# Table name: notifications
#
#  id                    :integer          not null, primary key
#  notificationable_id   :integer
#  notificationable_type :string(255)
#  user_id               :integer
#  is_read               :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  mention_id            :integer
#

class Notification < ActiveRecord::Base

  self.per_page = 30
  
	belongs_to :notificationable, :polymorphic => true

	belongs_to :user

	belongs_to :mention, :class_name => "User"
  
  	scope :except_mention, where("mention_id is null")
  	
	scope :recent_notifications, order("created_at desc")

	scope :unread_notifications, where("is_read = false")


end
