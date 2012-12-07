class GroupsController < ApplicationController
  def index
    @groups =  Group.find(:all,:conditions =>['state=?',true])
  end

  def new
  	@group = Group.new
  end

  def create
  	@group =  Group.new params[:group]
    
  	if @group.save
      GroupUser.create(:group_id => @group.id, :user_id => current_user.id, :level => 2)
  		redirect_to groups_path,:notice  => 'create_group_success'
  	else
  		render 'new'
  	end
    
  end

  def show
  	
  end



end
