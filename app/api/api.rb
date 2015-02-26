class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::Rabl
  helpers AuthHelpers

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    errors = e.errors.map { |k, v| [k.first, v]}.to_h
    rack_response({errors: errors}.to_json, 400)
  end

  rescue_from ActiveRecord::ActiveRecordError do |e|
    errors = e.record.errors.messages.map { |k, v| [k, v]}.to_h
    rack_response({errors: errors}.to_json, 400)
  end

  # version header is required
  before do
    error!({errors: {version: :not_provided}}, 400) unless headers['Accept-Version']
  end

  # order is matter
  mount Platform::ApiV2
  mount Platform::ApiV1
end