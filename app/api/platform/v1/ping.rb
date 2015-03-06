module Platform
  module V1
    class Ping < Grape::API
      desc 'Returns pong.'
      get :ping, rabl: 'ping/get' do
        @pong = params[:pong] || 'pong'
      end
    end
  end
end