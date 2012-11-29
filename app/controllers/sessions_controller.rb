class SessionsController < ApplicationController

  def new
  end

  def create
  	user_info = params[:username] || params[:email]
  	@user =  User.authenticate(user_info,params[:password])

    if @user
      session[:uid] =  @user.id
      puts 'ok'
    else
      puts 'user info error'
    end
  end
end
