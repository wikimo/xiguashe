class HomeController < ApplicationController
	def index
		#@topics =  Topic.find(:all,:limit => 10,:order => 'id desc')
		@recent_topics =  Topic.recent_topics
		recent_tids =  @recent_topics.map(&:id)

		today =  Date.today
		@like_topics = Topic.like_topics(today, recent_tids)
	end
end
