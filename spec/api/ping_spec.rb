require 'rails_helper'

describe Platform::Ping do

  describe 'GET /api/ping' do
    it 'returns pong' do
      get '/ping'
      expect(response.status).to eq(200)
      expect(response.body).to eq({ping: :pong}.to_json)
    end

    it 'returns user pong param' do
      get '/ping', {pong: 'bebe'}
      expect(response.status).to eq(200)
      expect(response.body).to eq({ping: :bebe}.to_json)
    end

  end

end