# == Schema Information
#
# Table name: user_relations
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserRelation < ActiveRecord::Base
	attr_accessible :followed_id

	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name  => "User"

	validates :follower_id, :presence => true
	validates :followed_id, :presence => true
end
