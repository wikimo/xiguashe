#encoding:utf-8
module NotificationsHelper

  def mention_id_helper(mention_id)

    mention_id.nil? ? '评论' : '提及'
  
  end
end
