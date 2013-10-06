class GroupsController < ApplicationController

  before_filter :logined?, :except => [:index,:discovery]


  def index

  end


  def discovery

    if params[:category_id] == "0"
      @groups = Group.last_groups(params[:page], Group.per_page)

      @categories = Category.all
    else
      @categories = Category.all

      @category = Category.find(params[:category_id])

      @groups = @category.groups.using_groups.paginate(:page => params[:page]).order_by_created_at_desc

    end
    
  end

  def new
  	@group = Group.new

    #used in select
    @categories_array = Category.find(:all, :conditions => ['is_use = ?', true ]).collect {|c| [c.name, c.id]}
  end

  def create
  	@group =  Group.new params[:group]
    
  	if @group.save

      @gu = GroupUser.create(:group_id => @group.id, :user_id => current_user.id, :level => 2)

      if @gu.save
  		  redirect_to discovery_category_groups_path(0),:notice  => t(:create_group_success)
      end
  	else
  		render 'new'
  	end
    
  end

  def show
  	
    @group = Group.find params[:id]
  end


  def join
    @group = Group.find(params[:id])

    GroupUser.create(:group_id => @group.id, :user_id => current_user.id, :level => 0)

    @group.update_attributes({:member_num => @group.member_num + 1})

    redirect_to group_topics_path(@group), :notice => t(:join_group_success)
  end

  def leave
    
    @group = Group.find(params[:id])

    GroupUser.find_by_group_id_and_user_id(params[:id], current_user.id).destroy

    @group.update_attributes({:member_num => @group.member_num - 1}) if @group.member_num > 0
    
    redirect_to group_topics_path(@group)
  end

  def apply

    @group = Group.find(params[:id])

    @gu = GroupUser.find_by_group_id_and_user_id(params[:id], current_user.id)

    @gu.update_attributes({:status => 1})

    redirect_to group_topics_path(@group), :notice => t(:has_applied)
  end

  def applyers
    
    @group = Group.find(params[:id])

    @users = @group.applyers

    
  end

  def audit
    

    @group = Group.find(params[:id])

    @gu = GroupUser.find_by_group_id_and_user_id(params[:id], params[:user_id])

    if "2" == params[:status]
      @gu.update_attributes({:level => 1, :status => params[:status]})
    else
      @gu.update_attributes({:status => params[:status]})
    end

    redirect_to applyers_group_path(@group)

  end
  
  def members
    @group = Topic.find(params[:topic_id]).group
    @members = @group.members
    
    render :json => @members
  end

  def edit
    @group = Group.find params[:id]
  end

  def update
    @group =  Group.find params[:id]

    if @group.update_attributes(params[:group])
      flash[:notice] = t(:update_success)
      redirect_to group_topics_path @group 
    else
      render 'edit'
    end
  end


end
