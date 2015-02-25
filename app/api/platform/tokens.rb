module Platform
  class Tokens < Grape::API

    resource :tokens do

      desc 'Receive token'
      params do
        requires :email, type: String
        requires :password, type: String
      end

      post do
        declared_params = declared(params)
        user = User.find_by_email(declared_params[:email]).try(:authenticate, declared_params[:password])
        error!({errors: Validation::UNAUTHORIZED}, 401) unless user

        token = user.tokens.create!
        {token: {id: token.id, signature: token.signature, expired_at: token.expired_at}}
      end

    end

  end
end