require 'rails_helper'

describe 'Versioning' do

  context 'No accept version header' do
    describe 'GET /version' do
      it 'returns latest version number' do
        get '/version'
        expect(response.status).to eq(400)
        expect(response.body).to eq({errors: {version: :not_provided}}.to_json)
      end
    end

  end

  context 'Existing version header' do

    describe 'GET /version' do

      context 'V2' do
        it 'returns version number' do
          get '/version', nil, {'Accept-Version' => 'v2'}

          expect(response.status).to eq(200)
          expect(response.body).to eq({version: :v2}.to_json)
        end
      end

      context 'V1' do
        it 'returns version number' do
          get '/version', nil, {'Accept-Version' => 'v1'}

          expect(response.status).to eq(200)
          expect(response.body).to eq({version: :v1}.to_json)
        end
      end

    end
  end

  context 'Unknown version header' do
    it 'returns 404' do
        expect {
          get '/version', nil, {'Accept-Version' => 'unknown'}
        }.to raise_error(ActionController::RoutingError)
    end
  end

end