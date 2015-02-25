require 'rails_helper'

describe Platform::Tokens do

  describe 'POST /token' do

    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { user.password }

    def send_token_request(params = {})
      post '/tokens', params
    end

    def token_request_params(params = {})
      {email: email, password: password}.merge(params)
    end

    context 'Error: missing params' do
      it 'returns error without required params' do
        send_token_request({})

        error_response(
            email: [Validation::REQUIRE],
            password: [Validation::REQUIRE],
        )
      end

      it 'returns error if some params are missing' do
        send_token_request({email: email})

        error_response(
            password: [Validation::REQUIRE],
        )
      end
    end

    context 'Error: wrong parameters' do

      context 'Unknown email' do
        it 'returns 401 error' do
          send_token_request(token_request_params({email: 'unknown@email'}))
          error_response(Validation::UNAUTHORIZED, 401)
        end
      end

      context 'Wrong password' do
        it 'returns 401 error' do
          send_token_request(token_request_params({password: 'wrong_password'}))
          error_response(Validation::UNAUTHORIZED, 401)
        end
      end

      context 'Another user email, correct password' do
        it 'returns 401 error' do
          another_user = create(:user)
          send_token_request(token_request_params({email: another_user.email}))
          error_response(Validation::UNAUTHORIZED, 401)
        end
      end

    end

    context 'Successful receive token' do
      it 'returns tokens data' do
        send_token_request(token_request_params)

        token = Token.first

        expect(token).to be
        expect(response.status).to eq(201)
        expect(response.body).to eq({token: {id: token.id, signature: token.signature, expired_at: token.expired_at}}.to_json)
      end
    end
  end

end