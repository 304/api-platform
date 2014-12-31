class API < Grape::API
  format :json
  mount Platform::Ping
end