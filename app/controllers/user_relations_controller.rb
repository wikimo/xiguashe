class UserRelationsController < ApplicationController

	def create
    @user = User.find(params[:followed_id])
    current_user.follow!(@user)

    respond_to :js
  end

  def destroy
    @user = User.find(params[:followed_id])
    current_user.unfollow!(@user)

    respond_to :js
  end
end
