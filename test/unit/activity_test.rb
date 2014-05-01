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

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
