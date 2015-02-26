require 'rails_helper'

describe 'Authentication' do

  let(:user) { create(:user) }

  def request_with_authorization(access_id, secret_key)
    if access_id && secret_key
      signed_get_v1 '/users', access_id: access_id, secret_key: secret_key
    else
      get_v1 '/users'
    end
  end

  describe 'Need auth' do
    let(:valid_token) { create(:token, user: user) }
    let(:expired_token) { create(:token, :expired, user: user).reload }

    context 'No token' do
      it 'returns 401 error' do
        request_with_authorization(nil, nil)
        expect(response.status).to eq(401)
        expect(response.body).to eq({errors: :unauthorized}.to_json)
      end
    end

    context 'Wrong access id' do
      it 'returns 401 error' do
        request_with_authorization('wrong_access_id', valid_token.signature)
        expect(response.status).to eq(401)
        expect(response.body).to eq({errors: :unauthorized}.to_json)
      end
    end

    context 'Wrong secret key' do
      it 'returns 401 error' do
        request_with_authorization(valid_token.id, 'wrong_secret_key')
        expect(response.status).to eq(401)
        expect(response.body).to eq({errors: :unauthorized}.to_json)
      end
    end

    context 'Expired token' do
      it 'returns 401 error' do
        request_with_authorization(expired_token.id, expired_token.signature)
        expect(response.status).to eq(401)
        expect(response.body).to eq({errors: :unauthorized}.to_json)
      end
    end

    context 'Valid token' do
      it 'returns 200' do
        request_with_authorization(valid_token.id, valid_token.signature)
        expect(response.status).to eq(200)
      end
    end

    context 'Only the latest token is valid' do
      it 'returns 401 for old token' do
        old_token = create(:token, user: user)
        new_token = create(:token, user: user)

        request_with_authorization(old_token.id, old_token.signature)
        expect(response.status).to eq(401)
        expect(response.body).to eq({errors: :unauthorized}.to_json)
      end

      it 'returns 200 for new token' do
        old_token = create(:token, user: user)
        new_token = create(:token, user: user)

        request_with_authorization(new_token.id, new_token.signature)
        expect(response.status).to eq(200)
      end
    end
  end

end