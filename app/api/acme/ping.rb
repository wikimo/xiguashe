module Acme
  class Ping < Grape::API
    format :json
    get :ping do
      { ping: params[:pong] || 'pingong'}
    end
    
    get :activities do
      @activities = Activity.status_can_use.order_by_created_at_desc
    end
  end
end
