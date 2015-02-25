module Platform
  class Users < Grape::API

    resource :users do

      desc 'Registration'
      params do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
      end
      post do
        declared_params = declared(params)
        u = User.create!(declared_params)
        { user: {id: u.id} }
      end

      desc 'Profile info'
      get do
        authenticate!

        {user: {id: current_user.id, name: current_user.name, email: current_user.email}}
      end

    end

  end
end