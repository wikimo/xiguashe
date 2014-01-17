class API < Grape::API
  prefix 'api'
  mount Acme::ActivityAPI
end
