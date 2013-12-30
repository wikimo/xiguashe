module XiGuaShe
  class API < Grape::API
    prefix "api"
    error_format :json

    helper APIHelpers
    
    resource :activities d:w

    end
  end
end
