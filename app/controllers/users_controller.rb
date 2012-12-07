class UsersController < ApplicationController
  def show
  	@user =  User.find params[:id]
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	@user.created_ip =  request.ip
  	if @user.save
  		session[:uid] = @user.id
  		redirect_to @user, :notic => t(:sign_up_success)
  	else
  		render 'new'
  	end
  	
  end
end
