module Platform
  module V1
    class Version < Grape::API
      desc 'Returns version'
      resource :version do
        get do
          { version: 'v1' }
        end
      end
    end
  end
end