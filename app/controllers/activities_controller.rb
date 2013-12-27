class ActivitiesController < ApplicationController

  def index
    @activities = Activity.order_by_created_at_desc
  end

  def show
    @activity = Activity.find params[:id]
    p @activity
  end

end
