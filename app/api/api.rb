class API < Grape::API
  prefix 'api'
  mount Acme::Ping
end
