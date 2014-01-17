class ActivitiesController < ApplicationController

  def index
    @activities = Activity.status_can_use.order_by_created_at_desc.paginate(page: params[:page], per_page: Activity.per_page || 30)
  end

  def show
    @activity = Activity.find params[:id]
    @activity.update_attributes(hit_num: @activity.hit_num + 1)
  end

end
