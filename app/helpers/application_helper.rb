#encoding:utf-8
module ApplicationHelper

	def format_datetime(date_time,style)
		date_time.strftime(style) if date_time
	end
  
  def nav_helper(controller)

    html = ''
    if controller == 'topics' 
      html.concat(content_tag :li, content_tag(:a, '话题', href: topics_path), class: 'active')
    else
      html.concat(content_tag :li, content_tag(:a, '话题', href: topics_path))
    end

    if controller == 'products'
      html.concat(content_tag :li, content_tag(:a, '分享', href: products_path), class: 'active')
    else
      html.concat(content_tag :li, content_tag(:a, '分享', href: products_path))
    end

    if controller == 'activities'
      html.concat(content_tag :li, content_tag(:a, '活动', href: activities_path), class: 'active')
    else
      html.concat(content_tag :li, content_tag(:a, '活动', href: activities_path))
    end

    raw html

  end

  def user_avatar_helper(user)
    if user.avatar
      image_tag user.avatar.url('100x100'), alt:user.nickname
    else
      image_tag 'avatar.jpg', alt:user.nickname
    end
  end

end
