#encoding:utf-8
module UsersHelper

	def user_nav(user,action)
		html = ''

		if current_user == user 
			if action == 'show'
				html.concat(content_tag(:a ,'话题',:href => user_path(user),:class => 'active'))
			else
				html.concat(content_tag(:a ,'话题',:href => user_path(user)))
			end
		
			if action == 'groups'
				html.concat(content_tag(:a ,'小组',:href => groups_user_path(user),:class => 'active'))
			else
				html.concat(content_tag(:a ,'小组',:href => groups_user_path(user)))
			end

			if action == 'following'
				html.concat(content_tag(:a ,'关注',:href => following_user_path(user),:class => 'active'))
			else
				html.concat(content_tag(:a ,'关注',:href => following_user_path(user)))
			end

			if action == 'likes'
				html.concat(content_tag(:a ,'喜欢',:href => likes_user_path(user),:class => 'active'))
			else
				html.concat(content_tag(:a ,'喜欢',:href => likes_user_path(user)))
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
