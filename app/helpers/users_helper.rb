#encoding:utf-8
module UsersHelper

	def user_nav_helper(user,action)
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

	def profile_nav(user_id,action = 'passwd')
	    html = ''
	    if action == 'passwd'
	      html.concat(content_tag(:li,content_tag(:a ,'修改密码',:href => "/users/#{user_id}/edit?do=passwd"),:class => 'active'))
	    else
	      html.concat(content_tag(:li,content_tag(:a ,'修改密码',:href => "/users/#{user_id}/edit?do=passwd")))
	    end

	    if action == 'avatar'
	      html.concat(content_tag(:li,content_tag(:a ,'更新头像',:href => "/users/#{user_id}/edit?do=avatar"),:class => 'active'))
	    else
	      html.concat(content_tag(:li,content_tag(:a ,'更新头像',:href => "/users/#{user_id}/edit?do=avatar")))
	    end

      if action == 'nickname'
        html.concat(content_tag(:li, content_tag(:a ,'修改昵称',:href => "/users/#{user_id}/edit?do=nickname"), :class => 'active'))
      else
        html.concat(content_tag(:li, content_tag(:a , '修改昵称', :href => "/users/#{user_id}/edit?do=nickname")))
      end
	    raw html
	end
end
