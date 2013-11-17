class UsersController < ApplicationController

  before_filter :find_user, :except => [:new, :create]
  before_filter :logined?, :only => [:edit, :update,:create_tag, :destroy_tag]

  def groups
    @groups = @user.groups  
  end

  def show
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
    @do =  params[:do]
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = t(:update_success)
      redirect_to "/users/#{params[:id]}/edit?do=#{params[:do]}" 
    else
      render action: "edit"  
    end
  end

  def following
    @following = @user.following.paginate(:page => params[:page]).order('id desc')

  end

  # def followers
  #   @user = User.find(params[:id])
  #   @followers = @user.followers
  # end

  def likes
    @likes =  Like.where( :likeable_type => 'Topic', :user_id => @user.id).paginate(:page => params[:page]).order('id desc')
  
    @topics = Topic.find(:all ,:conditions =>['id in (?)',@likes.map(&:likeable_id)])

  end

  def tags
    @tags = @user.tag_list
  end

  def create_tag
    tag_list =  @user.tag_list

    if tag_list.count < 5
      @user.tag_list.add(params[:tag])
      @user.save
    end
    
    redirect_to tags_user_path(@user)
  end

  def destroy_tag
     @user.tag_list.remove(params[:tag])
     @user.save
     
     redirect_to tags_user_path(@user)  
  end

  protected
    def find_user
      @user =  User.where(:id => params[:id]).first

      render_404 if @user.nil?
    end
end
