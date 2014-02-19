class UsersController < ApplicationController

  before_filter :find_user, :except => [:new, :create]
  before_filter :logined?, :only => [:edit, :update,:create_tag, :destroy_tag]


  def show
    @topics = @user.topics.paginate(page: params[:page])
  end

  def topics
    @topics = @user.topics.paginate(page: params[:page])
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
      message = ''
      @user.errors.full_messages.each do |msg|
        message << msg
      end
      flash[:notice] = message
      redirect_to "/users/#{params[:id]}/edit?do=#{params[:do]}"
    end
  end

  def following
    @following = @user.following.paginate(:page => params[:page]).order('id desc')

  end

  def likes
    @likes = @user.likes('Topic')
    @topics = Topic.by_ids(@likes.map(&:likeable_id))
  end

  protected
    def find_user
      @user =  User.where(:id => params[:id]).first

      render_404 if @user.nil?
    end
end
