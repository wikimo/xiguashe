# coding: utf-8

module ActivitiesHelper

  def location_helper(activity)
    if activity.location == '0'
      '全部'
    elsif activity.location == '1'
      '宁波'
    elsif activity.location == '2'
      '嘉兴'
    end
  end

end
