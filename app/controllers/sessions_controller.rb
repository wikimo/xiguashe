class SessionsController < ApplicationController

  before_filter :logined?, :except => [:create, :new]
  
  def new
    redirect_to user_path(current_user) if current_logined?
  end

  def create
  	user_info = params[:username] || params[:email]
  	@user =  User.authenticate(user_info,params[:password])

    if @user
      session[:uid] =  @user.id
    
      redirect_to user_path(@user), :notice => t(:login_success)
    else
      redirect_to new_session_path,:notice => t(:login_fail)
    end
  end

  def destroy
    session[:uid] = nil
    redirect_to login_path, :notice  => t(:quit_success) 
  end
end
