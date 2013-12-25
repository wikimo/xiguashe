# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feedback < ActiveRecord::Base

	belongs_to :user


	scope :order_desc_by_created_at, order('created_at DESC')


	

end
