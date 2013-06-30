class UsersController < ApplicationController
  def groups
    @user = User.find params[:id]

    @groups = @user.groups  
  end

  def show
  	@user =  User.find params[:id]

    @topics =  Topic.find(:all, :conditions =>["user_id = ?",@user.id])
  end

  def new
    redirect_to user_path(current_user) if current_logined?
  	@user = User.new
  end

  

  def create
  	@user = User.new(params[:user])
  	@user.created_ip =  request.ip
  	if @user.save
  		session[:uid] = @user.id
  		redirect_to user_path(@user), :notice => t(:sign_up_success)
  	else
  		render 'new'
  	end
  	
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("old_password")
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if params[:user][:icon].blank?
      params[:user].delete("icon")
    end


    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = t(:update_success)
      redirect_to edit_user_path @user 
    else
      render action: "edit"  
    end
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following

  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def likes
    
    
  end


end
