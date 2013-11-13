#encoding:utf-8
module RecommendHelper
	def recommend_nav(action)
		html = ''
		if action == 'topic'
			html.concat(content_tag(:a ,'推荐话题',:href => recommend_topic_path,:class => 'active'))
		else
			html.concat(content_tag(:a ,'推荐话题',:href => recommend_topic_path))
		end
	
		if action == 'group'
			html.concat(content_tag(:a ,'推荐小组',:href => recommend_group_path,:class => 'active'))
		else
			html.concat(content_tag(:a ,'推荐小组',:href => recommend_group_path))
		end

		if action == 'user'
			html.concat(content_tag(:a ,'我的关注',:href => recommend_user_path,:class => 'active'))
		else
			html.concat(content_tag(:a ,'我的关注',:href => recommend_user_path))
		end
		
		raw html
	end
end
