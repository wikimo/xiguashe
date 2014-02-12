# == Schema Information
#
# Table name: activities
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  content             :string(255)
#  hit_num             :integer          default(0)
#  like_num            :integer          default(0)
#  reply_num           :integer          default(0)
#  status              :integer          default(1)
#  from_url            :string(255)
#  location            :string(255)
#  user_id             :integer
#  activity_created_at :datetime
#  icon_file_name      :string(255)
#  icon_updated_at     :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  address             :string(255)
#  activity_ended_at   :datetime
#

class Activity < ActiveRecord::Base

  self.per_page = 30

  validates :title, presence: true, length: { maximum: 140 } 
  validates :content, presence: true
  validates :user_id, presence: true

  belongs_to :user

  has_attached_file :icon,
                    :styles => {
                                  thumb:  "150X100",
                                  medium: "250X150",
                                  original: "465X225"
                               },
                    :url => '/attachment/:class/:month_partition/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/attachment/:class/:month_partition/:id/:style/:basename.:extension',
                    :whiny => false

  scope :order_by_created_at_desc, order('created_at DESC') 

  scope :status_can_use, where('status = 1')

  scope :two_week_before, lambda { |time| where( "activity_created_at > ?", time ) }  

  scope :no_ended, lambda { |time| where("activity_ended_at > ? ", time) }
  
  scope :location, lambda { |location| where("location = ?", location) }

end
