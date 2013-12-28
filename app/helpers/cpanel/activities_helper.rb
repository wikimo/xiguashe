# coding: utf-8
module Cpanel::ActivitiesHelper

  include ActivitiesHelper
  
  def title_tag(action)
    if action == 'edit'
      "修改活动"
    else
      "创建活动"
    end
  end
end
