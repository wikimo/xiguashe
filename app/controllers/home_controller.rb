class HomeController < ApplicationController
	before_filter :login_redirect, :except => [:about,:contact,:links]

	def index
		#@topics =  Topic.find(:all,:limit => 10,:order => 'id desc')
		# @recent_topics =  Topic.recent_topics
		# recent_tids =  @recent_topics.map(&:id)

		# @like_topics = Topic.like_topics(recent_tids)
		redirect_to recommend_topic_path
		
	end

	def about
		
	end

	def contact
		
	end

	def links
		
	end
end
