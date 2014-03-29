class SessionsController < ApplicationController

  before_filter :logined?, :except => [:create, :new]
  
  def new
    redirect_to root_path if current_logined?
  end

  def create

    nickname_or_email = params[:nickname_or_email]

  	@user =  User.authenticate(nickname_or_email,params[:password])

    if @user
      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token  
      end
      redirect_to root_path, notice: t(:login_success)
    else
      flash[:notice] = t(:login_fail)
      render 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to login_path, :notice  => t(:quit_success) 
  end
end
