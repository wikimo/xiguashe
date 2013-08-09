class HomeController < ApplicationController
	before_filter :login_redirect

	def index
		#@topics =  Topic.find(:all,:limit => 10,:order => 'id desc')
		@recent_topics =  Topic.recent_topics
		recent_tids =  @recent_topics.map(&:id)

		@like_topics = Topic.like_topics(recent_tids)
		
	end
end
