require 'rails_helper'

describe Platform::V1::Users do

  describe 'POST /users' do

    let(:name) { 'Test Name' }
    let(:email) { 'valid@email.com' }
    let(:password) { 'valid_pa$$w0rd' }


    def send_registration_request(params = {})
      post_v1 '/users', params
    end

    def registration_params(params = {})
      {name: name, email: email, password: password}.merge(params)
    end

    context 'Error: missing params' do
      it 'returns error without required params' do
        send_registration_request({})

        error_response(
            name: [Validation::REQUIRE],
            email: [Validation::REQUIRE],
            password: [Validation::REQUIRE],
        )
      end

      it 'returns error if some params are missing' do
        send_registration_request({name: name})

        error_response(
            email: [Validation::REQUIRE],
            password: [Validation::REQUIRE],
        )
      end
    end

    context 'Successful registration' do
      it 'returns user external id' do
        send_registration_request(registration_params)

        user = User.first

        expect(user).to be
        expect(response.status).to eq(201)
        expect(response.body).to eq({user: {id: user.id}}.to_json)
      end
    end

    context 'Re-registration' do
      it 'returns error email alrkeady in-use' do
        send_registration_request(registration_params)
        expect(response.status).to eq(201)

        send_registration_request(registration_params)
        error_response(
            email: [Validation::ALREADY_TAKEN],
        )
      end
    end

  end

  describe 'GET /users' do

    context 'Profile info' do
      let(:user) { create(:user, :with_token) }

      it 'returns current user info' do
        signed_get_v1 '/users', token: user.tokens.first

        expect(response.status).to eq(200)
        expect(response.body).to eq({user: {id: user.id, name: user.name, email: user.email}}.to_json)
      end

    end

  end

end