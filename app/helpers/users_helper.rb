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
end
