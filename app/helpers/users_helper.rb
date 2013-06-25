#encoding:utf-8
module UsersHelper

	def user_nav(user,action)
		html = ''

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

		html.concat(content_tag(:a ,'收藏'))

		raw html
	end
end
