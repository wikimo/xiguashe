#encoding:utf-8
module UsersHelper

	def user_nav_helper(user,action = 'show')
		html = ''

		if current_user == user 
			if action == 'show'
				html.concat(content_tag :li, content_tag(:a ,'参与讨论',href: topics_user_path(@user), "data-remote" => true, "data-toggle" => "tab"), class: 'active')
			else
				html.concat(content_tag :li, content_tag(:a ,'参与讨论',href: topics_user_path(@user), "data-remote" => true, "data-toggle" => "tab"))
			end


      if action == 'like'
        html.concat(content_tag :li, content_tag(:a, '我的喜欢', href: likes_user_path(@user), "data-remote" => true, "data-toggle" => "tab"), class: 'active')
      else
        html.concat(content_tag :li, content_tag(:a, '我的喜欢', href: likes_user_path(@user), "data-remote" => true, "data-toggle" => "tab"))
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
	      html.concat(content_tag(:li,content_tag(:a ,'修改密码',:href => "/users/#{user_id}/edit?do=passwd"),:class => 'active'))
	    else
	      html.concat(content_tag(:li,content_tag(:a ,'修改密码',:href => "/users/#{user_id}/edit?do=passwd")))
	    end

	    raw html
	end

  def params_do_helper(params='profile')
    if params == 'profile'
      render partial: 'profile', locals: { user: @user }
    else
      render partial: 'password', locals: { user: @user } 
    end
  end

end
