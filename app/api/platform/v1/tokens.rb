module Platform
  module V1
    class Tokens < Grape::API
      resource :tokens do

        desc 'Receive token'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end

        post rabl: 'tokens/post' do
          declared_params = declared(params)
          user = User.find_by_email(declared_params[:email]).try(:authenticate, declared_params[:password])
          error!({errors: Validation::UNAUTHORIZED}, 401) unless user

          @token = user.tokens.create!
        end

      end
    end
  end
end