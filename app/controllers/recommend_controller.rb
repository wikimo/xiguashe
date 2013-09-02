class RecommendController < ApplicationController

  before_filter :logined?

  def topic
  	@topics = Topic.recommend(params[:page])
  end

  def user
  	#判断当前用户是否有关注人，若有，则显示关注人的动态，若没有，则显示最新用户的动态
  	p "test: #{current_user.following.count}"
  	if current_user.following.count > 0

  		@topics = Topic.following_topic(current_user.following.map(&:id), params[:page])

  		p @topics.count
  	else

  	end
  end

  def group

  end
end
