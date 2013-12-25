class ActivitiesController < ApplicationController

  def index
    @activities = Activites.order_by_created_at_desc
  end

end
