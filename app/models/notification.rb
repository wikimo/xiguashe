class Notification < ActiveRecord::Base


	belongs_to :notificationable, :polymorphic => true

	belongs_to :user

	belongs_to :mention, :class_name => "User"

	scope :recent_notifications, order("created_at desc")

	scope :unread_notifications, where("is_read = false")
end
