#encoding:utf-8
module NotificationsHelper

  def mention_id_helper(mention_id)
    mention_id.nil? ? '评论' : '艾特'
  end

  def is_read_helper(notification, &block)
    block.call unless notification.try(:is_read?)
  end

end
