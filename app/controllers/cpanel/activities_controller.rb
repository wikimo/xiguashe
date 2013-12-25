#coding: utf-8
class Cpanel::ActivitiesController < Cpanel::ApplicationController

  def index
    @activities = Activity.order_by_created_at_desc
  end

  def new
    @activity = Activity.new
    @province = [['浙江', 1]]
    @city = [['宁波', 1], ['嘉兴',2]]
    @area = [['鄞州', 1],['test2',2]]
  end

  def show
    @activity = Activity.find params[:id]
  end

  def create
    p params[:activity]

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
