require 'rails_helper'

describe Platform::Users do

  describe 'POST /users' do

    let(:name) { 'Test Name' }
    let(:email) { 'valid@email.com' }
    let(:password) { 'valid_pa$$w0rd' }


    def send_registration_request(params = {})
      post '/users', params
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
      it 'returns error email already in-use' do
        send_registration_request(registration_params)
        expect(response.status).to eq(201)

        send_registration_request(registration_params)
        error_response(
            email: [Validation::ALREADY_TAKEN],
        )
      end
    end

  end

end