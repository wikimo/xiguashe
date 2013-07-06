class HomeController < ApplicationController
	def index
		#@topics =  Topic.find(:all,:limit => 10,:order => 'id desc')
		@recent_topics =  Topic.find(:all,:limit => 2,:order =>'id desc')
		recent_tids =  @recent_topics.map(&:id)

		today =  Date.today
		@like_topics = Topic.find(:all,:conditions => ['created_at >= ? and created_at <=? and id not in(?)',(today - 7),(today + 1),recent_tids],:limit => 10,:order => 'like_num desc,id desc')
	end
end
