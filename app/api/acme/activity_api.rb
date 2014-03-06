module Acme
  class ActivityAPI < Grape::API

    format :json

    resource :activities do
      params do
        requires :page, type: String, desc: "page"
        requires :per_page, type: String, desc: "per_page"
        requires :id, type: String, desc: "id"
        requires :location, type: String, desc: "location"
      end

      get :index do
        @activities = Activity.status_can_use.order_by_created_at_desc.paginate(page:params[:page], per_page: params[:per_page] || 30)
      end

      get :show do
        @activity = Activity.find params[:id]
      end
      
      get :one_week_before do
        if params[:location] == "0"
          @activities = Activity.two_week_before(7.days.ago).no_ended(Time.zone.now).paginate(page:params[:page], per_page:params[:per_page] || 30)
        else
          @activities = Activity.location(params[:location]).two_week_before(7.days.ago).no_ended(Time.zone.now).paginate(page:params[:page], per_page:params[:per_page])
        end
      end

    end
  end
end
