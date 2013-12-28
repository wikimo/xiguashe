#coding: utf-8
class Cpanel::ActivitiesController < Cpanel::ApplicationController
  
  before_filter :location, only: [:new, :edit]
  before_filter :find_activity, only: [:show, :edit, :update, :destroy]

  def index
    @activities = Activity.order_by_created_at_desc.paginate(page:params[:page], per_page: Activity.per_page || 30)
  end

  def new
    @activity = Activity.new
  end

  def show

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
    if @activity.update_attributes(params[:activity])
      redirect_to cpanel_activities_path, notice: t(:update_success)
    else
      render 'edit'
    end

  end

  def destroy
    @activity.destroy
    redirect_to cpanel_activities_path, notice: t(:delete_success)
  end

  private 

    def find_activity
      @activity = Activity.find params[:id]
    end

    def location
      @location = [['全部',0], ['宁波',1], ['嘉兴',2]]
    end
end
