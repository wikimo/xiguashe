class UsersController < ApplicationController
  def groups
    @user = User.find params[:id]

    @groups = @user.groups  
  end

  def show
  	@user =  User.find params[:id]

    #@topics =  Topic.find(:all, :conditions =>["user_id = ?",@user.id])
    @topics =  Topic.where(:user_id => @user.id).paginate(:page => params[:page]).order('id desc')
  end

  def new
    redirect_to user_path(current_user) if current_logined?
  	@user = User.new
  end

  

  def create
  	@user = User.new(params[:user])
  	@user.created_ip =  request.ip
  	if @user.save
      cookies[:auth_token] = @user.auth_token  
  		redirect_to recommend_topic_path, :notice => t(:sign_up_success)
  	else
  		render 'new'
  	end
  	
  end

  def edit
    @user = User.find(params[:id])

    @do =  params[:do]
  end

  def update
    # if params[:user][:password].blank?
    #   params[:user].delete("old_password")
    #   params[:user].delete("password")
    #   params[:user].delete("password_confirmation")
    # end

    # if params[:user][:icon].blank?
    #   params[:user].delete("icon")
    # end


    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = t(:update_success)
      redirect_to "/users/#{params[:id]}/edit?do=#{params[:do]}" 
    else
      render action: "edit"  
    end
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following.paginate(:page => params[:page]).order('id desc')

  end

  # def followers
  #   @user = User.find(params[:id])
  #   @followers = @user.followers
  # end

  def likes
    @user = User.find(params[:id]) 
    @likes =  Like.where( :likeable_type => 'Topic', :user_id => @user.id).paginate(:page => params[:page]).order('id desc')
  
    @topics = Topic.find(:all ,:conditions =>['id in (?)',@likes.map(&:likeable_id)])

  end

  def tags
    @user = User.find(params[:id]) 
    @tags = @user.tag_list
  end

  def create_tag
    @user = User.find params[:id]
    tag_list =  @user.tag_list

    if tag_list.count < 5
      @user.tag_list.add(params[:tag])
      @user.save
    end
    
    redirect_to tags_user_path(@user)
  end

  def destroy_tag
     @user = User.find params[:id]
     @user.tag_list.remove(params[:tag])
     @user.save
     
     redirect_to tags_user_path(@user)  
  end

end
