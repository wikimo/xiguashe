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

  def status_tag(status, label_1, label_2)
     if status == 0
        label_1
     elsif status == 1
        label_2
     end
  end
end
