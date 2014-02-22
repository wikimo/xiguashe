#encoding:utf-8
module UsersHelper

	def user_nav_helper(user,action = 'topics')
		html = ''

		if current_user == user 
			if action == 'topics'
				html.concat(content_tag :li, content_tag(:a ,'我的文章',href: "/users/#{user.id}?do=topics"), class: 'active')
			else
				html.concat(content_tag :li, content_tag(:a ,'我的文章',href: "/users/#{user.id}?do=topics"))
			end


      if action == 'likes'
        html.concat(content_tag :li, content_tag(:a, '我的喜欢', href: "/users/#{user.id}?do=likes"), class: 'active')
      else
        html.concat(content_tag :li, content_tag(:a, '我的喜欢', href: "/users/#{user.id}?do=likes"))
      end

		end
		

		raw html
	end

	def profile_nav(user_id,action)

	    html = ''

      if action == 'profile'
        html.concat(content_tag(:li, content_tag(:a, '基本资料', href: "/users/#{user_id}/edit?do=profile"),class: 'active'))
      else
        html.concat(content_tag(:li, content_tag(:a, '基本资料', href: "/users/#{user_id}/edit?do=profile")))
      end

	    if action == 'passwd'
	      html.concat(content_tag(:li,content_tag(:a ,'修改密码',href: "/users/#{user_id}/edit?do=passwd"),class: 'active'))
	    else
	      html.concat(content_tag(:li,content_tag(:a ,'修改密码',href: "/users/#{user_id}/edit?do=passwd")))
	    end

	    raw html
	end

  def params_do_helper(action, params)
    if action == 'edit'
      !params.nil? ? params : "profile"
    elsif action == 'show'
      !params.nil? ? params : "topics"
    end
  end

end
