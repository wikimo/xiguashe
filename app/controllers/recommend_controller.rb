class RecommendController < ApplicationController

  before_filter :logined?

  def topic
  	@topics = Topic.recommend(params[:page], Topic.per_page)
  end

  def user
  	#判断当前用户是否有关注人，若有，则显示关注人的动态，若没有，则显示最新用户的动态
  	if current_user.following.count > 0

  		@topics = Topic.recommend_user_topic(current_user.following.map(&:id), params[:page], Topic.per_page)

  	else

      @topics = Topic.recommend_user_topic(current_user.last_ten_user.map(&:id), params[:page], Topic.per_page)

  	end
  end

  def group
    @groups = Group.recommend(params[:page], Group.per_page)
  end
end
