class GroupsController < ApplicationController

  before_filter :logined?, :except => [:index]


  def index
    @groups =  Group.find(:all,:conditions =>['state=?',true])
  end

  def new
  	@group = Group.new
  end

  def create
  	@group =  Group.new params[:group]
    
  	if @group.save
      #GroupUser.create(:group_id => @group.id, :user_id => current_user.id, :level => 2)
  		redirect_to groups_path,:notice  => 'create_group_success'
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

    redirect_to group_topics_path(@group)
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

    redirect_to group_topics_path(@group)
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


end
