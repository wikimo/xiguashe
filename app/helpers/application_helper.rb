#encoding:utf-8
module ApplicationHelper

	def format_datetime(date_time,style)
		date_time.strftime(style) if date_time
	end
  
  def nav_helper(controller)

    html = ''
    if controller == 'topics' 
      html.concat(content_tag :li, content_tag(:a, '文章', href: topics_path), class: 'active')
    else
      html.concat(content_tag :li, content_tag(:a, '文章', href: topics_path))
    end

    if controller == 'products'
      html.concat(content_tag :li, content_tag(:a, '东西', href: products_path), class: 'active')
    else
      html.concat(content_tag :li, content_tag(:a, '东西', href: products_path))
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

  def markdown(text)
    options = {   
        :autolink => true, 
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
      }

    markdown =  Redcarpet::Markdown.new(Redcarpet::Render::HTML,options)
    markdown.render(text).html_safe
  end

end
