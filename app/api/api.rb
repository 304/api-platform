class API < Grape::API
  format :json
  helpers AuthHelpers

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    errors = e.errors.map { |k, v| [k.first, v]}.to_h
    rack_response({errors: errors}.to_json, 400)
  end

  rescue_from ActiveRecord::ActiveRecordError do |e|
    errors = e.record.errors.messages.map { |k, v| [k, v]}.to_h
    rack_response({errors: errors}.to_json, 400)
  end

  mount Platform::Ping
  mount Platform::Users
  mount Platform::Tokens
end