class GroupsController < ApplicationController

  #before_filter :logined?, :except => [:index]


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


end
