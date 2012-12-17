class SessionsController < ApplicationController

  def new
  end

  def create
  	user_info = params[:username] || params[:email]
  	@user =  User.authenticate(user_info,params[:password])

    if @user
      session[:uid] =  @user.id
    
      redirect_to groups_path, :notice => t(:login_success)
    else
      
      redirect_to new_session_path,:notice => t(:login_fail)
    end
  end

  def destroy
    session[:uid] = nil
    redirect_to login_path, :notice  => t(:quit_success) 
  end
end
