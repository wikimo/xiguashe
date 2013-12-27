#coding: utf-8
class Cpanel::ActivitiesController < Cpanel::ApplicationController

  def index
    @activities = Activity.order_by_created_at_desc
  end

  def new
    @activity = Activity.new
    @location = [['全部',0], ['宁波',1], ['嘉兴',2]]
  end

  def show
    @activity = Activity.find params[:id]
  end

  def create
    @activity = current_user.activities.build params[:activity]
    
    if @activity.save
      redirect_to cpanel_activities_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
  end

  def destroy
  end
end
