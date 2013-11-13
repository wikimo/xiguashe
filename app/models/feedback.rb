class Feedback < ActiveRecord::Base

	belongs_to :user


	scope :order_desc_by_created_at, order('created_at DESC')


	

end
