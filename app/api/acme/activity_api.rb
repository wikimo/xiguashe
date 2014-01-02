module Acme
  class ActivityAPI < Grape::API

    format :json

    resource :activities do
      params do
        requires :page, type: String, desc: "page"
        requires :per_page, type: String, desc: "per_page"
        requires :id, type: String, desc: "id"
      end

      get :index do
        @activities = Activity.status_can_use.order_by_created_at_desc.paginate(page:params[:page], per_page: params[:per_page])
      end

      get :show do
        @activity = Activity.find params[:id]
      end

    end
  end
end
