# == Schema Information
#
# Table name: group_users
#
#  id         :integer          not null, primary key
#  group_id   :integer          default(0)
#  user_id    :integer          default(0)
#  level      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default(0)
#

class GroupUser < ActiveRecord::Base

	belongs_to :groups
	belongs_to :users
	
end
