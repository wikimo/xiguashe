class SessionsController < ApplicationController

  before_filter :logined?, :except => [:create, :new]
  
  def new
    redirect_to user_path(current_user) if current_logined?
  end

  def create
  	user_info = params[:username] || params[:email]
  	@user =  User.authenticate(user_info,params[:password])

    if @user
      # session[:uid] =  @user.id

      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token  
      end
      p @user
      
      redirect_to user_path(@user), :notice => t(:login_success)
    else
      flash[:notice] =  t(:login_fail)
      render 'new'
    end
  end

  def destroy
    # session[:uid] = nil
    cookies.delete(:auth_token)
    redirect_to login_path, :notice  => t(:quit_success) 
  end
end
