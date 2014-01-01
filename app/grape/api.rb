require "entities"
require "helpers"

module Xiguashe
  class API < Grape::API
    prefix "api"
    format :json
    
    resource :activities do
      get do
        @activities = Activities.status_can_use.order_by_created_at_desc.paginate(page: params[:page], per_page: params[:per_page] || 30)
        present @activities, with: APIEntities::Activity
      end

    end
  end
end
