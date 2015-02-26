module Platform
  class Users < Grape::API

    resource :users do

      desc 'Registration'
      params do
        requires :name, type: String, desc: 'User name'
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end
      post rabl: 'users/post' do
        declared_params = declared(params)
        @user = User.create!(declared_params)
      end

      desc 'Profile info'
      get rabl: 'users/get' do
        authenticate!
        @user = current_user
      end

    end

  end
end